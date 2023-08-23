/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:17
 * @FilePath: \soulmate\lib\views\base\login\logic.dart
 */
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginLogic extends GetxController {
  //google登录
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  //facebook登录
  // final facebookSignIn = FacebookLogin();

  //google登录
  void googleLogin() async {
    GoogleSignInAccount? googleResult = await googleSignIn.signIn();

    ///{displayName: kele zxw, email: kelezxw@gmail.com, id: 1069*******, photoUrl: https://lh3.googleusercontent.com/a/AGNmyxbsax2bXt55bBGEUSHb7Ghsaxjsm14OmqvIVuf2=s1337,}
    thirdLogin({
      'type': 1, //1:google 2:facebook
      'loginId': googleResult!.id?.toString(),
      'nickName': googleResult?.displayName,
      'image': googleResult?.photoUrl,
      'email': googleResult?.email,
    });
  }

  //facebook登录
  void facebookLogin() async {
    /*
    Map<String, dynamic> params = {
      'type': 2, //1:google 2:facebook
    };
    final fbResult =
        await facebookSignIn.logIn(permissions: [FacebookPermission.email]);
    // Check result status
    switch (fbResult.status) {
      case FacebookLoginStatus.success:
        // Get profile data
        final profile = await facebookSignIn.getUserProfile();
        params['loginId'] = profile?.userId;
        params['nickName'] = profile?.name;
        // Get user profile image url
        final imageUrl = await facebookSignIn.getProfileImageUrl(width: 100);
        params['image'] = imageUrl;
        // Get email (since we request email permission)
        final email = await facebookSignIn.getUserEmail();
        params['email'] = email;
        //登录
        thirdLogin(params);
        return;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        return;
      case FacebookLoginStatus.error:
        // Log in failed
        Loading.toast('something wrong');
        return;
    }
     */
  }

  //第三方登录
  void thirdLogin(params) {
    if (Utils.isEmpty(params['loginId']) ||
        Utils.isEmpty(params['nickName']) ||
        Utils.isEmpty(params['email'])) {
      Loading.toast('something wrong');
      return;
    }
    Loading.show();
    void successFn(res) {
      Loading.dismiss();
      Application.userInfo = res?["data"];
      Application.token = res?["token"];
      Get.offNamed('/home');
    }

    void errorFn(error) {
      Loading.dismiss();
      Loading.toast(error['message'],
          toastPosition: EasyLoadingToastPosition.top);
    }

    NetUtils.diorequst(
      '/base/loginType',
      'post',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }
}
