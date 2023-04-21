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

class TestPayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(TestPay());
    List<Object?> voices;
    return GetBuilder<TestPay>(builder: (logic) {
      return basePage('测试支付功能页面', child:
          Column(
            children: [
              ElevatedButton(
                  child: const Text('展示商品列表'),
                  onPressed: () {
                    logic.showProducts();
                  }),
              ElevatedButton(
                  child: const Text('pay'),
                  onPressed: () {
                    logic.payNow();
                  }),
            ],
          )
      );
    });
  }
}
