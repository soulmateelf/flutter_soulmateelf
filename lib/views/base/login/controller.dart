/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:17
 * @FilePath: \soulmate\lib\views\base\login\controller.dart
 */
import 'dart:convert';

import 'package:get/get.dart';
import 'package:soulmate/utils/tool/utils.dart';

class LoginController extends GetxController {
  var email = "";
  var password = "";
  var emailErrorText = null;
  var passwordErrorText = null;

  var passwordVisible = false;

  void validateEmail(String email) {
    final isEmail = GetUtils.isEmail(email);
    if (isEmail) {
      emailErrorText = null;
    } else {
      emailErrorText = "Please enter a valid email.";
    }
    validateNext();
    update();
  }

  void validatePassword(String password) {
    final isPassword = password.length >= 8;
    if (isPassword) {
      passwordErrorText = null;
    } else {
      passwordErrorText = "Please enter a valid password.";
    }
    validateNext();
    update();
  }

  bool nextBtnDisabled = true;

  /// 判断是否可以进行下一步 对按钮控制的状态做禁用
  validateNext() {
    if (email.length > 0 &&
        password.length > 0 &&
        emailErrorText == null &&
        passwordErrorText == null) {
      nextBtnDisabled = false;
    } else {
      nextBtnDisabled = true;
    }
  }

  togglePasswordVisible() {
    passwordVisible = !passwordVisible;
    update();
  }

  void login() {
    requestLogin(email, password).then((value) {
      if (value['code'] == 200) {
        Get.offAllNamed('/menu');
      }
    }).whenComplete(() => null);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
