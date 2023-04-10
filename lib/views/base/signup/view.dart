/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-10 19:04:17
 * @FilePath: \soulmate\lib\views\base\signup\view.dart
 */
/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/views/base/login/bloc.dart';
import 'package:flutter_soulmateelf/views/base/signup/bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    return BlocProvider(
      create: (context) => SignUpFormBloc(),
      child: Builder(builder: (context) {
        // 表单bloc
        final signupFormBloc = context.read<SignUpFormBloc>();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Row(children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Get.back();
                },
                color: Color.fromRGBO(153, 153, 153, 1),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: const Text(
                  "Back",
                  style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
                ),
              )
            ]),
            backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
            leadingWidth: 1.sw,
          ),
          body: FormBlocListener<SignUpFormBloc, String, String>(
              child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top),
              child: Container(
                  padding: EdgeInsets.all(20.w),
                  height: double.infinity,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Create your account",
                                style: TextStyle(
                                  fontSize: 48.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 68.h),
                              child: TextFieldBlocBuilder(
                                textFieldBloc: signupFormBloc.email,
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [
                                  AutofillHints.email,
                                ],
                                suffixButton: SuffixButton.asyncValidating,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    helperText: " ",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.w)),
                                        borderSide: BorderSide(
                                          width: 1.w,
                                          color: const Color.fromRGBO(
                                              230, 230, 230, 1),
                                        ))),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: TextFieldBlocBuilder(
                                textFieldBloc: signupFormBloc.password,
                                suffixButton: SuffixButton.obscureText,
                                autofillHints: const [AutofillHints.password],
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    helperText: " ",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.w)),
                                        borderSide: BorderSide(
                                          width: 1.w,
                                          color: const Color.fromRGBO(
                                              230, 230, 230, 1),
                                        ))),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.h),
                              width: double.infinity,
                              height: 94.h,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromRGBO(
                                                  78, 162, 79, 1))),
                                  onPressed: () {
                                    Get.toNamed('/verification');
                                  },
                                  child: Text(
                                    "Next",
                                    style: TextStyle(fontSize: 36.sp),
                                  )),
                            ),

                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          )),
        );
      }),
    );
  }
}
