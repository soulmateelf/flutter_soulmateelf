/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:17
 * @FilePath: \soulmate\lib\views\base\password\controller.dart
 */
import 'package:get/get.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

class PasswordController extends GetxController {
  var confirmPassword = "";
  var password = "";
  var confirmPasswordErrorText = null;
  var passwordErrorText = null;

  var passwordVisible = false;
  var confirmPasswordVisible = false;

  void validateConfirmPassword(String confirmPassword) {
    final isConfirmPassword = password == confirmPassword;
    final prevErrorText = confirmPasswordErrorText;
    if (isConfirmPassword) {
      confirmPasswordErrorText = null;
    } else {
      confirmPasswordErrorText = "Please enter a valid confirmPassword.";
    }
    if (prevErrorText != confirmPasswordErrorText) {
      validateNext();
      update();
    }
  }

  void validatePassword(String password) {
    final isPassword = password.length > 8;
    final prevErrorText = passwordErrorText;
    if (isPassword) {
      passwordErrorText = null;
    } else {
      passwordErrorText = "Please enter a valid password.";
    }
    if (prevErrorText != passwordErrorText) {
      validateNext();
      update();
    }
  }

  bool nextDisable = false;

  /// 判断是否可以进行下一步 对按钮控制的状态做禁用
  validateNext() {
    if (confirmPassword.length > 0 &&
        password.length > 0 &&
        confirmPasswordErrorText == null &&
        passwordErrorText == null) {
      nextDisable = false;
    } else {
      nextDisable = true;
    }
  }

  togglePasswordVisible() {
    passwordVisible = !passwordVisible;
    update();
  }

  toggleConfirmPasswordVisible() {
    confirmPasswordVisible = !confirmPasswordVisible;
    update();
  }
}
