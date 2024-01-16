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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:soulmate/config.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    /// 安卓设置透明状态栏
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
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
    String? token = Application.pres?.getString('token');
    String? userInfo = Application.pres?.getString("userInfo");
    if (token == null || userInfo == null) {
      /// 未登录状态
      Get.offNamed('/welcome');
    } else {
      Get.offAllNamed('/menu');
    }
  }

  /// 升级app
  checkAppInfo() {
    /// 和判断入口
    whereToGo();

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
    // showUpdateDialog(null);
    Map<String, dynamic> params = {
      'platform': GetPlatform.isAndroid ? 'android' : 'ios',
      'buildId': APPPlugin.appInfo?.buildNumber,
      'packageName': ProjectConfig.getInstance()?.baseConfig["packageName"]
    };
    // HttpUtils.diorequst(
    //   '/iot4-crpm-api/user/new/app/version',
    //   query: params,
    // );
  }
  /// 更新弹窗
  void showUpdateDialog(updateInfo) {
    updateInfo = {'name': '安卓', 'platform': 'android', 'version': "1.0.1", 'buildId': 2, 'content': '修改了bug;优化了页面打开速度优化了页面打开速度优化了页面打开速度;11111', 'remark': null, 'isforce': 0, 'downloadUrl': 'http://www.baidu.com', 'id': 1, 'status': 0, 'modifyTime': null, 'createTime': 1603702394000};
    if (updateInfo != null) {
      List updateContentList = updateInfo['content'].split(';');
      final makeDialogController = MakeDialogController();
      makeDialogController.show(
        context: Get.context!,
        controller: makeDialogController,
        iconWidget: Image.asset("assets/images/icons/newVersion.png"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "New Version Ready",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.SFProRounded,
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            Text(
              "Version ${updateInfo['version']}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 0.48),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.SFProRounded,
              ),
            ),
            SizedBox(
              height: 14.w,
            ),
            _updateContentList(updateContentList),
            SizedBox(
              height: 14.w,
            ),
            Container(
              height: 64.w,
              width: double.maxFinite,
              child: TextButton(
                  onPressed: () {
                    makeDialogController.close();
                    /// 打开下载链接
                    Utils.openPage(updateInfo['downloadUrl']);
                    /// 退出app
                    SystemNavigator.pop();
                  },
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.white)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.w)))),
                  child: Text(
                    "update now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.w,
                      fontFamily: FontFamily.SFProRoundedBlod,
                    ),
                  )),
            ),
            SizedBox(
              height: 10.w,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                makeDialogController.close();
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Text(
                  "Skip This Version",
                  style: TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 0.32),
                    fontSize: 20.sp,
                    fontFamily: FontFamily.SFProRoundedMedium,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.w,
            ),
          ],
        ),
      );
    }
  }
  /// 更新内容列表
  Widget _updateContentList(updateContentList) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        constraints: BoxConstraints(
          maxHeight: 120.w,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: updateContentList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 10.w),
              child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: primaryColor, // 设置颜色为黄色
                        shape: BoxShape.circle, // 设置形状为圆形
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                        child: Text(
                          updateContentList[index],
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 0, 0, 0.48),
                            fontSize: 18.sp,
                            height: 1.3,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.SFProRounded,
                          ),
                        )
                    ),
                  ]),
            );
          },
        ));
  }
}
