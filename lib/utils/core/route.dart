import 'package:get/get.dart';
/// base
import 'package:flutter_soulmateelf/views/base/splash/view.dart';
import 'package:flutter_soulmateelf/views/base/login/view.dart';
import 'package:flutter_soulmateelf/views/base/webview/view.dart';
/// main
import 'package:flutter_soulmateelf/views/main/home/view.dart';
import 'package:flutter_soulmateelf/views/main/chat/view.dart';


class AppRoute {
  static final List<GetPage> getPages = [
    /// base
    GetPage(name: '/splash',page: () => SplashPage()),/// 启动页
    GetPage(name: '/login',page: () => LoginPage()),/// 登录
    GetPage(name: '/webview',page: () => WebviewPage()),/// 登录
    /// main
    GetPage(name: '/home', page: () => HomePage()),/// 首页
    GetPage(name: '/chat', page: () => ChatPage()),/// 聊天
  ];
}