import 'dart:convert';
import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:flutter_plugin_record_plus/flutter_plugin_record.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TextToSpeechController extends GetxController {
  // FlutterTts flutterTts = FlutterTts();
  //可以选的声音
  List<dynamic> voicesList = [];
  //当前选择的声音
  dynamic currentVoice;
  //google登录
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  //facebook登录
  // final fb = FacebookLogin();
  //语音转文字
  SpeechToText speechToText = SpeechToText();
  //语音转文字是否可用
  bool speechEnabled = false;
  //识别结果
  String lastWords = '';
  //录音
  // FlutterPluginRecord recordPlugin = FlutterPluginRecord();
  //录音文件路径
  // String recordPath = '';
  //录音文件大小
  // double recordTime = 0;

  @override
  void onInit() {
    super.onInit();
    //获取可选的声音
    getVoice();
    //初始化语音转文字
    initSpeechToText();
    //初始化录音
    initRecord();
    return;
  }

  getVoice() async {
    // List<dynamic> voicesAll = await flutterTts.getVoices;
    // print('all:${voicesAll.length}');
    // voicesList = voicesAll.where((element) => element['locale'] == 'en-US').toList();
    // voicesList = voicesAll;
    // print('voicesList:${voicesList.length}');
    return;
  }

  choiceVoice() async {
    final result = await showModalActionSheet(
      context: Get.context!,
      title: '选择声音',
      message: '请选择你喜欢的声音',
      actions: voicesList
          .map((e) => SheetAction(
                label: e['name']!,
                key: e,
              ))
          .toList(),
    );
    if (result != null) {
      print(result);
      currentVoice = result;
      // flutterTts.setVoice({
      //   'name': (result as dynamic)['name'],
      //   'locale': (result as dynamic)['locale']
      // });
    }
    update();
  }

  speech() async {
    // flutterTts.setVoice({'name': 'Good News', 'locale': 'en-US'});
    // var result = await flutterTts.speak("Hello, what is your name?");
  }

  googleLogin() async {
    GoogleSignInAccount? result = await _googleSignIn.signIn();

    ///{displayName: kele zxw, email: kelezxw@gmail.com, id: 103920106817470890713, photoUrl: https://lh3.googleusercontent.com/a/AGNmyxbsax2bXt55bBGEUSHb7Ghsaxjsm14OmqvIVuf2=s1337,}
  }

  faceBookLogin() async {
    /*
    // Log in
    final res = await fb.logIn(permissions: [
      // FacebookPermission.publicProfile,
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
        if (email != null) print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
     */
  }

  systemShare(BuildContext context) async {
    // var shareResult = await Share.shareWithResult(
    //     'code:#123456;downLoadUrl:https://whatsapp.com/dl/',
    //     subject: 'Look what I made!',
    // );
    var shareResult = await Share.shareWithResult(
      'downLoadUrl:https://youtu.be/lJDnnowkS4A\ncode:https://icyberelf.com/PrivacyPolicy.html',
      // '环境的角度看建档立卡打开了贷款了:\ndownLoadUrl:\nhttps://youtu.be/lJDnnowkS4A',
      subject: 'Look what I made!',
    );
    // final data = await rootBundle.load('assets/images/icons/avatar.png');
    // final buffer = data.buffer;
    // final shareResult = await Share.shareXFiles(
    //   [
    //     XFile.fromData(
    //       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    //       name: 'flutter_logo.png',
    //       mimeType: 'image/png',
    //     ),
    //   ],
    //   subject: 'I am subject!',
    //   text: 'code:123456;downLoadUrl:https://icyberelf.com/PrivacyPolicy.html;',
    // );
  }

  initSpeechToText() async {
    speechEnabled = await speechToText.initialize();
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    update();
  }

  void stopListening() async {
    await speechToText.stop();
    update();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    update();
  }

  initRecord() async {
    /*
    print('record init');
    recordPlugin.response.listen((data) {
      if (data.msg == "onStop") {
        ///结束录制时会返回录制文件的地址方便上传服务器
        // widget.stopRecord(data.path, data.audioTimeLength, isUp);
        print('监听到录音结束');
        recordPath = data.path!;
        recordTime = data.audioTimeLength!;
        update();
      } else if (data.msg == "onStart") {
        print('监听到录音开始');
      }
    });
    */
  }
  playAudio() {
    /*
    print(recordTime);
    update();
    recordPlugin.playByPath(recordPath, 'file');
    */
  }
}
