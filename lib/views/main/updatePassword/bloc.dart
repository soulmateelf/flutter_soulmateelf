/*
 * @Date: 2023-04-12 19:10:18
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-19 14:27:17
 * @FilePath: \soulmate\lib\views\main\updatePassword\bloc.dart
 */
import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:get/get.dart';

class UpdatePasswordFormBloc extends FormBloc<String, String> {
  static String? _min8Chars(String value) {
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  final currentPassword = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    _min8Chars,
  ], asyncValidatorDebounceTime: const Duration(milliseconds: 300));
  final newPassword = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    _min8Chars,
  ]);
  final confirmNewPassword = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    _min8Chars,
  ]);
  Future<String?> _checkNewPassword(String? value) async {
    final pwd = await currentPassword.validate();

    if (newPassword.value != value) {
      return "Passwords do not match.";
    }
    if(pwd && currentPassword.value == value){
      return "The new password cannot be the same as the old password.";
    }
    return null;
  }

  Future<String?> _checkPassword(String value) async {
    final result = await NetUtils.diorequst("/base/existsPassword", 'post',
        params: {"password": value});
    if (result.data?["code"] == 205) {
      return "Password error";
    }
    return null;
  }

  UpdatePasswordFormBloc() {
    addFieldBlocs(
        fieldBlocs: [currentPassword, newPassword, confirmNewPassword]);
    currentPassword.addAsyncValidators([_checkPassword]);
    confirmNewPassword
      ..addAsyncValidators([_checkNewPassword])
      ..subscribeToFieldBlocs([newPassword]);
  }

  @override
  FutureOr<void> onSubmitting() {}
}
