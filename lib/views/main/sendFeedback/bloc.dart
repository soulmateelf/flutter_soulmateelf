/*
 * @Date: 2023-04-13 14:42:11
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-14 17:22:24
 * @FilePath: \soulmate\lib\views\main\sendFeedback\bloc.dart
 */
import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';

class SendFeedbackFormBloc extends FormBloc<String, String> {
  /// 反馈
  final feedback = TextFieldBloc(validators: [FieldBlocValidators.required]);

  /// 图片文件
  final files = MultiSelectFieldBloc();

  /// Email
  final email = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    Utils.customEmailValidators,
  ]);

  /// 允许电子邮件发送更多信息
  final allowConcact = BooleanFieldBloc();

  SendFeedbackFormBloc() {
    addFieldBlocs(fieldBlocs: [
      feedback,
      files,
      allowConcact,
    ]);

    allowConcact.onValueChanges(
      onData: (previous, current) async* {
        if (current.value) {
          addFieldBlocs(fieldBlocs: [email]);
        } else {
          removeFieldBlocs(fieldBlocs: [email]);
        }
      },
    );
  }

  @override
  FutureOr<void> onSubmitting() {
    // TODO: implement onSubmitting
  }
}
