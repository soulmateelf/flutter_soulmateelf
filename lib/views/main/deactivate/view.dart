import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/views/main/deactivate/bloc.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';

class DeactivatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => DeactivateFormBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<DeactivateFormBloc>();
          return Scaffold(
            appBar: backBar(),
            body: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Confirm your password",
                      style: TextStyle(
                        fontSize: 48.sp,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 15.w),
                      child: Text(
                        "Complete your deactivation request by entering the password associated with your account.",
                        style: TextStyle(
                          color: Color.fromRGBO(102, 102, 102, 1),
                          fontSize: 22.sp,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 40.w),
                    child: TextFieldBlocBuilder(
                      textFieldBloc: bloc.password,
                      suffixButton: SuffixButton.asyncValidating,
                      decoration: InputDecoration(
                          label: Text("Password"),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.w,
                                  color: Color.fromRGBO(230, 230, 230, 1)))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 54.w),
                    width: double.infinity,
                    height: 88.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: Text(
                        "Deactivate",
                        style: TextStyle(fontSize: 28.sp),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
