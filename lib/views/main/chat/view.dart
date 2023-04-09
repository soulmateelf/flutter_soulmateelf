////////////////////////
///Author: guohl
///Date: 2022-02-08 09:30:30
///LastEditors: guohl
///LastEditTime: 2022-02-09 15:40:33
///Description:
////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ChatLogic());
    return GetBuilder<ChatLogic>(builder: (logic) {
      return basePage('首页', child: const Text('home'));
    });
  }
}
