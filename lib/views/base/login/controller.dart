/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:17
 * @FilePath: \soulmate\lib\views\base\login\controller.dart
 */
import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import '../../../utils/tool/utils.dart';

class LoginController extends GetxController {
  var email = "";
  var password = "";
  var emailErrorText = null;
  var passwordErrorText = null;

  var passwordVisible = false;

  // google实例
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  // google登录
  void googleLogin() async {
    googleSignIn.isSignedIn().then((value) async {
      // 如果不退出，那已登录状态会保持一段时间，就不能达到切换账号的目的了
      if (value == true) {
        await googleSignIn.signOut();
      }
      GoogleSignInAccount? googleResult = await googleSignIn.signIn();
      if(googleResult == null){
        return;
      }
      var params = {
        "threePartId": googleResult.id,
        "nickName": googleResult.displayName,
        "email": googleResult.email,
        "avatar": googleResult.photoUrl,
      };
      HttpUtils.diorequst('/googleLogin',method: 'post', params: params)
          .then((response) {
        var userInfoMap = response["data"];
        User user = User.fromJson(userInfoMap);
        /// 存储全局信息
        Application.token = response["token"];
        Application.userInfo = user;
        Get.offAllNamed('/menu');
      }).catchError((error) {
        exSnackBar(error, type: ExSnackBarType.error);
      });
    });
  }

  // apple登录
  void appleIdLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    if(credential == null){
      return;
    }
    var params = {
      "appleLoginId": credential.userIdentifier,
      "nickName": "${credential.givenName??''} ${credential.familyName??''}",
      "email": credential.email,
    };
    HttpUtils.diorequst('/appleLogin',method: 'post', params: params)
        .then((response) {
      var userInfoMap = response["data"];
      User user = User.fromJson(userInfoMap);
      /// 存储全局信息
      Application.token = response["token"];
      Application.userInfo = user;
      Get.offAllNamed('/menu');
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

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
}
