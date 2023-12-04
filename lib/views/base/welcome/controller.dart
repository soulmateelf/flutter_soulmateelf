/*
 * @Date: 2023-04-10 14:14:57
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:56
 * @FilePath: \soulmate\lib\views\base\welcome\controller.dart
 */

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class WelcomeController extends GetxController {
  // 上次点击返回键时间
  int lastClickTime = 0;
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
      print(googleResult);
    });
    // Get.toNamed("/signUp");
    ///{displayName: kele zxw, email: kelezxw@gmail.com, id: 1069*******, photoUrl: https://lh3.googleusercontent.com/a/AGNmyxbsax2bXt55bBGEUSHb7Ghsaxjsm14OmqvIVuf2=s1337,}
    // thirdLogin({
    //   'type': 1, //1:google 2:facebook
    //   'loginId': googleResult!.id?.toString(),
    //   'nickName': googleResult?.displayName,
    //   'image': googleResult?.photoUrl,
    //   'email': googleResult?.email,
    // });
  }

  // facebook登录
  void appleIdLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    // thirdLogin({
    //   'type': 3, //1:google 2:facebook 3 appleId
    //   'loginId': credential.userIdentifier,
    //   'nickName': "${credential.givenName??''} ${credential.familyName??''}",
    //   'image': '',
    //   'email': credential?.email,
    // });
  }

  /// Author: kele
  /// Date: 2022-03-08 15:12:36
  /// Params:
  /// Return:
  /// Description: 处理安卓返回键
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:
  Future<bool> dealBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClickTime > 1000) {
      lastClickTime = DateTime.now().millisecondsSinceEpoch;
      Loading.toast('再按一次退出应用');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
