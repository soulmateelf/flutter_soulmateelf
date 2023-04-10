/*
 * @Date: 2023-04-10 14:49:30
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-10 20:01:02
 * @FilePath: \soulmate\lib\views\base\setPassword\bloc.dart
 */
import "dart:async";

import "package:flutter_form_bloc/flutter_form_bloc.dart";

class SetPasswordFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
    asyncValidatorDebounceTime: const Duration(milliseconds: 300),
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars
    ],
  );

  Future<String?> _checkEmail(String? email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (email!.toLowerCase() != "123@qq.com") {
      return "Email has already been taken.";
    }
    return null;
  }

  SignUpFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
    email.addAsyncValidators([_checkEmail]);
  }

  @override
  FutureOr<void> onSubmitting() {}
}
