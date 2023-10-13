
import 'package:get/get.dart';
import 'package:soulmate/views/base/authCode/view.dart';
import 'package:soulmate/views/base/setPassword/view.dart';
import 'package:soulmate/views/base/signUp/view.dart';

/// base
import 'package:soulmate/views/base/splash/view.dart';
import 'package:soulmate/views/base/welcome/view.dart';
import 'package:soulmate/views/base/login/view.dart';
import 'package:soulmate/views/base/webview/view.dart';
import 'package:soulmate/views/base/menu/view.dart';


/// chat
import 'package:soulmate/views/chat/chatList/view.dart';
import 'package:soulmate/views/chat/message/view.dart';
import 'package:soulmate/views/chat/chat/view.dart';

/// role
import 'package:soulmate/views/role/roleList/view.dart';
import 'package:soulmate/views/role/role/view.dart';

/// mine
import 'package:soulmate/views/mine/mine/view.dart';
import 'package:soulmate/views/mine/feedback/view.dart';


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
    /// 注册
    GetPage(name: '/signUp', page: ()=>SignUpPage()),
    /// 验证码
    GetPage(name: '/authCode', page: ()=>AuthCodePage()),
    /// 设置密码
    GetPage(name: '/setPassword', page: ()=>SetPasswordPage()),

    /// chat模块
    /// 聊天列表
    GetPage(name: '/chatList', page: () => ChatListPage()),
    /// message
    GetPage(name: '/message', page: () => MessagePage()),
    /// chat
    GetPage(name: '/chat', page: () => ChatPage()),

    /// role模块
    /// 角色列表
    GetPage(name: '/roleList', page: () => RoleListPage()),
    /// 角色朋友圈
    GetPage(name: '/role', page: () => RolePage()),

    /// mine模块
    /// 我的
    GetPage(name: '/mine', page: () => MinePage()),
    /// 反馈
    GetPage(name: '/feedback', page: () => FeedbackPage()),

  ];
}
