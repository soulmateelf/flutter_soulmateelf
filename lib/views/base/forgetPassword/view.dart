/*
 * @Date: 2023-04-11 16:39:03
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-18 18:30:17
 * @FilePath: \soulmate\lib\views\base\forgetPassword\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/views/base/forgetPassword/bloc.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  _submit(ForgetPasswordFormBloc bloc) async {
    final emailValidate = await bloc.email.validate();
    if (emailValidate) {
      Get.toNamed('/verification', arguments: {
        "setPasswordPageTitle": "Choose a new password",
        "continuePageTitle": "Your’ve successfully changed your password.",
        "type": "forget",
        "email": bloc.email.value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    return BlocProvider(
      create: (context) => ForgetPasswordFormBloc(),
      child: Builder(
        builder: (context) {
          final forgetPasswordFormBloc = context.read<ForgetPasswordFormBloc>();
          return Scaffold(
            appBar: backBar(),
            body: Container(
              padding: EdgeInsets.all(20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Find your account",
                        style: TextStyle(
                          fontSize: 48.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 67.w),
                      child: TextFieldBlocBuilder(
                        textFieldBloc: forgetPasswordFormBloc.email,
                        suffixButton: SuffixButton.asyncValidating,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                            labelText: "Email",
                            helperText: " ",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.w)),
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: const Color.fromRGBO(230, 230, 230, 1),
                                ))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 54.w),
                      width: double.infinity,
                      height: 94.h,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(78, 162, 79, 1))),
                          onPressed: () {
                            _submit(forgetPasswordFormBloc);
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(fontSize: 36.sp),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
