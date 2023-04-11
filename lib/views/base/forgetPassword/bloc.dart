/*
 * @Date: 2023-04-11 16:45:40
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-11 17:05:45
 * @FilePath: \soulmate\lib\views\base\forgetPassword\bloc.dart
 */
import 'dart:async';

import 'package:form_bloc/form_bloc.dart';
import 'package:get/get.dart';

class ForgetPasswordFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.email,
  ], asyncValidatorDebounceTime: const Duration(milliseconds: 300));

  Future<String?> _checkEmail(String? value) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (value!.length < 16) {
      return "length < 16 ";
    }
    return null;
  }

  ForgetPasswordFormBloc() {
    addFieldBlocs(fieldBlocs: [email]);
    email.addAsyncValidators([_checkEmail]);
  }

  @override
  FutureOr<void> onSubmitting() {
    Get.toNamed('/verification', arguments: {
      "setPasswordPageTitle": "Choose a new password",
      "continuePageTitle": "Your’ve successfully changed your password."
    });
  }
}
