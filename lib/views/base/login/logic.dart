import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class LoginLogic extends GetxController {
  // 上次点击返回键时间
  int lastClickTime = 0;

  // 账号
  String account = '';
  // 账号焦点
  FocusNode accountFocusNode = FocusNode();

  // 密码
  String password = '';
  // 密码焦点
  FocusNode pwdFocusNode = FocusNode();

  // 已读隐私条款
  bool checkProtocol = false;

  @override
  void onInit() {
    // TODO: implement onReady
    super.onInit();

    account = '111';
    password = '';
  }

  /// Author: kele
  /// Date: 2022-03-08 15:12:36
  /// Params:
  /// Return:
  /// Description: 处理安卓返回键
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:
  Future<bool> dealBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClickTime > 1000) {
      lastClickTime = DateTime.now().millisecondsSinceEpoch;
      EasyLoading.showToast('再按一次退出应用');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  /// Author: kele
  /// Date: 2022-03-08 15:12:50
  /// Params:
  /// Return:
  /// Description: 登录
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:
  void login() {
    if (Utils.isEmpty(account)) {
      exSnackBar('请输入账号', type: 'warning');
      return;
    }
    if (Utils.isEmpty(password)) {
      exSnackBar('请输入密码', type: 'warning');
      return;
    }
    if (!checkProtocol) {
      exSnackBar('请阅读并接受用户协议和隐私条款', type: 'warning');
      return;
    }
    showLoadingMask();
    Map<String, dynamic> headers = {
      "dev": "pm",
    };
    Application.pres?.setString('headers', jsonEncode(headers));

    Map<String, dynamic> params = {
      'account': account,
      'password': password,
    };

    void successFn(data) {
      Map<String, dynamic> headers = {
        "dev": "pm",
        "x-auth-token": data['data']['x-auth-token'],
      };
      Application.pres?.setString('headers', jsonEncode(headers));
      getUserInfo();
    }

    void errorFn(error) {
      EasyLoading.dismiss();
      exSnackBar(error['message'], type: 'error');
    }
    //测试
    EasyLoading.dismiss();
    Application.pres?.setString('headers', jsonEncode({}));
    Application.pres?.setString('userInfo', jsonEncode({}));
    Get.offNamed('/home');
    return;
    NetUtils.diorequst('/iot4-ucenter-api/pm/user/login', 'post',
        params: params,
        successCallBack: successFn,
        errorCallBack: errorFn,
        extra: {'isUrlencoded': true});
  }

  /// Author: kele
  /// Date: 2022-03-08 15:13:07
  /// Params:
  /// Return:
  /// Description: 获取个人信息
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:

  void getUserInfo() {
    void successFn(res) {
      EasyLoading.dismiss();
      Application.userInfo = res["data"];
      Application.pres?.setString('userInfo', jsonEncode(res['data']));
      Get.offNamed('/home');
    }

    void errorFn(error) {
      EasyLoading.dismiss();
      exSnackBar(error['message'], type: 'error');
    }

    NetUtils.diorequst(
      '/iot4-crpm-api/user/info',
      'get',
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }
}
