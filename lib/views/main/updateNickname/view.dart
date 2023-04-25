/*
 * @Date: 2023-04-14 17:35:00
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:14:11
 * @FilePath: \soulmate\lib\views\main\updateNickname\view.dart
 */
/*
 * @Date: 2023-04-14 17:35:00
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-14 17:43:25
 * @FilePath: \soulmate\lib\views\main\updateNickname\view.dart
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

import 'bloc.dart';

class UpdateNicknamePage extends StatelessWidget {
  _submit(UpdateNicknameFormBloc bloc) async {
    final nicknameValidate = await bloc.nickname.validate();
    if (!nicknameValidate) return;
    final userInfo = Application.userInfo;
    if (userInfo != null) {
      Loading.show();
      final result = await NetUtils.diorequst("/base/update", 'post', params: {
        "userId": userInfo["userId"],
        "nickName": bloc.nickname.value
      });
      Loading.dismiss();

      /// 这里应该返回用户信息
      if (result?.data?["code"] == 200) {
        if (result?.data?["data"] != null) {
          Application.userInfo = result?.data?["data"];
        }
        Loading.success("success");
        Get.back();
      }
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

    return basePage("Update Nickname",
        child: BlocProvider(
          create: (context) => UpdateNicknameFormBloc(),
          child: Builder(
            builder: (context) {
              final bloc = context.read<UpdateNicknameFormBloc>();

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      TextFieldBlocBuilder(
                        textFieldBloc: bloc.nickname,
                        decoration:
                            getInputDecoration(label: "update Nickname"),
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
