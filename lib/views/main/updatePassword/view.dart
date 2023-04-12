import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/views/main/updatePassword/bloc.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';

class UpdatePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    InputDecoration getInputDecoration({
      required String label,
    }) {
      return InputDecoration(
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
                              bloc.submit();
                            },
                            child: Text(
                              "Next",
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
