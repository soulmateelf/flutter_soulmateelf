/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-16 13:36:28
 * @FilePath: \soulmate\lib\utils\core\route.dart
 */
import 'package:flutter_soulmateelf/views/base/continue/view.dart';
import 'package:flutter_soulmateelf/views/base/forgetPassword/view.dart';
import 'package:flutter_soulmateelf/views/base/setPassword/view.dart';
import 'package:flutter_soulmateelf/views/base/verification/view.dart';
import 'package:flutter_soulmateelf/views/base/welcome/view.dart';
import 'package:flutter_soulmateelf/views/base/signup/view.dart';
import 'package:flutter_soulmateelf/views/main/account/view.dart';
import 'package:flutter_soulmateelf/views/main/confirmDeactivate/view.dart';
import 'package:flutter_soulmateelf/views/main/deactivate/view.dart';
import 'package:flutter_soulmateelf/views/main/discount/view.dart';
import 'package:flutter_soulmateelf/views/main/privacyPolicy/view.dart';
import 'package:flutter_soulmateelf/views/main/purchaseHistory/view.dart';
import 'package:flutter_soulmateelf/views/main/recharge/view.dart';
import 'package:flutter_soulmateelf/views/main/sendFeedback/view.dart';
import 'package:flutter_soulmateelf/views/main/settings/view.dart';
import 'package:flutter_soulmateelf/views/main/termsOfService/view.dart';
import 'package:flutter_soulmateelf/views/main/updateNickname/view.dart';
import 'package:flutter_soulmateelf/views/main/updatePassword/view.dart';
import 'package:flutter_soulmateelf/views/test/testpay/view.dart';
import 'package:get/get.dart';
/// base
import 'package:flutter_soulmateelf/views/base/splash/view.dart';
import 'package:flutter_soulmateelf/views/base/login/view.dart';
import 'package:flutter_soulmateelf/views/base/webview/view.dart';
/// main
import 'package:flutter_soulmateelf/views/main/home/view.dart';
import 'package:flutter_soulmateelf/views/main/chat/view.dart';
/// text
import 'package:flutter_soulmateelf/views/test/speech/view.dart';

class AppRoute {
  static final List<GetPage> getPages = [
    /// base
    GetPage(name: '/splash',page: () => SplashPage()),/// 启动页
    GetPage(name: '/welcome', page: ()=> WelcomePage()), // 默认页面
    GetPage(name: '/login',page: () => LoginPage()),/// 登录
    GetPage(name: '/webview',page: () => WebviewPage()),/// webview
    GetPage(name: '/signup', page:()=>SignUpPage()), /// 注册
    GetPage(name: '/verification', page:()=> VerificationPage()),///输入验证码页面
    GetPage(name: '/setPassword', page: ()=>SetPasswordPage()),/// 设置密码界面
    GetPage(name: '/continue', page:()=>ContinuePage()), /// continue Elf
    GetPage(name: '/forgetPassword', page:()=>ForgetPassword()), /// 忘记密码页面
    /// main
    GetPage(name: '/home', page: () => HomePage()),/// 首页
    GetPage(name: '/chat', page: () => ChatPage()),/// 聊天
    GetPage(name: '/settings', page: ()=>SettingsPage()), /// 设置
    GetPage(name: '/account', page:()=>AccountPage()), /// 账户设置
    GetPage(name: '/updatePassword', page:()=>UpdatePasswordPage()),/// 更新密码
    GetPage(name: '/deactivate', page:()=>DeactivatePage()), /// 注销页面
    GetPage(name: '/confirmDeactivate', page: ()=>ConfirmDeactivatePage()), ///确定注销账户
    GetPage(name: '/discount', page: ()=>DiscountPage()),/// 优惠券
    GetPage(name: '/purchaseHistory', page:()=>PurchaseHistoryPage()), /// 购买历史
    GetPage(name: '/sendFeedback', page:()=>SendFeedbackPage()), /// 发送反馈
    GetPage(name: '/updateNickname', page: ()=>UpdateNicknamePage()), /// 修改昵称
    GetPage(name: '/privacyPolicy', page: ()=>PrivacyPolicyPage()), /// 隐私政策
    GetPage(name: '/termsOfService', page: ()=>TermsOfServicePage()), /// 服务条款
    GetPage(name: '/recharge', page:()=>RechargePage()), /// 充值
    /// text
    GetPage(name: '/textToSpeech', page: () => TextToSpeechPage()),/// 语言测试
    GetPage(name: '/testPay', page: () => TestPayPage()),/// 支付测试
  ];
}