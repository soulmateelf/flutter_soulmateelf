/*
 * @Date: 2023-04-10 14:49:30
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:57:40
 * @FilePath: \soulmate\lib\views\base\login\bloc.dart
 */
import "dart:async";

import "package:flutter_form_bloc/flutter_form_bloc.dart";
import "package:flutter_soulmateelf/utils/core/httputil.dart";
import "package:flutter_soulmateelf/utils/plugin/plugin.dart";
import "package:flutter_soulmateelf/widgets/library/projectLibrary.dart";
import "package:get/get.dart";

import "logic.dart";

class LoginFormBloc extends FormBloc<String, String> {
  final logic = Get.find<LoginLogic>();
  final email = TextFieldBloc(
    initialValue: "1404388651@qq.com",
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  static String? _min8Chars(String value) {
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  final password = TextFieldBloc(
    initialValue: "11111111",
    validators: [FieldBlocValidators.required, _min8Chars],
  );

  LoginFormBloc() {
    addFieldBlocs(fieldBlocs: [
      email,
      password,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {}
}
