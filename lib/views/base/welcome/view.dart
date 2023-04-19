/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-18 11:40:45
 * @FilePath: \soulmate\lib\views\base\welcome\view.dart
 */
/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/views/base/welcome/logic.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  final logic = Get.put(WelcomeLogic());
  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    return WillPopScope(
        onWillPop: logic.dealBack,
        child: Scaffold(
            body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 0.7.sh,
                  width: 1.sw,
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("图片"),
                          ),
                          Text(
                            "Soulmate ELF",
                            style: TextStyle(
                              fontSize: 48.sp,
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 32.w),
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  width: double.infinity,
                  height: 94.w,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(78, 162, 79, 1))),
                      onPressed: () {
                        // Get.toNamed('/login');
                        Get.toNamed('/home');
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(fontSize: 36.sp),
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  height: 94.w,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 36.sp,
                            color: Color.fromRGBO(51, 51, 51, 1)),
                      )),
                )
              ],
            ),
          ),
        )));
  }
}
