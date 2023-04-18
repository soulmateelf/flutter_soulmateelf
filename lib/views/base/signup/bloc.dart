/*
 * @Date: 2023-04-10 14:49:30
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-17 20:00:27
 * @FilePath: \soulmate\lib\views\base\signup\bloc.dart
 */
import "dart:async";

import "package:flutter_form_bloc/flutter_form_bloc.dart";
import "package:flutter_soulmateelf/utils/core/httputil.dart";
import "package:flutter_soulmateelf/utils/plugin/plugin.dart";
import "package:get/get.dart";

class SignUpFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
    asyncValidatorDebounceTime: const Duration(milliseconds: 300),
  );

  final nickname = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  Future<String?> _checkEmail(String? email) async {
    if (email == null) {
      return null;
    }
    final result = await NetUtils.diorequst("/base/emailExists", 'post',
        params: {"email": email});

    if (result?.data?["code"] == 500) {
      return "Email has already been taken.";
    }

    return null;
  }

  SignUpFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        nickname,
      ],
    );
    email.addAsyncValidators([_checkEmail]);
  }

  @override
  FutureOr<void> onSubmitting() {
      Get.toNamed('/verification', arguments: {
          "setPasswordPageTitle": "Create your password",
          "continuePageTitle": "Your’ve successfully Created your password.",
          "email": email.value,
          "nickname": nickname.value,
          "type": "register",
        });
  }
}
