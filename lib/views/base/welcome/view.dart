/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:15:44
 * @FilePath: \soulmate\lib\views\base\welcome\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/views/base/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class WelcomePage extends StatelessWidget {
  final logic = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return WillPopScope(
        onWillPop: logic.dealBack,
        child: basePage('',
            showAppbar: false,
            showBgImage: true,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Let’s you in',
                    style: TextStyle(fontSize: 27.sp),
                  ),
                  SizedBox(
                    height: 70.w,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 64.w,
                    onPressed: () {},
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side:
                        BorderSide(width: borderWidth, color: borderColor),
                        borderRadius: borderRadius),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.logo_dev_outlined),
                        SizedBox(
                          width: 49.w,
                        ),
                        Text('Continue with Google',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: const Color.fromRGBO(0, 0, 0, 0.8)))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 64.w,
                    onPressed: () {},
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side:
                        BorderSide(width: borderWidth, color: borderColor),
                        borderRadius: borderRadius),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.logo_dev_outlined),
                        SizedBox(
                          width: 49.w,
                        ),
                        Text('Continue with Facebook',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: textColor))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 64.w,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    color: const Color.fromRGBO(255, 128, 0, 1),
                    child: Text('Log in with password',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white)),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account?',
                        style: TextStyle(color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.toNamed("/signUp");
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: primaryColor),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 92.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By signing up, you agree to our ',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(1);
                        },
                        child: Text(
                          'Terms,Privacy Policy',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: primaryColor),
                        ),
                      ),
                      Text(
                        '.',
                        style: TextStyle(fontSize: 14.sp),
                      )
                    ],
                  ),
                ],
              ),
            ),));
  }
}
