/// Author: kele
/// Date: 2022-03-07 13:31:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:10:09
/// Description:

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_soulmateelf/config.dart';

class SplashLogic extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    /// 安卓设置透明状态栏
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    /// 设置竖屏，不能横屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    /// 升级app和判断入口
    checkAppInfo();
  }

  /// Author: kele
  /// Date: 2022-03-07 17:04:38
  /// Params:
  /// Return:
  /// Description: 判断入口
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:
  void whereToGo() {
    String? headers = Application.pres?.getString('headers');
    String? userInfo = Application.pres?.getString("userInfo");
    if (headers == null || userInfo == null) {
      /// 未登录状态
      Get.offNamed('/login');
    } else {
      Get.offNamed('/home');
    }
  }

  /// 升级app
  checkAppInfo() {
    /// 和判断入口
    whereToGo();
    ///等升级接口
    return;
    /// 升级之前先检查版本信息
    if (APPPlugin.appInfo != null) {
      getUpdate();
    } else {
      ///初始化版本信息
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        APPPlugin.appInfo = packageInfo;
        getUpdate();
      });
    }
  }

  /// 升级app
  getUpdate() async {
    Map<String, dynamic> params = {
      'platform': GetPlatform.isAndroid ? 'android' : 'ios',
      'buildId': APPPlugin.appInfo?.buildNumber,
      'packageName': ProjectConfig.getInstance()?.baseConfig["packageName"]
    };
    void successFn(res) {
      var updateInfo = res['data'];
      // updateInfo = {'name': '安卓', 'platform': 'android', 'version': 0, 'buildId': 2, 'content': '1、修改了bug;2、优化了页面打开速度;3、11111', 'remark': null, 'isforce': 1, 'downloadUrl': 'http://www.baidu.com', 'id': 1, 'status': 0, 'modifyTime': null, 'createTime': 1603702394000};
      if (updateInfo != null) {
        List updateContentList = [];
        updateContentList = updateInfo['content'].split(';');
        Get.defaultDialog(
          title: '新版本',
          content: _updateContentList(updateContentList),
          barrierDismissible: false,
          confirm: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: FractionallySizedBox(
                alignment: Alignment.center,
                widthFactor: updateInfo["isforce"] == 0 ? 0.42 : 1,
                child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      '立即升级',
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ))),
            onTap: () {
              /// 打开下载链接
              Utils.openPage(updateInfo['downloadUrl']);

              /// 关闭弹框
              // Get.back();

              /// 退出app
              SystemNavigator.pop();
            },
          ),
          cancel: updateInfo["isforce"] == 0
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: FractionallySizedBox(
                      alignment: Alignment.center,
                      widthFactor: 0.42,
                      child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '暂不体验',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ))),
                  onTap: () {
                    /// 关闭弹框
                    Get.back();
                  },
                )
              : null,
        );
      }
    }

    void errorFn(error) {
      /// 升级失败不能提示
      // exSnackBar(error['message'], type: 'error');
    }
    return NetUtils.diorequst(
      '/iot4-crpm-api/user/new/app/version',
      'get',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }

  // 列表
  Widget _updateContentList(updateContentList) {
    return Container(
        height: 160,
        width: 800,
        child: ListView.builder(
          itemCount: updateContentList.length,
          itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Text(
                  updateContentList[index],
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromRGBO(14, 16, 26, 0.85)),
                ));
          },
        ));
  }
}
