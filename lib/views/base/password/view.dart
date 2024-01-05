/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 18:28:30
 * @FilePath: \soulmate\lib\views\base\password\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2023-10-20 17:18:46
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:flutter/cupertino.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PasswordState();
  }
}

class PasswordState extends State<PasswordPage> {
  final logic = Get.put(PasswordController());

  final arguments = Get.arguments;

  final _confirmPasswordController = TextEditingController();

  final _passwordController = TextEditingController();

  FocusNode _confirmPasswordFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus) {
        logic.validateConfirmPassword(_confirmPasswordController.text);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        logic.validatePassword(_passwordController.text);
        logic.validateConfirmPassword(_confirmPasswordController.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final typeMap = {
    VerifyState.signUp: {
      "title": 'Create your password',
      "nextPage": "/menu",
    },
    VerifyState.forgot: {
      "title": "Choose a new password",
      "nextPage": "/successfully"
    },
  };

  @override
  Widget build(BuildContext context) {
    return basePage('',
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 97.w),
                Text(
                  "${typeMap[arguments['codeType']]?['title']}",
                  style: TextStyle(
                    fontSize: 27.sp,
                    color: textColor,
                    fontFamily: FontFamily.SFProRoundedBlod,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 126.w),
                GetBuilder<PasswordController>(
                  builder: (controller) {
                    return MakeInput(
                      controller: _passwordController,
                      onChanged: (v) {
                        controller.password = v;
                      },
                      obscureText: !controller.passwordVisible,
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        _passwordFocusNode.unfocus();
                      },
                      suffix: GestureDetector(
                        onTap: () {
                          controller.togglePasswordVisible();
                        },
                        child: Icon(
                          !controller.passwordVisible
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                        ),
                      ),
                      error: controller.passwordErrorText != null,
                      // errorText: controller.passwordErrorText,
                      errorWidget: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 8.w),
                        child: Text(
                          controller.passwordErrorText ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: errorTextColor,
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      hintText: "Password",
                      allowClear: true,
                      keyboardType: TextInputType.visiblePassword,
                      onClear: () {
                        _passwordController.text = "";
                        controller.password = "";
                        controller.validatePassword("");
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 12.w,
                ),
                GetBuilder<PasswordController>(
                  builder: (controller) {
                    return MakeInput(
                      controller: _confirmPasswordController,
                      obscureText: !controller.confirmPasswordVisible,
                      onChanged: (v) {
                        controller.confirmPassword = v;
                      },
                      suffix: GestureDetector(
                        onTap: () {
                          controller.toggleConfirmPasswordVisible();
                        },
                        child: Icon(
                          !controller.confirmPasswordVisible
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                        ),
                      ),
                      focusNode: _confirmPasswordFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        _confirmPasswordFocusNode.unfocus();
                      },
                      error: controller.confirmPasswordErrorText != null,
                      errorText: controller.confirmPasswordErrorText,
                      textAlign: TextAlign.center,
                      hintText: "Confirm password",
                      allowClear: true,
                      keyboardType: TextInputType.visiblePassword,
                      onClear: () {
                        _confirmPasswordController.text = "";
                        controller.confirmPassword = "";
                        controller.validateConfirmPassword("");
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 161.w,
                ),
                GetBuilder<PasswordController>(
                  builder: (controller) {
                    return MaterialButton(
                      minWidth: double.infinity,
                      height: 64.w,
                      enableFeedback: true,
                      disabledColor: disableColor,
                      onPressed: controller.nextBtnDisabled
                          ? null
                          : () {
                              controller.next();
                            },
                      color: const Color.fromRGBO(255, 128, 0, 1),
                      textColor: controller.nextBtnDisabled
                          ? const Color.fromRGBO(0, 0, 0, 0.24)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.SFProRoundedBlod,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
