/// Author: kele
/// Date: 2022-05-27 11:35:57
/// LastEditors: kele
/// LastEditTime: 2023-04-09 16:52:46
/// Description:

/// Author: kele
/// Date: 2022-01-13 15:22:32
/// LastEditors: kele
/// LastEditTime: 2023-04-09 16:52:51
/// Description:

import 'package:flutter_soulmateelf/config.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewLogic extends GetxController {
  /// 加载页面title和url
  String title = '';
  String url = '';
  WebViewController? controller;
  @override
  void onInit() {
    // TODO: implement onReady
    super.onInit();
    controller = WebViewController.fromPlatformCreationParams(
        const PlatformWebViewControllerCreationParams());

    /// 处理参数
    title = Get.arguments['title'];
    url = Get.arguments['url'];
    controller
      ?..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }
}
