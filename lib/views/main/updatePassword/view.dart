/*
 * @Date: 2023-04-12 19:06:54
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:14:46
 * @FilePath: \soulmate\lib\views\main\updatePassword\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/views/main/updatePassword/bloc.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class UpdatePasswordPage extends StatelessWidget {
  _submit(UpdatePasswordFormBloc bloc) async {
    final blocs = bloc.state.fieldBlocs()?.values ?? [];
    final validates = await Future.wait(blocs.map((e) => e.validate()));
    final validate = validates.every((element) => element);
    if (!validate) {
      return;
    }

    final result =
        await NetUtils.diorequst("/base/updatePassword", 'post', params: {
      "newPassword": bloc.newPassword.value,
      "oldPassword": bloc.currentPassword.value,
    });
    if (result.data?["code"] == 200) {
      Loading.success("success");
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    InputDecoration getInputDecoration({
      required String label,
    }) {
      return InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.w)),
            borderSide: BorderSide(width: 1.w)),
        label: Text(label),
        helperText: "",
      );
    }

    return basePage("Update password",
        child: BlocProvider(
          create: (context) => UpdatePasswordFormBloc(),
          child: Builder(
            builder: (context) {
              final bloc = context.read<UpdatePasswordFormBloc>();
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      TextFieldBlocBuilder(
                        textFieldBloc: bloc.currentPassword,
                        suffixButton: SuffixButton.asyncValidating,
                        obscureText: true,
                        decoration:
                            getInputDecoration(label: "Current password"),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: bloc.newPassword,
                        suffixButton: SuffixButton.obscureText,
                        decoration: getInputDecoration(label: "New password"),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: bloc.confirmNewPassword,
                        suffixButton: SuffixButton.obscureText,
                        decoration:
                            getInputDecoration(label: "Confirm password"),
                      ),
                      Container(
                        width: double.infinity,
                        height: 88.w,
                        margin: EdgeInsets.only(top: 20.w),
                        child: ElevatedButton(
                            onPressed: () {
                              _submit(bloc);
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(fontSize: 28.sp),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
