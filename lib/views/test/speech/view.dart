////////////////////////
///Author: guohl
///Date: 2022-02-08 09:30:30
///LastEditors: guohl
///LastEditTime: 2022-02-09 15:40:33
///Description:
////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TextToSpeechPage extends StatelessWidget {
  FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(TextToSpeechLogic());
    List<Object?> voices;
    return GetBuilder<TextToSpeechLogic>(builder: (logic) {
      return basePage('测试text-to-speech', child:
          ElevatedButton(
            child: const Text('speech'),
            onPressed: () async {
              print(Get.locale);
              // var aa = await flutterTts.getEngines;
              // print(aa);
              // flutterTts.setVolume(1);
              // // tts.setRate(1),
              // flutterTts.setLanguage('en_US');
              // // tts.setPitch(1),
              // APPPlugin.logger.i('start1');
              //
              voices = await flutterTts.getVoices;
              var aa = await flutterTts.getLanguages;
              print(voices);
              flutterTts.setVoice({'name': 'Grandpa', 'locale': 'en-GB'});
              await flutterTts.speak("hello baby");
              // var result = await flutterTts.speak("Hello World");
              // APPPlugin.logger.i(result);
            })
      );
    });
  }
}
