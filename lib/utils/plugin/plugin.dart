/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-26 14:07:00
 * @FilePath: \soulmate\lib\utils\plugin\plugin.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/plugin/Message.dart';
import 'package:soulmate/utils/plugin/mqtt.dart';

import 'AppPurchase.dart';

class APPPlugin {
  /// 日志
  static late Logger logger;

  /// 软件信息
  static PackageInfo? appInfo;

  static XMqttClient? mqttClient;

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

    /// 连接 mqtt服务
    mqttClient = XMqttClient.instance;
    mqttClient?.connect("mqtt_cid");
    mqttClient?.topicSubscribe(["12345"]);
    /// 初始化内购
    AppPurchase.initAppPayConfig();

    /// 初始化广告插件
    // MobileAds.instance.initialize();

    /// 初始化消息推送
    GoogleMessage.initMessage();
  }
}
