/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-26 14:07:00
 * @FilePath: \soulmate\lib\utils\plugin\plugin.dart
 */
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
    if (GetPlatform.isIOS) {
      IOSAppPurchase.initApplePayConfig();
    }
  }
}
