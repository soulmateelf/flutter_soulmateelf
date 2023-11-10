import 'package:get/get.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:soulmate/utils/tool/utils.dart';

class MineUpdatePasswordController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool _showCurrentPassword = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  String _currentPasswordErrorText = "";
  String _passwordErrorText = "";
  String _confirmPasswordErrorText = "";

  validatePassword() {
    final success = checkPassword(passwordController.text);
    if (success) {
      passwordErrorText = "";
    } else {
      passwordErrorText =
          "The password consists of a 8-16 character string, which must contain at least two elements of numbers, letters and symbols.";
    }
  }

  validateConfirmPassword() {
    if (passwordController.text == confirmPasswordController.text) {
      confirmPasswordErrorText = "";
    } else {
      confirmPasswordErrorText = "Passwords do not match";
    }
  }

  String get currentPasswordErrorText => _currentPasswordErrorText;

  set currentPasswordErrorText(String value) {
    _currentPasswordErrorText = value;
    update();
  }

  bool get showCurrentPassword => _showCurrentPassword;

  set showCurrentPassword(bool value) {
    _showCurrentPassword = value;
    update();
  }

  bool get showPassword => _showPassword;

  set showPassword(bool value) {
    _showPassword = value;
    update();
  }

  bool get showConfirmPassword => _showConfirmPassword;

  set showConfirmPassword(bool value) {
    _showConfirmPassword = value;
    update();
  }

  @override
  void onReady() {
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        validatePassword();
      }
    });

    confirmPasswordFocusNode.addListener(() {
      if (!confirmPasswordFocusNode.hasFocus) {
        validateConfirmPassword();
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    confirmPasswordFocusNode.dispose();
    passwordFocusNode.dispose();
    currentPasswordFocusNode.dispose();
    confirmPasswordController.dispose();
    currentPasswordController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String get passwordErrorText => _passwordErrorText;

  set passwordErrorText(String value) {
    _passwordErrorText = value;
    update();
  }

  String get confirmPasswordErrorText => _confirmPasswordErrorText;

  set confirmPasswordErrorText(String value) {
    _confirmPasswordErrorText = value;
    update();
  }
}
