/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

import '../../../utils/tool/utils.dart';
import 'package:flutter/src/widgets/editable_text.dart';

class FeedbackController extends GetxController {
  final contentController = TextEditingController();
  final emailController = TextEditingController();
  bool checkSend = false;
  List<XFile> files = [];

  void pickerFile() {
    Utils.pickerImage(Get.context!, multiple: true).then((value) {
      if (value.length > 0) {
        files.addAll(value);
        update();
      }
    });
  }

  void removeFile(XFile file) {
    files.removeWhere((element) => element == file);
    update();
  }

  void sendFeedback() {
    void errorAlert(String s) {
      exSnackBar(s, type: ExSnackBarType.error);
    }

    if (contentController.text.isEmpty) {
      return errorAlert("Please enter content");
    }
    if (contentController.text.length > 1000) {
      return errorAlert(
          "Input is limited to 1000 characters. Please shorten your message.");
    }
    String email = "";
    if (checkSend) {
      email = emailController.text;
      final isEmail = GetUtils.isEmail(email);
      if (!isEmail) {
        return errorAlert("Please enter a valid email.");
      }
    }

    if (files.length > 3) {
      return errorAlert("You have reached the upload limit.");
    }

    final fd = FormData.fromMap({
      "email": emailController.text,
      "content": contentController.text,
    });

    fd.files.addAll(files
        .map((e) => MapEntry("files", MultipartFile.fromFileSync(e.path))));

    HttpUtils.diorequst('/feedback', method: "post", params: fd).then((res) {
      APPPlugin.logger.d(res);
    }).catchError((err) {
      APPPlugin.logger.e(err);
    });
  }

  @override
  void onInit() {
    super.onInit();
    return;
  }

  @override
  void onReady() {
    super.onReady();
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }
}
