import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get.dart';

class UpdatePasswordFormBloc extends FormBloc<String, String> {
  final currentPassword = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.passwordMin6Chars,
  ]);
  final newPassword = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.passwordMin6Chars,
  ]);
  final confirmNewPassword = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.passwordMin6Chars,
  ], asyncValidatorDebounceTime: const Duration(milliseconds: 300));

  Future<String?> _checkPassword(String? value) async {
    await Future.delayed(Duration(milliseconds: 300));
    if (newPassword.value != value) {
      return "Passwords do not match.";
    }
    return null;
  }

  UpdatePasswordFormBloc() {
    addFieldBlocs(
        fieldBlocs: [currentPassword, newPassword, confirmNewPassword]);
    confirmNewPassword
      ..addAsyncValidators([_checkPassword])
      ..subscribeToFieldBlocs([newPassword]);
  }

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
    Get.back();
  }
}
