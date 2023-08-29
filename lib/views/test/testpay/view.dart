
import 'package:flutter/material.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TestPayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(TestPay());
    List<Object?> voices;
    return GetBuilder<TestPay>(builder: (logic) {
      return basePage('测试支付功能页面',
          child: Column(
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
              ElevatedButton(
                  child: const Text('restorePurchases'),
                  onPressed: () {
                    logic.restorePurchases();
                  }),
            ],
          ));
    });
  }
}
