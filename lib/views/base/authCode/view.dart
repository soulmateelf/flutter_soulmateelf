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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/base/authCode/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class AuthCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthCodePageState();
  }
}

class _AuthCodePageState extends State<AuthCodePage> {
  final logic = Get.put(AuthCodeController());

  @override
  void initState() {
    // TODO: implement initState
    logic.setErrorController(StreamController());
    logic.sendCode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    logic.errorAnimationController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    final arguments = Get.arguments;
    final codeType = arguments['codeType'];
    return basePage('',
        backGroundImage: codeType == VerifyState.deactivate
            ? null
            : BackGroundImageType.white,
        backgroundColor:
            codeType == VerifyState.deactivate ? Colors.white : null,
        child: Container(
          color: codeType == VerifyState.deactivate ? Colors.white : null,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 24.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 72.w,
                      ),
                      GetBuilder<AuthCodeController>(
                        builder: (controller) {
                          return Text(
                            controller.loading
                                ? "Sending verification code"
                                : 'We sent you a code',
                            style: TextStyle(
                              fontSize: 27.sp,
                              fontFamily: FontFamily.SFProRoundedBlod,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 186.w,
                      ),
                      GetBuilder<AuthCodeController>(
                        builder: (controller) {
                          return PinCodeTextField(
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(borderRadius),
                              borderWidth: borderWidth,
                              inactiveColor: borderColor,
                              activeColor: primaryColor,
                              selectedColor: primaryColor,
                              errorBorderColor: errorBorderColor,
                              selectedFillColor: Colors.white,
                              errorBorderWidth: borderWidth,
                              selectedBorderWidth: 4,
                              activeFillColor: controller.hasError
                                  ? errorBackgroundColor
                                  : Colors.white,
                              inactiveFillColor: Colors.white,
                              fieldHeight: 64.w,
                              fieldWidth: 52.w,
                              fieldOuterPadding: EdgeInsets.all(0.w),
                            ),
                            controller: controller.controller,
                            autoFocus: true,
                            autoUnfocus: true,
                            useHapticFeedback: true,
                            hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                            animationType: AnimationType.fade,
                            enableActiveFill: true,
                            cursorColor: Colors.transparent,
                            animationDuration: controller.animateDurantion,
                            errorAnimationDuration: 300,
                            focusNode: controller.focusNode,
                            errorAnimationController:
                                controller.errorAnimationController,
                            onChanged: (v) {
                              controller.code = v;
                              controller.handleVerify();
                            },
                            appContext: context,
                            length: 6,
                            textStyle: TextStyle(
                              fontSize: 28.sp,
                              fontFamily: FontFamily.SFProRoundedMedium,
                            ),
                            keyboardType: TextInputType.number,
                          );
                        },
                      ),
                      GetBuilder<AuthCodeController>(
                        builder: (controller) {
                          return Offstage(
                            offstage: !controller.hasError,
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.w),
                              child: Text(
                                controller.errorText ??
                                    'The code you entered is incorrect.Please try again.',
                                style: TextStyle(
                                  color: errorTextColor,
                                  fontSize: 14.sp,
                                  fontFamily: FontFamily.SFProRoundedLight,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      GetBuilder<AuthCodeController>(
                        builder: (controller) {
                          return controller.intervalTime <= 0
                              ? TextButton(
                                  onPressed: () {
                                    logic.sendCode();
                                  },
                                  child: Text(
                                    'Resend code',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 17.sp,
                                      fontFamily: FontFamily.SFProRoundedBlod,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                              : TextButton(
                                  onPressed: null,
                                  child: Text(
                                    "Resend code (${controller.intervalTime}s)",
                                    style: TextStyle(
                                      color:
                                          const Color.fromRGBO(0, 0, 0, 0.24),
                                      fontSize: 17.sp,
                                      fontFamily: FontFamily.SFProRoundedBlod,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ));
                        },
                      )
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: arguments['codeType'] != VerifyState.deactivate,
                child: Container(
                  width: double.infinity,
                  height: 64.w,
                  child: MaterialButton(
                    onPressed: () {
                      logic.deactivateAccount();
                    },
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Text(
                      "Deactivate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
