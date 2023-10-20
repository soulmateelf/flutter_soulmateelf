/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:15:44
 * @FilePath: \soulmate\lib\views\base\welcome\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2023-10-20 17:18:14
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/base/authCode/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class AuthCodePage extends StatelessWidget {
  final logic = Get.put(AuthCodeController());

  final arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));

    return WillPopScope(
        onWillPop: logic.dealBack,
        child: basePage('',
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 72.w,
                    ),
                    Text(
                      'We sent you a code',
                      style: TextStyle(fontSize: 27.sp),
                    ),
                    SizedBox(
                      height: 186.w,
                    ),
                    PinCodeTextField(
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderWidth: borderWidth,
                          inactiveColor: borderColor,
                          activeColor: primaryColor,
                          selectedColor: primaryColor,
                          errorBorderColor: Colors.red,
                          errorBorderWidth: borderWidth,
                          selectedBorderWidth: 4),
                      autoFocus: true,
                      autoUnfocus: true,
                      cursorColor: Colors.transparent,
                      animationDuration: const Duration(milliseconds: 300),
                      onEditingComplete: () {
                        APPPlugin.logger.d(logic.code);
                      },
                      onChanged: (v) {
                        APPPlugin.logger.d(v);
                        logic.code = v;
                        if (v != null && v.length == 6) {
                          if (v != "123456") {
                            APPPlugin.logger.d(
                                "The code you entered is incorrect.Please try again.");
                          } else {
                            Get.toNamed("/password", arguments: {
                              ...arguments as Map,
                              "authCode": logic.code,
                            });
                          }
                        }
                      },
                      appContext: context,
                      length: 6,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed('/setPassword');
                        },
                        child: Text(
                          'Resend code',
                          style:
                              TextStyle(color: primaryColor, fontSize: 17.sp),
                        ))
                  ],
                ),
              ),
            )));
  }
}
