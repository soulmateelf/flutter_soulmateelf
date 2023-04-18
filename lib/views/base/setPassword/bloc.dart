/*
 * @Date: 2023-04-10 14:49:30
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-18 10:25:44
 * @FilePath: \soulmate\lib\views\base\setPassword\bloc.dart
 */
import "dart:async";

import "package:flutter_form_bloc/flutter_form_bloc.dart";
import "package:flutter_soulmateelf/utils/core/httputil.dart";
import "package:flutter_soulmateelf/utils/plugin/plugin.dart";
import "package:flutter_soulmateelf/views/base/login/logic.dart";
import "package:get/get.dart";

class SetPasswordFormBloc extends FormBloc<String, String> {
  static String? _min8Chars(String value) {
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      _min8Chars,
    ],
  );

  final confirmPassword = TextFieldBloc(
      validators: [FieldBlocValidators.required, _min8Chars],
      asyncValidatorDebounceTime: Duration(milliseconds: 300));

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
    final email = Get.arguments["email"];
    final nickname = Get.arguments["nickname"];
    final pwd = password.value;

    if (email != null && nickname != null && pwd != null) {
      final result =
          await NetUtils.diorequst("/base/register", 'post', params: {
        "email": email,
        "nickName": nickname,
        "password": pwd,
      });
      APPPlugin.logger.d(result);
      dynamic arguments = Get.arguments;
      arguments["password"] = password.value;
      Get.toNamed('/continue', arguments: arguments);
    }
  }
}
