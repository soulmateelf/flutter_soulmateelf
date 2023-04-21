////////////////////////
///Author: guohl
///Date: 2022-02-08 09:30:30
///LastEditors: guohl
///LastEditTime: 2022-02-09 15:40:33
///Description:
////////////////////////
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TextToSpeechPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(TextToSpeechLogic());
    List<Object?> voices;
    return GetBuilder<TextToSpeechLogic>(builder: (logic) {
      return basePage('测试功能页面', child:
          Column(
            children: [
              Row(
                children: [
                  // Text('当前voice：${logic.currentVoice.toString()}'),
                  Text('当前voice：${logic.currentVoice?.toString()}}'),
                  ElevatedButton(
                      child: const Text('选择声音'),
                      onPressed: () {
                        logic.choiceVoice();
                      }),
                ],
              ),
              ElevatedButton(
                  child: const Text('speech'),
                  onPressed: () {
                    logic.speech();
                  }),
              ElevatedButton(
                  child: const Text('googleLogin'),
                  onPressed: () {
                    logic.googleLogin();
                  }),
              ElevatedButton(
                  child: const Text('faceBookLogin'),
                  onPressed: () {
                    logic.faceBookLogin();
                  }),
              ElevatedButton(
                  child: const Text('systemShare'),
                  onPressed: () {
                    logic.systemShare(context);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: const Text(
                      'Recognized words:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text(logic.lastWords),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
              onPressed: logic.speechToText.isNotListening ? logic.startListening : logic.stopListening,
              child: Icon(logic.speechToText.isNotListening ? Icons.mic_off : Icons.mic)
              ),
              GestureDetector(
                onLongPressStart: (LongPressStartDetails details) {
                  print('长按开始');
                  logic.recordPlugin.start();
                },
                onLongPressEnd: (LongPressEndDetails details) {
                  print('长按结束');
                  logic.recordPlugin.stop();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.amber,
                  child: Row(children: [const Icon(Icons.mic),Text(logic.recordTime.toInt().toString())],),
                ),
              ),
              ElevatedButton(
                  onPressed: (){logic.playAudio();},
                  child: const Icon(Icons.play_arrow)
              ),
              ElevatedButton(
                  onPressed: (){Get.toNamed('/testPay');},
                  child: const Icon(Icons.shopping_cart)
              ),
            ],
          )
      );
    });
  }
}
