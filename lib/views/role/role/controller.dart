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
import 'package:soulmate/models/role.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  String roleId = "";

  /// 角色id
  Role? roleDetail;

  /// 角色详情信息

  @override
  void onReady() {
    super.onReady();
    roleId = Get.arguments?["roleId"];
    getRoleDetail();
    return;
  }

  /// 获取角色详情
  void getRoleDetail() {
    if (roleId == null) return;
    HttpUtils.diorequst('/role/roleInfo', query: {"roleId": roleId})
        .then((response) {
      print(response);
      var roleDetailMap = response["data"];
      roleDetail = Role.fromJson(roleDetailMap);
      update();
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }
}
