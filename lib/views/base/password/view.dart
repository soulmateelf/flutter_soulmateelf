/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 18:28:30
 * @FilePath: \soulmate\lib\views\base\password\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import '../../../utils/plugin/plugin.dart';
import 'controller.dart';
import 'package:flutter/cupertino.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});

  final logic = Get.put(PasswordController());

  final arguments = Get.arguments;

  final _emialController = TextEditingController();

  final _passwordController = TextEditingController();

  FocusNode _confirmPasswordFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();

  final typeMap = {
    "signUp": {
      "title": 'Create your password',
      "nextPage": "/menu",
    },
    "forgotPassword": {
      "title": "Choose a new password",
      "nextPage": "/successfully"
    },
  };

  @override
  Widget build(BuildContext context) {
    return basePage('',
        showBgImage: true,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 97.w),
                Text(
                  "${typeMap[arguments['type']]?['title']}",
                  style: TextStyle(fontSize: 27.sp, color: textColor),
                ),
                SizedBox(height: 126.w),
                GetBuilder<PasswordController>(
                  builder: (controller) {
                    return MakeInput(
                      controller: _passwordController,
                      onChanged: (v) {
                        controller.password = v;
                        controller.validatePassword(v);
                        controller.validateConfirmPassword(
                            controller.confirmPassword);
                      },
                      obscureText: controller.passwordVisible,
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
                          controller.passwordVisible
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                        ),
                      ),
                      error: controller.passwordErrorText != null,
                      errorText: controller.passwordErrorText,
                      textAlign: TextAlign.center,
                      hintText: "Password",
                      allowClear: true,
                      keyboardType: TextInputType.visiblePassword,
                      onClear: () {
                        _passwordController.text = "";
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
                      controller: _emialController,
                      obscureText: controller.confirmPasswordVisible,
                      onChanged: (v) {
                        controller.confirmPassword = v;
                        controller.validatePassword(controller.password);
                        controller.validateConfirmPassword(v);
                      },
                      suffix: GestureDetector(
                        onTap: () {
                          controller.toggleConfirmPasswordVisible();
                        },
                        child: Icon(
                          controller.confirmPasswordVisible
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                        ),
                      ),
                      focusNode: _confirmPasswordFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        _passwordFocusNode.requestFocus();
                      },
                      error: controller.confirmPasswordErrorText != null,
                      errorText: controller.confirmPasswordErrorText,
                      textAlign: TextAlign.center,
                      hintText: "Confirm password",
                      allowClear: true,
                      keyboardType: TextInputType.visiblePassword,
                      onClear: () {
                        _emialController.text = "";
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 161.w,
                ),
                MaterialButton(
                  onPressed: () {
                    Get.toNamed(
                        typeMap[arguments['type']]?['nextPage'] as String);
                  },
                  color: primaryColor,
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  minWidth: double.infinity,
                  height: 64.w,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                ),
              ],
            ),
          ),
        ));
  }
}
