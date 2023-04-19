import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get.dart';

class UpdateNicknameFormBloc extends FormBloc<String, String> {
  final nickname = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  UpdateNicknameFormBloc() {
    addFieldBlocs(fieldBlocs: [nickname]);
  }

  @override
  FutureOr<void> onSubmitting() {
  }
}
