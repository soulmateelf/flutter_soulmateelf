/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: logic.dealBack,
      child: Scaffold(
        body: GetBuilder<LoginLogic>(builder: (logic) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/backGround/loginbk.png'),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(0, 136.w, 0, 0),
                    padding: EdgeInsets.only(left: 50.w),
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/backGround/welcome.png',
                      width: 157.w,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(50.w, 150.w, 50.w, 0),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(16, 86, 157, 0.45),
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                    ),
                    child: TextFormField(
                      initialValue: logic.account,
                      textAlign: TextAlign.center,
                      focusNode: logic.accountFocusNode,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: '请输入账号',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 16.sp),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        logic.account = value;
                        logic.update();
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(50.w, 24.w, 50.w, 0),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(16, 86, 157, 0.45),
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      initialValue: logic.password,
                      textAlign: TextAlign.center,
                      focusNode: logic.pwdFocusNode,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: '请输入密码',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 16.sp),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        logic.password = value;
                        logic.update();
                      },
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(50.w, 24.w, 50.w, 0),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 123, 245, 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(28)),
                          border: Border.all(
                              color: const Color.fromRGBO(0, 123, 245, 1))),
                      child: TextButton(
                        child: const Text('登录',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          logic.login();
                        },
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 30.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  logic.checkProtocol = !logic.checkProtocol;
                                  logic.update();
                                },
                                child: Row(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5.w),
                                    padding: EdgeInsets.all(3.w),
                                    child: logic.checkProtocol
                                        ? const Icon(
                                            Icons.check_circle,
                                            size: 20.0,
                                            color: Colors.lightBlue,
                                          )
                                        : const Icon(
                                            Icons.radio_button_unchecked,
                                            size: 20.0,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 4.w, bottom: 4.w),
                                    child: Text("我已阅读并接受",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                108, 108, 108, 1),
                                            fontSize: 14.sp)),
                                  )
                                ])),
                            Container(
                              child: RichText(
                                  strutStyle: const StrutStyle(
                                      forceStrutHeight: true,
                                      height: 1,
                                      leading: 0.2),
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: '《用户协议》',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color:
                                              Color.fromRGBO(0, 123, 245, 1)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed('/webview',
                                              arguments: 0);
                                        },
                                    ),
                                    TextSpan(
                                      text: '和',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color.fromRGBO(
                                              108, 108, 108, 1)),
                                    ),
                                    TextSpan(
                                      text: '《隐私政策》',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color.fromRGBO(
                                              0, 123, 245, 1)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed('/webview',
                                              arguments: 1);
                                        },
                                    ),
                                  ])),
                            )
                          ])),
                  Container(
                    padding: EdgeInsets.only(top: 15.w),
                    child: Text(
                      'V${APPPlugin.appInfo != null ? APPPlugin.appInfo!.version : ''}(${APPPlugin.appInfo != null ? APPPlugin.appInfo!.buildNumber : ''})',
                      style: TextStyle(
                          color: const Color.fromRGBO(108, 108, 108, 1),
                          fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
