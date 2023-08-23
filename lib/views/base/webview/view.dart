/// Author: kele
/// Date: 2022-01-13 15:22:32
/// LastEditors: kele
/// LastEditTime: 2022-03-08 10:57:02
/// Description: 用户协议和隐私条款

import 'package:flutter/material.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'logic.dart';

class WebviewPage extends StatelessWidget {
  final logic = Get.put(WebviewLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebviewLogic>(builder: (logic) {
      return basePage(
        logic.title,
        child: WebViewWidget(controller: logic.controller!),
      );
    });
  }
}
