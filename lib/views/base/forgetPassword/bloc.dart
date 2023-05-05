/*
 * @Date: 2023-04-11 16:45:40
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-18 18:28:09
 * @FilePath: \soulmate\lib\views\base\forgetPassword\bloc.dart
 */
import 'dart:async';

import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:get/get.dart';

import '../../../utils/core/httputil.dart';
import '../../../utils/plugin/plugin.dart';

class ForgetPasswordFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    Utils.customEmailValidators,
  ], asyncValidatorDebounceTime: const Duration(milliseconds: 300));

  Future<String?> _checkEmail(String? email) async {
    if (email == null) {
      return null;
    }
    final result = await NetUtils.diorequst("/base/emailExists", 'post',
        params: {"email": email});
    if (!result?.data?["exists"]) {
      return "The email address does not exist";
    }

    return null;
  }

  ForgetPasswordFormBloc() {
    addFieldBlocs(fieldBlocs: [email]);
    email.addAsyncValidators([_checkEmail]);
  }

  @override
  FutureOr<void> onSubmitting() {}
}
