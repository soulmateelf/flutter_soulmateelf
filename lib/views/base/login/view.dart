/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 18:28:30
 * @FilePath: \soulmate\lib\views\base\login\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final logic = Get.put(LoginController());

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
                  'Enter your phone or email',
                  style: TextStyle(
                      fontSize: 27.sp,
                      color: const Color.fromRGBO(0, 0, 0, 0.8)),
                ),
                SizedBox(height: 126.w),
                TextField(
                  obscureText: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.sp),
                  cursorColor: Color.fromRGBO(255, 128, 0, 1),
                  decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.w, horizontal: 10.w),
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Text(''),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 128, 0, 1),
                              width: 3.w),
                          borderRadius: BorderRadius.circular(16.w)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromRGBO(245, 245, 245, 1),
                            width: 3.w,
                          ),
                          borderRadius: BorderRadius.circular(16.w))),
                ),
                SizedBox(
                  height: 12.w,
                ),
                GetBuilder<LoginController>(
                  builder: (controller) {
                    return  TextField(
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
                              borderRadius: BorderRadius.circular(16.w)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromRGBO(245, 245, 245, 1),
                                width: 3.w,
                              ),
                              borderRadius: BorderRadius.circular(16.w))),
                    );
                  },
                ),
                SizedBox(
                  height: 12.w,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot password',
                    style: TextStyle(color: Color.fromRGBO(255, 128, 0, 1)),
                  ),
                ),
                SizedBox(
                  height: 24.w,
                ),
                MaterialButton(
                  onPressed: () {
                    Get.toNamed('/menu');
                  },
                  color: Color.fromRGBO(255, 128, 0, 1),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  minWidth: double.infinity,
                  height: 64.w,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.w)),
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
                            borderRadius: BorderRadius.circular(16.w)),
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
                            borderRadius: BorderRadius.circular(16.w)),
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
                          style:
                              TextStyle(color: Color.fromRGBO(255, 128, 0, 1)),
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
