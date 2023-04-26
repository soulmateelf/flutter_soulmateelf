/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:00:49
 * @FilePath: \soulmate\lib\views\base\setPassword\view.dart
 */
/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

import '../../../utils/core/httputil.dart';
import '../../../utils/plugin/plugin.dart';
import 'bloc.dart';

class SetPasswordPage extends StatelessWidget {
  _submit(SetPasswordFormBloc bloc) async {
    final email = Get.arguments["email"];
    final nickname = Get.arguments["nickname"];
    final type = Get.arguments["type"];
    final code = Get.arguments["code"];
    final pwd = bloc.password.value;

    if (type == "forget") {
      if (email != null && pwd != null) {
        Loading.show();
        final result =
            await NetUtils.diorequst("/base/forget", 'post', params: {
          "email": email,
          "code": code,
          "password": pwd,
        });
        Loading.dismiss();
        if (result?.data?["code"] == 200) {
          dynamic arguments = Get.arguments;
          arguments["password"] = pwd;
          Get.toNamed('/continue', arguments: arguments);
        }
      }
    } else if (type == "register") {
      if (email != null && nickname != null && pwd != null) {
        Loading.show();
        final result =
            await NetUtils.diorequst("/base/register", 'post', params: {
          "email": email,
          "nickName": nickname,
          "password": pwd,
        });
        Loading.dismiss();
        if (result?.data?["code"] == 200) {
          dynamic arguments = Get.arguments;
          arguments["password"] = pwd;
          Get.toNamed('/continue', arguments: arguments);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetPasswordFormBloc(),
      child: Builder(builder: (context) {
        // 表单bloc
        final setPasswordFormBloc = context.read<SetPasswordFormBloc>();
        final title =
            Get.arguments?["setPasswordPageTitle"] ?? "Create your password.";
        return Scaffold(
          appBar: backBar(),
          body: FormBlocListener<SetPasswordFormBloc, String, String>(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 48.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 68.w),
                          child: TextFieldBlocBuilder(
                            autofocus: true,
                            textFieldBloc: setPasswordFormBloc.password,
                            autofillHints: const [
                              AutofillHints.password,
                            ],
                            suffixButton: SuffixButton.obscureText,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Password",
                                helperText: " ",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.w)),
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
                            textFieldBloc: setPasswordFormBloc.confirmPassword,
                            suffixButton: SuffixButton.obscureText,
                            autofillHints: const [AutofillHints.password],
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Confirm password",
                                helperText: " ",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.w)),
                                    borderSide: BorderSide(
                                      width: 1.w,
                                      color: const Color.fromRGBO(
                                          230, 230, 230, 1),
                                    ))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.w),
                          width: double.infinity,
                          height: 94.w,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(78, 162, 79, 1))),
                              onPressed: () {
                                _submit(setPasswordFormBloc);
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(fontSize: 36.sp),
                              )),
                        )
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
