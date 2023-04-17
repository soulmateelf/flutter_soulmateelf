import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';

class TextToSpeechLogic extends GetxController {
  FlutterTts flutterTts = FlutterTts();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  final fb = FacebookLogin();
  @override
  void onInit() {
    super.onInit();
    return;
  }

  @override
  void onReady() {
    super.onReady();
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }

  speech() async {
    print(Get.locale);
    // var aa = await flutterTts.getEngines;
    // print(aa);
    // flutterTts.setVolume(1);
    // // tts.setRate(1),
    // flutterTts.setLanguage('en_US');
    // // tts.setPitch(1),
    // APPPlugin.logger.i('start1');
    //
    var voices = await flutterTts.getVoices;
    var aa = await flutterTts.getLanguages;
    print(voices);
    flutterTts.setVoice({'name': 'Grandpa', 'locale': 'en-GB'});
    await flutterTts.speak("hello baby");
    // var result = await flutterTts.speak("Hello World");
    // APPPlugin.logger.i(result);
  }

  googleLogin() async {
    GoogleSignInAccount? result = await _googleSignIn.signIn();
    ///{displayName: kele zxw, email: kelezxw@gmail.com, id: 103920106817470890713, photoUrl: https://lh3.googleusercontent.com/a/AGNmyxbsax2bXt55bBGEUSHb7Ghsaxjsm14OmqvIVuf2=s1337,}
    APPPlugin.logger.i(result);
  }
  faceBookLogin() async {
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
      // Logged in

      // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null)
          print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }
}
