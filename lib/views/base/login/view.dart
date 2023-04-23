/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-23 16:30:58
 * @FilePath: \soulmate\lib\views\base\login\view.dart
 */
/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/config.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/views/base/login/bloc.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

import '../../../utils/core/httputil.dart';
import '../../../utils/plugin/plugin.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final logic = Get.put(LoginLogic());

  _submit(LoginFormBloc bloc) async {
    final passwordValidate = await bloc.password.validate();
    final emailValidate = await bloc.email.validate();
    if (passwordValidate && emailValidate) {
      final result = await NetUtils.diorequst("/base/login", 'post', params: {
        "email": bloc.email.value,
        "password": bloc.password.value,
      });
      APPPlugin.logger.d(result?.data);
      if (result?.data?["code"] == 200) {
        Application.userInfo = result?.data?["data"];
        Application.token = result?.data?["token"];
        Get.offAllNamed('/home');
      } else {
        exSnackBar("password error", type: "error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    return BlocProvider(
      create: (context) => LoginFormBloc(),
      child: Builder(builder: (context) {
        // 表单bloc
        final loginFormBloc = context.read<LoginFormBloc>();
        return Scaffold(
          appBar: backBar(),
          body: GetBuilder<LoginLogic>(builder: (logic) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        MediaQuery.of(context).padding.top),
                child: Container(
                    padding: EdgeInsets.all(20.w),
                    height: double.infinity,
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
                                "Enter your phone or email",
                                style: TextStyle(
                                  fontSize: 48.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 68.w),
                              child: TextFieldBlocBuilder(
                                textFieldBloc: loginFormBloc.email,
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [
                                  AutofillHints.email,
                                ],
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
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
                              padding: EdgeInsets.only(top: 20.w),
                              child: TextFieldBlocBuilder(
                                textFieldBloc: loginFormBloc.password,
                                suffixButton: SuffixButton.obscureText,
                                autofillHints: const [AutofillHints.password],
                                readOnly: false,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
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
                            TextButton(
                                onPressed: () {
                                  Get.toNamed('/forgetPassword');
                                },
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(78, 162, 79, 1)),
                                )),
                            Container(
                              margin: EdgeInsets.only(top: 54.w),
                              width: double.infinity,
                              height: 94.w,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromRGBO(
                                                  78, 162, 79, 1))),
                                  onPressed: () {
                                    _submit(loginFormBloc);
                                  },
                                  child: Text(
                                    "Log in",
                                    style: TextStyle(fontSize: 36.sp),
                                  )),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: double.infinity,
                                height: 94.w,
                                margin: EdgeInsets.only(top: 32.w),
                                child: ElevatedButton(
                                    onPressed: () {
                                      logic.googleLogin();
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        94.w)))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 18.w),
                                          child: Image.asset(
                                            "assets/images/icons/google.png",
                                            width: 36.w,
                                            height: 36.w,
                                          ),
                                        ),
                                        Text(
                                          "Continue with Google",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ))),
                            Container(
                                width: double.infinity,
                                height: 94.w,
                                margin: EdgeInsets.only(top: 32.w),
                                child: ElevatedButton(
                                    onPressed: () {
                                      logic.facebookLogin();
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        94.w)))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 18.w),
                                          child: Image.asset(
                                            "assets/images/icons/facebook.png",
                                            width: 36.w,
                                            height: 36.w,
                                          ),
                                        ),
                                        Text(
                                          "Continue with Facebook",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ))),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.w),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text.rich(TextSpan(children: [
                                    const TextSpan(
                                        text:
                                            "By signing up, you agree to our "),
                                    TextSpan(
                                      text: "Terms, ",
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(78, 162, 79, 1)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed('/webview', arguments: {
                                            'title': 'Terms of Service',
                                            'url': ProjectConfig.getInstance()
                                                    ?.baseConfig[
                                                'TermsofServiceUrl']
                                          });
                                        },
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy.",
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(78, 162, 79, 1)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed('/webview', arguments: {
                                            'title': 'Privacy Policy',
                                            'url': ProjectConfig.getInstance()
                                                ?.baseConfig['PrivacyPolicyUrl']
                                          });
                                        },
                                    )
                                  ]))),
                            )
                          ],
                        )
                      ],
                    )),
              ),
            );
          }),
        );
      }),
    );
  }
}
