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
import '../../../utils/core/application.dart';
import '../../../utils/plugin/plugin.dart';
import 'controller.dart';
import 'package:flutter/cupertino.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});

  final logic = Get.put(PasswordController());

  final arguments = Get.arguments;

  final _confirmPasswordController = TextEditingController();

  final _passwordController = TextEditingController();

  FocusNode _confirmPasswordFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();

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
                      controller: _confirmPasswordController,
                      obscureText: !controller.confirmPasswordVisible,
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
                      textColor: controller.nextDisable
                          ? const Color.fromRGBO(0, 0, 0, 0.24)
                          : Colors.white,
                      onPressed: controller.nextDisable
                          ? null
                          : () {
                              final codeType = arguments['codeType'];
                              if (codeType == VerifyState.signUp) {
                                HttpUtils.diorequst("/register",
                                    method: "post",
                                    params: {
                                      ...arguments as Map,
                                      "password": logic.password
                                    }).then((value) {
                                  HttpUtils.diorequst('/login',
                                      method: 'post',
                                      params: {
                                        "email": arguments["email"],
                                        "password": logic.password
                                      }).then((response) {
                                    var userInfoMap =
                                        response["data"]["userInfo"];

                                    /// 存储全局信息
                                    Application.token =
                                        response["data"]["token"];
                                    Application.userInfo = userInfoMap;
                                    Get.offAllNamed('/menu');
                                  }).catchError((error) {
                                    Loading.error(error);
                                  });
                                }, onError: (err) {}).whenComplete(() {});
                              } else if (codeType == VerifyState.forgot) {
                                HttpUtils.diorequst("/forgetPassword",
                                    method: "post",
                                    params: {
                                      ...arguments as Map,
                                      "password": controller.password,
                                      "newPassword": controller.password,
                                    }).then((value) {
                                  Get.toNamed(typeMap[arguments['codeType']]
                                      ?['nextPage'] as String);
                                }, onError: (err) {}).whenComplete(() => {});
                              }
                            },
                      color: const Color.fromRGBO(255, 128, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Text('Next', style: TextStyle(fontSize: 18.sp)),
                    );
                    return MaterialButton(
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
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
