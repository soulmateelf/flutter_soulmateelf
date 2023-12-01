/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:soulmate/config.dart';
import 'package:soulmate/models/activety.dart';
import 'package:soulmate/models/role.dart';
import 'package:soulmate/models/roleEvent.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  /// 角色id
  String roleId = "";

  /// 角色详情信息
  Role? roleDetail;

  User? user;

  /// 角色朋友圈列表
  late List<RoleEvent> roleEventList = [];

  @override
  void onReady() {
    super.onReady();
    roleId = Get.arguments?["roleId"];
    getRoleDetail();
    getRoleRecordList();
    user = Application.userInfo;
  }

  /// 获取角色详情
  void getRoleDetail() {
    HttpUtils.diorequst('/role/roleInfo', query: {"roleId": roleId})
        .then((response) {
      var roleDetailMap = response["data"];
      roleDetail = Role.fromJson(roleDetailMap);
      update();
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  /// 获取朋友圈列表
  void getRoleRecordList() {
    HttpUtils.diorequst('/role/roleEventList', query: {"roleId": roleId})
        .then((res) {
      final List<dynamic> data = res?['data'] ?? [];
      APPPlugin.logger.d("list");
      if (data != null) {
        final list = data?.map((e) => RoleEvent.fromJson(e))?.toList() ?? [];
        roleEventList = list;
        update();
      }
    }).catchError((err) {
      APPPlugin.logger.e(err.toString());
    });
  }

  Future<bool> sendLike(RoleEvent roleEvent) async {
    try {
      if (roleDetail != null) {
        final activity = roleEvent.activities.firstWhereOrNull(
          (element) =>
              element.type == 0 &&
              element.userId == Application.userInfo?.userId,
        );
        final res = await HttpUtils.diorequst("/role/sendLike",
            method: "post",
            params: {
              "roleId": roleDetail!.roleId!,
              "memoryId": roleEvent.memoryId,
              "activityId": activity != null ? activity.activityId : "",
              "isAdd": activity == null,
            });
        APPPlugin.logger.d(activity);
        if (res?['code'] == 200) {
          APPPlugin.logger.d('like');
          getRoleRecordList();
          return activity == null;
        }
      }
    } catch (err) {
      exSnackBar(err.toString(), type: ExSnackBarType.error);
    }
    return false;
  }

  void toEventDetail(RoleEvent roleEvent) {
    Get.toNamed('/roleEvent', arguments: {
      "memoryId": roleEvent.memoryId,
    });
  }
}
