/*
 * @Date: 2023-04-13 09:44:10
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-18 19:17:05
 * @FilePath: \soulmate\lib\views\main\confirmDeactivate\bloc.dart
 */
import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ConfirmDeactivateFormBloc extends FormBloc<String, String> {
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

  ConfirmDeactivateFormBloc() {
    addFieldBlocs(fieldBlocs: [password]);
  }

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
  }
}
