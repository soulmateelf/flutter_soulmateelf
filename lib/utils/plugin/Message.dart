
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:soulmate/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print(444);
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await GoogleMessage.setupFlutterNotifications();
//   GoogleMessage.showFlutterNotification(message);
//   print('Handling a background message ${message.messageId}');
// }
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
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    /// 启用自动初始化，自动初始化会在应用程序启动时获取令牌并且自动注册到 FCM
    FirebaseMessaging.instance.setAutoInitEnabled(true);
    /// 初始化本地通知配置
    setupFlutterNotifications();
    /// 请求权限
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    /// 获取token
    await FirebaseMessaging.instance.getToken().then((value) { print(11111);print(value);});

    /// 前台状态监听
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print(message.notification?.title);
      GoogleMessage.showFlutterNotification(message);
    });


    /// 后台状态监听
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  static void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    print("onDidReceiveNotificationResponse");
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('notification payload: $payload');
    }

  }
  static Future<void> setupFlutterNotifications() async {
    print(22222);
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('点击打开app');
      print(message.notification?.title);
    });
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    /// Create an Android Notification Channel.

    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('push_logo');
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?..createNotificationChannel(channel)..initialize(initializationSettingsAndroid,onDidReceiveNotificationResponse:onDidReceiveNotificationResponse);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
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
        payload: message.data.toString(),
      );
    }
  }
}
