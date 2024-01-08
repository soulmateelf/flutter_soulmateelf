/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class MineController extends GetxController {
  /// 头部组件的高度
  double size = 117;

  setSize(double s) {
    size = s;
    update();
  }

  /// 开启紧急联系邮箱
  bool contact = false;
  /// 用户信息
  User? user;

  setContact(bool c) {
    contact = c;
    HttpUtils.diorequst("/user/updateEemergency", query: {"status": c ? 1 : 0})
        .then((res) {})
        .catchError((err) {});
    update();
  }

  void logout() {
    final makeDialogController = MakeDialogController();
    makeDialogController.show(
      context: Get.context!,
      controller: makeDialogController,
      iconWidget: Image.asset("assets/images/icons/logOut.png"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Log out",
            style: TextStyle(
                color: textColor,
                fontSize: 32.sp,
                fontFamily: FontFamily.SFProRoundedSemibold),
          ),
          SizedBox(
            height: 8.w,
          ),
          Text(
            "Are you sure you want to \nlog out?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.48),
              fontSize: 24.sp,
              fontFamily: FontFamily.SFProRoundedMedium,
            ),
          ),
          SizedBox(
            height: 30.w,
          ),
          Container(
            height: 64.w,
            width: double.maxFinite,
            child: TextButton(
                onPressed: () {
                  Application.logout();
                },
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white)),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w)))),
                child: Text(
                  "yes，log out",
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
                "Cancel",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.32),
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

  Future<void> getUser() async {
    await Application.regainUserInfo();
    user = Application.userInfo;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    user = Application.userInfo;
    setContact(user?.emergencyContact == 1);
    update();
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
