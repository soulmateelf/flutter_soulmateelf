import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginLogic extends GetxController {
  //google登录
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  //facebook登录
  final facebookSignIn = FacebookLogin();

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
    Map<String, dynamic> params = {
      'type': 1, //1:google 2:facebook
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
        EasyLoading.showToast('something wrong');
        return;
    }
  }

  //第三方登录
  void thirdLogin(params) {
    if (Utils.isEmpty(params['loginId']) ||
        Utils.isEmpty(params['nickName']) ||
        Utils.isEmpty(params['email'])) {
      EasyLoading.showToast('something wrong');
      return;
    }
    EasyLoading.show(status: 'loading...');
    void successFn(res) {
      EasyLoading.dismiss();
      Application.userInfo = res?["data"];
      Application.token = res?["token"];
      Get.offNamed('/home');
    }

    void errorFn(error) {
      EasyLoading.dismiss();
      EasyLoading.showToast(error['message'],
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
