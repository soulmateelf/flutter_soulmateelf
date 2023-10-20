/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 18:28:30
 * @FilePath: \soulmate\lib\views\base\login\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2023-10-20 17:18:40
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final logic = Get.put(LoginController());

  final _emialController = TextEditingController();

  final _passwordController = TextEditingController();

  FocusNode _emailFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();

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
                  'Enter your phone or email',
                  style: TextStyle(fontSize: 27.sp, color: textColor),
                ),
                SizedBox(height: 126.w),
                GetBuilder<LoginController>(
                  builder: (controller) {
                    return MakeInput(
                      controller: _emialController,
                      onChanged: (v) {
                        controller.email = v;
                        controller.validateEmail(v);
                      },
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        _passwordFocusNode.requestFocus();
                      },
                      error: controller.emailErrorText != null,
                      errorText: controller.emailErrorText,
                      textAlign: TextAlign.center,
                      hintText: "Email",
                      allowClear: true,
                      keyboardType: TextInputType.emailAddress,
                      onClear: () {
                        _emialController.text = "";
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 12.w,
                ),
                GetBuilder<LoginController>(
                  builder: (controller) {
                    return MakeInput(
                      controller: _passwordController,
                      onChanged: (v) {
                        controller.password = v;
                        controller.validatePassword(v);
                      },
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
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/findAccount");
                  },
                  child: const Text(
                    'Forgot password',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                SizedBox(
                  height: 24.w,
                ),
                MaterialButton(
                  onPressed: () {
                    logic.login();
                  },
                  color: primaryColor,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  minWidth: double.infinity,
                  height: 64.w,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                ),
                SizedBox(
                  height: 48.w,
                ),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Text(
                      ' or continue with ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(
                  height: 24.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3.w, color: Colors.grey),
                            borderRadius: BorderRadius.circular(borderRadius)),
                        child: Icon(Icons.developer_board),
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(15.w),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3.w, color: Colors.grey),
                            borderRadius: BorderRadius.circular(borderRadius)),
                        child: Icon(Icons.developer_board),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.w,
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
                          Get.toNamed('/signUp');
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: primaryColor),
                        ))
                  ],
                ),
                SizedBox(
                  height: 48.w,
                ),
              ],
            ),
          ),
        ));
  }
}
