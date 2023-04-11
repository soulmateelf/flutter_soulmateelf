/*
 * @Date: 2023-04-10 14:49:30
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-11 16:25:50
 * @FilePath: \soulmate\lib\views\base\setPassword\bloc.dart
 */
import "dart:async";

import "package:flutter_form_bloc/flutter_form_bloc.dart";
import "package:flutter_soulmateelf/views/base/login/logic.dart";
import "package:get/get.dart";

class SetPasswordFormBloc extends FormBloc<String, String> {
  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars
    ],
  );

  final confirmPassword = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.passwordMin6Chars
  ], asyncValidatorDebounceTime: Duration(milliseconds: 300));

  Future<String?> _checkPassword(String? value) async {
    await Future.delayed(Duration(milliseconds: 300));
    if (password.value != value) {
      return "Passwords do not match.";
    }
    return null;
  }

  SetPasswordFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        password,
        confirmPassword,
      ],
    );

    confirmPassword
      ..addAsyncValidators([_checkPassword])
      ..subscribeToFieldBlocs([password]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    Get.toNamed('/continue', arguments: Get.arguments);
  }
}
