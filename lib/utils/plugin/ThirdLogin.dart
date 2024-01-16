
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:soulmate/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ThirdLogin {
  // google实例
  static GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  // google登录
  static void googleLogin() async {
    googleSignIn.isSignedIn().then((value) async {
      // 如果不退出，那已登录状态会保持一段时间，就不能达到切换账号的目的了
      if (value == true) {
        await googleSignIn.signOut();
      }
      GoogleSignInAccount? googleResult;
      try {
        googleResult = await googleSignIn.signIn();
      } catch (e) {
        exSnackBar("google login failed", type: ExSnackBarType.error );
        return;
      }
      if(googleResult == null){
        exSnackBar("google login failed", type: ExSnackBarType.error );
        return;
      }
      var params = {
        "threePartId": googleResult.id,
        "nickName": googleResult.displayName,
        "email": googleResult.email,
        "avatar": googleResult.photoUrl,
        "pushId": Application.pushId,
        "platform": GetPlatform.isAndroid ? 'android' : 'ios',
        "buildNumber": APPPlugin.appInfo?.buildNumber,
        "sdkVersion": APPPlugin.appInfo?.version
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
  static void appleIdLogin() async {
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
      "pushId": Application.pushId,
      "platform": GetPlatform.isAndroid ? 'android' : 'ios',
      "buildNumber": APPPlugin.appInfo?.buildNumber,
      "sdkVersion": APPPlugin.appInfo?.version
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
}
