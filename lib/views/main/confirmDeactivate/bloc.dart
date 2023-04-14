/*
 * @Date: 2023-04-13 09:44:10
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-14 17:46:13
 * @FilePath: \soulmate\lib\views\main\confirmDeactivate\bloc.dart
 */
import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ConfirmDeactivateFormBloc extends FormBloc<String, String> {
  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.passwordMin6Chars,
      FieldBlocValidators.required
    ],
    asyncValidatorDebounceTime: const Duration(milliseconds: 300),
  );

  Future<String?> _checkPassword(String? value) async {
    await Future.delayed(Duration(milliseconds: 300));
    return "password not match";
  }

  DeactivateFormBloc() {
    addFieldBlocs(fieldBlocs: [password]);
    password.addAsyncValidators([_checkPassword]);
  }

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
  }
}
