/// Author: kele
/// Date: 2022-03-07 13:31:49
/// LastEditors: kele
/// LastEditTime: 2022-03-14 15:52:02
/// Description:

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  /// 全局存储
  static SharedPreferences? pres;
  /// 用户信息
  static Map? userInfo; //用户信息

  static initGlobe() async {
    /// 全局变量的初始化
    /// 存储
    Application.pres = await SharedPreferences.getInstance();
    ///初始化个人信息
    String? userInfo = Application.pres?.getString("userInfo");
    if (userInfo != null) {
      Application.userInfo = jsonDecode(userInfo);
    } else {
      Application.userInfo = null;
    }
  }

  static Future clearStorage() async {
    /// 由于全局主题色的原因，不能直接全部清空存储，需要保留当前主题
    Application.pres?.clear();
    /// 保留：主题
    // Application.pres?.setInt('themeIndex', Application.themeIndex);
  }
}
