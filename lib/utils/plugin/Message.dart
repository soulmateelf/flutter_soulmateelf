import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:soulmate/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

import '../tool/utils.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleMessage.setupFlutterNotifications();
  // GoogleMessage.showFlutterNotification(message);
  // print('Handling a background message ${message.messageId}');
  // 不需要手动显示通知，因为系统会自动弹出默认的通知，如果你需要处理通知或者Data格式的消息，可以在这里写逻辑

}

class GoogleMessage {
  /// android 通知渠道 展示推送
  static late AndroidNotificationChannel channel;

  /// 本地通知
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  /// 初始化本地通知
  static bool isFlutterLocalNotificationsInitialized = false;

  /// 初始化
  static initMessage() async {
    /// 初始化FirebaseApp
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    /// 启用自动初始化，自动初始化会在应用程序启动时获取令牌并且自动注册到 FCM
    FirebaseMessaging.instance.setAutoInitEnabled(true);

    /// 初始化本地通知配置
    await setupFlutterNotifications();

    /// 请求权限
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    /// 获取token
    await FirebaseMessaging.instance.getToken().then((value) {
      Application.pushId = value;
      APPPlugin.logger.d(value);
    }).catchError((err) {
      APPPlugin.logger.d(err);
    });

    /// 前台状态监听
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print(message.notification?.title);
      GoogleMessage.showFlutterNotification(message);
    });

    /// 后台状态监听
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      final payload = notificationResponse.payload!;
      final data = jsonDecode(payload);
      if (data?['subType'] != null) {
        messageToPageBySubtype(int.parse(data['subType']));
      }
    }
  }

  static Future<void> setupFlutterNotifications() async {
    APPPlugin.logger.e("setupFlutterNotifications22");
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final subType = message.data?['subType'];
      if (subType != null) {
        messageToPageBySubtype(int.parse((subType as String)));
      }
    });
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.max,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.

    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('push_logo');
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
      ?..createNotificationChannel(channel)
      ..initialize(initializationSettingsAndroid,
          onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  static void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    if (notification != null && GetPlatform.isAndroid) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'push_logo',
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }
}
