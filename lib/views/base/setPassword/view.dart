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
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/base/setPassword/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'package:flutter/cupertino.dart';

class SetPasswordPage extends StatelessWidget {
  final logic = Get.put(SetPasswordController());

  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return WillPopScope(
        onWillPop: logic.dealBack,
        child: basePage('',
            showBgImage: true,
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 40.w, horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 72.w,
                        ),
                        Text(
                          'Create your password',
                          style: TextStyle(fontSize: 27.sp),
                        ),
                        SizedBox(
                          height: 186.w,
                        ),
                        GetBuilder<SetPasswordController>(
                          builder: (controller) {
                            return TextField(
                              controller: _passwordController,
                              obscureText: controller.passwordVisible,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.sp),
                              cursorColor: Color.fromRGBO(255, 128, 0, 1),
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.w, horizontal: 10.w),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.togglePasswordVisible();
                                    },
                                    child: Icon(
                                      controller.passwordVisible
                                          ? CupertinoIcons.eye_slash
                                          : CupertinoIcons.eye,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(255, 128, 0, 1),
                                          width: 3.w),
                                      borderRadius:
                                          BorderRadius.circular(16.w)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color.fromRGBO(
                                            245, 245, 245, 1),
                                        width: 3.w,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(16.w))),
                            );
                          },
                        ),
                        SizedBox(
                          height: 12.w,
                        ),
                        GetBuilder<SetPasswordController>(
                          builder: (controller) {
                            return TextField(
                              controller: _confirmPasswordController,
                              obscureText: controller.confirmPasswordVisible,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.sp),
                              cursorColor: Color.fromRGBO(255, 128, 0, 1),
                              decoration: InputDecoration(
                                  hintText: 'confirm password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.w, horizontal: 10.w),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.toggleConfirmPasswordVisible();
                                    },
                                    child: Icon(
                                      controller.confirmPasswordVisible
                                          ? CupertinoIcons.eye_slash
                                          : CupertinoIcons.eye,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(255, 128, 0, 1),
                                          width: 3.w),
                                      borderRadius:
                                          BorderRadius.circular(16.w)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color.fromRGBO(
                                            245, 245, 245, 1),
                                        width: 3.w,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(16.w))),
                            );
                          },
                        ),
                        SizedBox(
                          height: 161.w,
                        ),
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 64.w,
                          enableFeedback: true,
                          disabledColor: disableColor,
                          textColor: logic.nextBtnDisabled
                              ? const Color.fromRGBO(0, 0, 0, 0.24)
                              : Colors.white,
                          onPressed: logic.nextBtnDisabled ? null : () {},
                          color: const Color.fromRGBO(255, 128, 0, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.w),
                          ),
                          child:
                              Text('Next', style: TextStyle(fontSize: 18.sp)),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
