/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:soulmate/config.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {

  Map<dynamic,dynamic> roleDetail = {};/// 角色详情信息

  @override
  void onInit() {
    super.onReady();
    getRoleDetail();
    return;
  }

  /// 获取角色详情
  void getRoleDetail() {
    Map<String, dynamic> params = {
      'email': "keykong167@163.com",
      'password': "123456",
    };
    HttpUtils.diorequst('/login', method: 'post', params: params).then((response){
      print(response);
    }).catchError((error){
      Loading.error(error);
    });
    return;
    Future.delayed(const Duration(milliseconds: 500), () {
      roleDetail = {
        "id":"333",
        "avatar": "http://kele.bestkele.cn/beaut.jpg",
        "roleName": "Johanna Gonzalez",
        "age":26,
        "hobby": "Baking, Reading, Writing, Dancing, Knitting",
        "describe": "I am delighted to lend an ear to your narrative, willing to partake in both your elation and distress, and remain by your side as your steadfast companion, available at your beck and call.",
        "intimacy": 55
      };
      update();
    });
  }

}
