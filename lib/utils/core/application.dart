/// Author: kele
/// Date: 2023-04-23 15:41:48
/// LastEditors: kele
/// LastEditTime: 2023-04-25 11:13:49
/// Description: 全局变量

import 'dart:convert';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

class Application {
  /// 全局存储
  static SharedPreferences? pres;

  /// 用户信息
  static User? _userInfo; //用户信息

  /// token
  static String? _token;

  static initGlobe() async {
    /// 全局变量的初始化
    /// 存储
    Application.pres = await SharedPreferences.getInstance();

    ///初始化个人信息
    String? userInfo = Application.pres?.getString("userInfo");
    if (userInfo != null) {
      _userInfo = User.fromJson(jsonDecode(userInfo));
    }

    ///初始化token
    String? token = Application.pres?.getString("token");
    _token = token;
  }

  static User? get userInfo {
    return _userInfo != null ? _userInfo : null;
  }

  static void set userInfo(User? info) {
    if (info != null) {
      _userInfo = info;
      Application.pres?.setString("userInfo", jsonEncode(info.toJson()));
    } else {
      _userInfo = null;
      Application.pres?.remove("userInfo");
    }
  }

  static String? get token {
    return _token;
  }

  static void set token(String? value) {
    _token = value;
    if (value != null) {
      pres?.setString("token", value);
    } else {
      pres?.remove("token");
    }
  }

  static Future clearStorage() async {
    /// 由于全局主题色的原因，不能直接全部清空存储，需要保留当前主题
    Application.pres?.clear();
    Application.token = null;
    Application.userInfo = null;

    /// 保留：主题
    // Application.pres?.setInt('themeIndex', Application.themeIndex);
  }
}
