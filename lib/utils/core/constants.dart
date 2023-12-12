import 'dart:ui';
import 'package:flutter/src/painting/border_radius.dart';
import 'package:flutter/src/painting/borders.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const primaryColor = Color.fromRGBO(255, 128, 0, 1);
var borderRadius = 16.w;
const borderColor = Color.fromRGBO(245, 245, 245, 1);
var borderWidth = 3.w;

const textColor = Color.fromRGBO(0, 0, 0, 0.8);

const disableColor = Color.fromRGBO(245, 245, 245, 1);

const errorTextColor = Color.fromRGBO(255, 90, 90, 1);
const errorBorderColor = Color.fromRGBO(255, 214, 214, 1);
const errorBackgroundColor = Color.fromRGBO(255, 245, 245, 1);

/// 发送邮箱验证码的当前状态枚举
class VerifyState {
  static const login = 1;
  static const signUp = 2;
  static const forgot = 3;
  static const deactivate = 4;
}

/// 字体库枚举类
class FontFamily {
  static const SFProRounded = "SFProRounded";
  static const SFProRoundedBlod = "SFProRounded-Blod";
  static const SFProRoundedMedium = "SFProRounded-Medium";
  static const SFProRoundedSemibold = "SFProRounded-Semibold";
  static const SFProRoundedLight = "SFProRounded-Light";
  static const PingFangRegular = "PingFangRegular";
}
