/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-11 16:25:16
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

import 'bloc.dart';

class SetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    return BlocProvider(
      create: (context) => SetPasswordFormBloc(),
      child: Builder(builder: (context) {
        // 表单bloc
        final setPasswordFormBloc = context.read<SetPasswordFormBloc>();
        final title = Get.arguments?["setPasswordPageTitle"] ?? "Create your password.";
        return Scaffold(
          appBar:backBar(),
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
                                setPasswordFormBloc.submit();
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
