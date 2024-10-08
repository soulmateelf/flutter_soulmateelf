import 'package:get/get.dart';
import 'package:soulmate/views/base/PrivacyPolicy/view.dart';
import 'package:soulmate/views/base/TermsofService/view.dart';
import 'package:soulmate/views/base/authCode/view.dart';
import 'package:soulmate/views/base/findAccount/view.dart';
import 'package:soulmate/views/base/login/view.dart';
import 'package:soulmate/views/base/menu/view.dart';
import 'package:soulmate/views/base/password/view.dart';
import 'package:soulmate/views/base/signUp/view.dart';

/// base
import 'package:soulmate/views/base/splash/view.dart';
import 'package:soulmate/views/base/successfully/view.dart';
import 'package:soulmate/views/base/webview/view.dart';
import 'package:soulmate/views/base/welcome/view.dart';
import 'package:soulmate/views/chat/background/view.dart';
import 'package:soulmate/views/chat/chat/view.dart';

/// chat
import 'package:soulmate/views/chat/chatList/view.dart';
import 'package:soulmate/views/chat/details/view.dart';
import 'package:soulmate/views/chat/message/view.dart';
import 'package:soulmate/views/chat/settings/view.dart';
import 'package:soulmate/views/customRole/step1/view.dart';
import 'package:soulmate/views/customRole/step2/view.dart';
import 'package:soulmate/views/intro/recommend/view.dart';
import 'package:soulmate/views/intro/welcome/view.dart';
import 'package:soulmate/views/mine/about/view.dart';
import 'package:soulmate/views/mine/account/view.dart';
import 'package:soulmate/views/mine/confirmDeactivate/view.dart';
import 'package:soulmate/views/mine/contactEmail/view.dart';
import 'package:soulmate/views/mine/deactivate/view.dart';
import 'package:soulmate/views/mine/downloadData/view.dart';
import 'package:soulmate/views/mine/energy/view.dart';
import 'package:soulmate/views/mine/feedback/view.dart';

/// mine
import 'package:soulmate/views/mine/mine/view.dart';
import 'package:soulmate/views/mine/nickName/view.dart';
import 'package:soulmate/views/mine/purchaseHistory/view.dart';
import 'package:soulmate/views/mine/updatePassword/view.dart';
import 'package:soulmate/views/role/role/view.dart';
import 'package:soulmate/views/role/roleEvent/view.dart';
import 'package:soulmate/views/mine/giftBackpack/view.dart';
import 'package:soulmate/views/mine/RenewalAgreement/view.dart';
import 'package:soulmate/views/mine/ServiceAgreement/view.dart';

/// role
import 'package:soulmate/views/role/roleList/view.dart';

/// testPage
import 'package:soulmate/views/test/testPage/view.dart';

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
    GetPage(name: '/signUp', page: () => SignUpPage()),

    /// 验证码
    GetPage(name: '/authCode', page: () => AuthCodePage()),

    /// 设置密码
    GetPage(name: '/password', page: () => PasswordPage()),

    /// 忘记密码-找回账户
    GetPage(name: '/findAccount', page: () => FindAccountPage()),

    /// 修改密码成功
    GetPage(name: '/successfully', page: () => SuccessfullyPage()),

    /// 隐私策略
    GetPage(name: "/privacyPolicy", page: () => PrivacyPolicyPage()),

    /// 服务条款
    GetPage(name: "/termsOfService", page: () => TermsOfServicePage()),

    /// chat模块
    /// 聊天列表
    GetPage(name: '/chatList', page: () => ChatListPage()),

    /// message
    GetPage(name: '/message', page: () => MessagePage()),

    /// chat
    GetPage(name: '/chat', page: () => ChatPage()),

    /// 聊天设置
    GetPage(name: '/chatSettings', page: () => ChatSettingsPage()),

    /// 聊天详情页
    GetPage(name: '/chatDetails', page: () => ChatDetailsPage()),

    /// 聊天背景
    GetPage(name: '/chatBackground', page: () => ChatBackgroundPage()),

    /// role模块
    /// 角色列表
    GetPage(name: '/roleList', page: () => RoleListPage()),

    /// 角色详情-朋友圈
    GetPage(name: '/role', page: () => RolePage()),

    /// 角色详情-朋友圈记录详情
    GetPage(name: '/roleEvent', page: () => RoleEventPage()),

    /// mine模块
    /// 我的
    GetPage(name: '/mine', page: () => MinePage()),

    /// 充值
    GetPage(name: "/energy", page: () => EnergyPage()),

    /// 充值卡
    GetPage(name: "/giftBackpack", page: () => GiftBackpackPage()),

    /// 反馈
    GetPage(name: '/feedback', page: () => FeedbackPage()),

    /// 我的账户
    GetPage(name: '/mineAccount', page: () => MineAccountPage()),

    /// 我的昵称
    GetPage(name: '/mineNickname', page: () => MineNickNamePage()),

    /// 修改密码
    GetPage(name: '/mineUpdatePassword', page: () => MineUpdatePasswordPage()),

    /// 注销账户
    GetPage(name: '/mineDeactivate', page: () => MineDeactivatePage()),

    /// 确认注销
    GetPage(
        name: '/mineConfirmDeactivate',
        page: () => MineConfirmDeactivatePage()),

    /// 下载数据
    GetPage(name: '/mineDownloadData', page: () => MineDownloadDataPage()),

    /// 联系邮箱
    GetPage(name: '/mineContactEmail', page: () => MineContactEmailPage()),

    /// 充值历史
    GetPage(
        name: '/minePurchaseHistory', page: () => MinePurchaseHistoryPage()),

    /// 关于
    GetPage(name: '/about', page: () => AboutPage()),

    /// 自定义角色
    GetPage(name: "/customRoleStep1", page: () => Step1Page()),
    GetPage(name: "/customRoleStep2", page: () => Step2Page()),

    /// 角色引导
    GetPage(name: "/introWelcome", page: () => IntroWelcomePage()),
    GetPage(name: "/introRecommend", page: () => IntroRecommendPage()),
    /// 订阅协议
    GetPage(name: "/serviceAgreementPage", page: () => ServiceAgreementPage()),
    GetPage(name: "/renewalAgreementPage", page: () => RenewalAgreementPage()),

    GetPage(name: '/testPage', page: () => TestPage()),
  ];
}
