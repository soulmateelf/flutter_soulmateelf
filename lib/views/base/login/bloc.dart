/*
 * @Date: 2023-04-10 14:49:30
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-18 14:08:03
 * @FilePath: \soulmate\lib\views\base\login\bloc.dart
 */
import "dart:async";

import "package:flutter_form_bloc/flutter_form_bloc.dart";
import "package:flutter_soulmateelf/utils/core/httputil.dart";
import "package:flutter_soulmateelf/utils/plugin/plugin.dart";
import "package:get/get.dart";

import "logic.dart";

class LoginFormBloc extends FormBloc<String, String> {
  final logic = Get.find<LoginLogic>();
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars
    ],
  );

  LoginFormBloc() {
    addFieldBlocs(fieldBlocs: [
      email,
      password,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
   try{
     final result = await NetUtils.diorequst("/base/login", 'post', params: {
      "email": email.value,
      "password": password.value,
    });
    print(result);
    APPPlugin.logger.d(result?.data);
    if (result?.data?["code"] == 200) {
    } else {
      
    }
   }catch(e){
    APPPlugin.logger.e('error');
   }

    // Get.toNamed('/home');
    return Future(() => false);
  }
}
