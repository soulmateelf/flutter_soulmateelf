import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';

import 'IOSAppPurchase.dart';

class APPPlugin {
  /// 日志
  static late Logger logger;
  /// 软件信息
  static PackageInfo? appInfo;

  static initPlugin() async {
    /// 插件初始化
    /// logger
    APPPlugin.logger = Logger(printer: PrettyPrinter());

    /// 遮罩加载框
    EasyLoading.instance
        ..animationStyle = EasyLoadingAnimationStyle.opacity
        ..maskType = EasyLoadingMaskType.black
        ..displayDuration = const Duration(milliseconds: 2000)
        ..loadingStyle = EasyLoadingStyle.dark
        ..indicatorType = EasyLoadingIndicatorType.ring;

    ///初始化版本信息
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      APPPlugin.appInfo = packageInfo;
    });

    /// 初始化ios内购
    IOSAppPurchase.initApplePayConfig();

  }
}
