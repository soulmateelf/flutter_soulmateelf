
import 'package:get/get.dart';

/// base
import 'package:soulmate/views/base/splash/view.dart';
import 'package:soulmate/views/base/welcome/view.dart';
import 'package:soulmate/views/base/login/view.dart';
import 'package:soulmate/views/base/webview/view.dart';
import 'package:soulmate/views/base/menu/view.dart';

/// chat
import 'package:soulmate/views/chat/chatList/view.dart';

/// role
import 'package:soulmate/views/role/roleList/view.dart';

/// mine
import 'package:soulmate/views/mine/mine/view.dart';

class AppRoute {
  static final List<GetPage> getPages = [
    /// base模块
    /// 启动页
    GetPage(name: '/splash', page: () => SplashPage()),
    /// welcome
    GetPage(name: '/welcome', page: () => WelcomePage()),
    /// 登录
    GetPage(name: '/login', page: () => LoginPage()),
    /// 加载远程页面
    GetPage(name: '/webView', page: () => WebviewPage()),
    /// 菜单
    GetPage(name: '/menu', page: () => MenuPage()),

    /// chat模块
    /// 消息列表
    GetPage(name: '/chatList', page: () => ChatListPage()),

    /// role模块
    /// 角色列表
    GetPage(name: '/roleList', page: () => RoleListPage()),

    /// mine模块
    /// 我的
    GetPage(name: '/mine', page: () => MinePage()),

  ];
}
