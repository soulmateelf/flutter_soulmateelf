/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:15:44
 * @FilePath: \soulmate\lib\views\base\welcome\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2023-10-20 17:19:06
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/base/welcome/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class WelcomePage extends StatelessWidget {
  final logic = Get.put(WelcomeController());
  final globalKey = GlobalKey();
  var overlayEntry;

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return WillPopScope(
        onWillPop: logic.dealBack,
        child: basePage(
          '',
          showAppbar: false,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text(
                  'Let’s you in',
                  key: globalKey,
                  style: TextStyle(
                      fontSize: 27.sp,
                      fontFamily: "SFProRounded-Blod",
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 70.w,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 64.w,
                  onPressed: () {
                    logic.googleLogin();
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: borderWidth, color: borderColor),
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/icons/google.png",
                        width: 34.w,
                        height: 34.w,
                      ),
                      SizedBox(
                        width: 49.w,
                      ),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: const Color.fromRGBO(0, 0, 0, 0.8),
                          fontFamily: FontFamily.SFProRoundedSemibold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.w,
                ),
                Offstage(
                  offstage: !GetPlatform.isIOS,
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 64.w,
                    onPressed: () {
                      logic.appleIdLogin();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: borderWidth, color: borderColor),
                        borderRadius: BorderRadius.circular(borderRadius)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icons/facebook.png",
                          width: 34.w,
                          height: 34.w,
                        ),
                        SizedBox(
                          width: 49.w,
                        ),
                        Text(
                          'Continue with Apple',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: textColor,
                            fontFamily: FontFamily.SFProRoundedSemibold,
                          ),
                        ),
                      ],
                    ),
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
                  child: Text(
                    'Log in with password',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                          style: TextStyle(color: primaryColor),
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
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/termsOfService");
                      },
                      child: Text(
                        'Terms,',
                        style: TextStyle(fontSize: 14.sp, color: primaryColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/privacyPolicy");
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 14.sp, color: primaryColor),
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
          ),
        ));
  }
}
