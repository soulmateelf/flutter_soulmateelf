/*
 * @Date: 2023-04-10 14:14:57
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:56
 * @FilePath: \soulmate\lib\views\base\welcome\controller.dart
 */


import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class WelcomeController extends GetxController {
  // 上次点击返回键时间
  int lastClickTime = 0;
  // google实例
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  // facebook实例
  final facebookSignIn = FacebookAuth.instance;

  // google登录
  void googleLogin() async {
    googleSignIn.isSignedIn().then((value) async{
      // 如果不退出，那已登录状态会保持一段时间，就不能达到切换账号的目的了
      if(value == true){
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
  void facebookLogin() async {
    facebookSignIn.login(permissions: ['public_profile']);
    return;
    print(FacebookAuth.instance.accessToken.then((value){
      print(value);
    }));
    // return;
    // by default we request the email and the public profile
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print(accessToken);
      print(result);
    } else {
      print(22222);
      print(result.status);
      print(result.message);
    }
    // thirdLogin({
    //   'type': 1, //1:google 2:facebook
    //   'loginId': googleResult!.id?.toString(),
    //   'nickName': googleResult?.displayName,
    //   'image': googleResult?.photoUrl,
    //   'email': googleResult?.email,
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
