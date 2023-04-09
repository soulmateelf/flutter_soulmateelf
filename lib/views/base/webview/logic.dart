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

    /// 判断参数
    int type = Get.arguments;
    if (type == 0) {
      title = '用户协议';
      url = ProjectConfig.getInstance()?.baseConfig['userAgreementUrl'] +
          '?random=' +
          DateTime.now().microsecond.toString();
    } else {
      title = '隐私条款';
      url = ProjectConfig.getInstance()?.baseConfig['privacyClauseUrl'] +
          '?random=' +
          DateTime.now().microsecond.toString();
    }
    controller
      ?..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }
}
