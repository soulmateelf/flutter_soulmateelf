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
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(TextToSpeechLogic());
    List<Object?> voices;
    return GetBuilder<TextToSpeechLogic>(builder: (logic) {
      return basePage('测试功能页面', child:
          Column(
            children: [
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
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                      child: const Text('systemShare'),
                      onPressed: () {
                        logic.systemShare(context);
                      });
                },
              ),

            ],
          )
      );
    });
  }
}
