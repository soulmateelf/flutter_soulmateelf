/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:17
 * @FilePath: \soulmate\lib\views\base\password\controller.dart
 */
import 'package:get/get.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import '../../../utils/core/constants.dart';
import '../../../utils/core/httputil.dart';
import '../../../utils/tool/utils.dart';

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
      update();
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

  void next() {
    if (!checkPassword(password)) {
      exSnackBar(
          "assword format: The password consists of a 8-16 character string, which must contain at least two elements of numbers, letters and symbols.",
          type: ExSnackBarType.warning);
      return;
    }
    final arguments = Get.arguments;
    final codeType = arguments['codeType'];
    if (codeType == VerifyState.signUp) {
      HttpUtils.diorequst("/register",
          method: "post",
          params: {...arguments as Map, "password": password}).then((value) {
        requestLogin(arguments["email"], password).then((value) {
          Get.offAllNamed('/menu');
        }).whenComplete(() => null);
      }, onError: (err) {
        exSnackBar(err.toString());
      }).whenComplete(() {});
    } else if (codeType == VerifyState.forgot) {
      HttpUtils.diorequst("/forgetPassword", method: "post", params: {
        ...arguments as Map,
        "password": password,
        "newPassword": password,
      }).then((value) {
        Get.toNamed("/successfully");
      }, onError: (err) {
        exSnackBar(err.toString());
      }).whenComplete(() => {});
    }
  }
}
