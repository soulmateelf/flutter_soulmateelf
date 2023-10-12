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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/base/authCode/logic.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class AuthCodePage extends StatelessWidget {
  final logic = Get.put(AuthCodeLogic());

  final _formKey = GlobalKey<FormState>();

  final _emialController = TextEditingController();

  final _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return WillPopScope(
        onWillPop: logic.dealBack,
        child: basePage('',
            showBgImage: true,
            resizeToAvoidBottomInset: false,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      borderRadius: borderRadius,
                      borderWidth: borderWidth,
                      inactiveColor: Color.fromRGBO(245, 245, 245, 1),
                      activeColor: primaryColor,
                      selectedColor: Colors.blueGrey,
                      errorBorderColor: Colors.red,
                      errorBorderWidth: borderWidth,
                    ),
                    validator: (v) {
                      if (v != "123456") {
                        return "error";
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
                      onPressed: () {},
                      child: Text(
                        'Resend code',
                        style: TextStyle(color: primaryColor, fontSize: 17.sp),
                      ))
                ],
              ),
            )));
  }
}
