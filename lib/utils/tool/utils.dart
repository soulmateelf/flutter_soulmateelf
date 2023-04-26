import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class Utils {
  ///判断值为空
  static bool isEmpty(dynamic value) {
    if (value == null || value == '') {
      return true;
    } else {
      return false;
    }
  }

  ///页面空值默认显示方式
  static String defaultValue(dynamic value, {omit = '--'}) {
    if (isEmpty(value)) {
      return omit;
    } else {
      return insertBreakWord(value.toString());
    }
  }

  /// Author trevor
  /// Date 2021/1/26 5:50 PM
  /// Description 将每个字符串之间插入零宽空格(TextOverflow.ellipsis 会将长字母、数字串整体显示省略)
  /// param
  /// return
  /// UpdateUser trevor
  /// UpdateDate 2021/1/26 5:50 PM
  /// UpdateRemark
  static String insertBreakWord(String word) {
    if (isEmpty(word)) {
      return word;
    }
    String breakWord = ' ';
    word.runes.forEach((element) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    });
    return breakWord;
  }

  /// 获取文件的大小
  static List getFileSize(String filepath, [int decimals = 0]) {
    File file = File(filepath);
    int bytes = file.lengthSync();
    if (bytes <= 0) return [];
    const List suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    int i = (log(bytes) / log(1024)).floor();
    return [
      double.parse((bytes / pow(1024, i)).toStringAsFixed(decimals)),
      suffixes[i],
      i
    ];
  }

  /// 拨打电话
  static void callSomeone(String tel) async {
    if (!isEmpty(tel)) {
      var url = 'tel:' + tel;
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        Loading.toast('拨打电话 $tel 失败！');
      }
    }
  }

  /// 打开网页
  static void openPage(String path) async {
    if (!isEmpty(path)) {
      if (await canLaunchUrl(Uri.parse(path))) {
        await launchUrl(Uri.parse(path));
      } else {
        Loading.toast('打开网页 $path 失败！');
      }
    }
  }

  /// Author: kele
  /// Date: 2022-03-18 17:02:26
  /// Params:
  /// Return:
  /// Description: 退出登录,多处调用
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:
  static void logout() {
    Loading.show();
    successFn(res) {
      Loading.dismiss();
      Application.clearStorage().then((type) {
        Get.offAllNamed('/welcome');
      });
    }

    errorFn(error) {
      Loading.dismiss();
      Loading.toast(error['message'],
          toastPosition: EasyLoadingToastPosition.top);
    }

    NetUtils.diorequst('/base/logout', 'post',
        successCallBack: successFn,
        errorCallBack: errorFn,
        extra: {"isUrlencoded": true});
  }

  /// 分享
  static void share(String path, String imagePath,
      {Function? successCallBack}) async {
    if (isEmpty(path) || isEmpty(imagePath)) {
      Loading.toast('no path or imagePath');
      return;
    }
    final data = await rootBundle.load(imagePath);
    final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'icyberelf.png',
          mimeType: 'image/png',
        ),
      ],
      subject: 'icyberelf',
      text: path,
    );
    if (shareResult.status == ShareResultStatus.success) {
      successCallBack?.call();
    }
  }

  ///权限判断
  static Future<bool> checkPremission(Permission permission) async {
    if (isEmpty(permission)) return false;
    var status = await permission.status;
    if (status.isDenied) {
      /// 没有权限,但是还可以请求权限
      var result = await permission.request();
      if (result.isPermanentlyDenied) {
        /// 没有权限,并且不能请求权限
        return false;
      } else {
        return true;
      }
    } else if (status.isPermanentlyDenied) {
      /// 没有权限,并且不能请求权限,需要用户手动打开权限
      showAlertDialog(
        context: Get.context!,
        title: 'tips',
        message:
            "you don't have permission to access this feature[${permission.toString()}], please open it in the settings]",
        actions: <AlertDialogAction>[
          const AlertDialogAction(
            label: 'Cancel',
            key: 0,
            isDestructiveAction: true,
          ),
          const AlertDialogAction(
            label: 'Settings',
            key: 1,
          ),
        ],
      ).then((value) {
        if (value == 1) {
          openAppSettings();
        }
      });
      return false;
    } else {
      /// 有权限或者部分权限
      return true;
    }
  }

  static Future<List<XFile>> pickerImage(
    BuildContext context, {
    bool multiple = false,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    var files = <XFile>[];

    final actionType = await showConfirmationDialog(
        context: context,
        title: "select",
        actions: [
          const AlertDialogAction(
            key: GetImageActionType.shoot,
            label: 'shoot',
          ),
          const AlertDialogAction(
            key: GetImageActionType.photo,
            label: 'photo',
          ),
        ]);
    if (actionType == GetImageActionType.photo) {
      /// 如果选择的是相册
      /// 检查权限
      bool result = await Utils.checkPremission(Permission.photos);

      if (result) {
        if (multiple) {
          /// 选择图片
          files = await ImagePicker().pickMultiImage(
              maxHeight: maxHeight,
              maxWidth: maxWidth,
              imageQuality: imageQuality,
              requestFullMetadata: requestFullMetadata);
        } else {
          final file = await ImagePicker().pickImage(
              source: ImageSource.gallery,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
              preferredCameraDevice: preferredCameraDevice,
              imageQuality: imageQuality,
              requestFullMetadata: requestFullMetadata);
          if (file != null) {
            files.add(file);
          }
        }
      }
    } else if (actionType == GetImageActionType.shoot) {
      /// 如果选择的拍摄
      /// 检查权限
      bool result = await Utils.checkPremission(Permission.camera);

      if (result) {
        /// 拍摄
        final XFile? file = await ImagePicker().pickImage(
            source: ImageSource.camera,
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            preferredCameraDevice: preferredCameraDevice,
            imageQuality: imageQuality,
            requestFullMetadata: requestFullMetadata);
        if (file != null) {
          files.add(file);
        }
      }
    }
    return files;
  }
}

/// 选择获取图片的方式
enum GetImageActionType {
  /// 拍摄
  shoot,

  /// 相册
  photo,
}
