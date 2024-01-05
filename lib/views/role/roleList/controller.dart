/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/role.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/base/menu/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class RoleListController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final menuLogic = Get.find<SoulMateMenuController>();

  /// 原始角色列表
  List<Role> roleList = [];

  @override
  void onReady() {
    super.onReady();
    getDataList();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  /// 获取角色列表数据
  void getDataList() {
    HttpUtils.diorequst('/role/roleList', query: {'page': 1, 'limit': 999})
        .then((response) {
      List roleListMap = response["data"];
      var unreadCount = 0;
      roleList = roleListMap.map((json) {
        final r = Role.fromJson(json);
        if (r.readCount is int && r.readCount! >= 0) {
          unreadCount += r.readCount!;
        }
        return r;
      }).toList();
      menuLogic.updateMessageNum(roleMessageNum: unreadCount);

      refreshController.refreshCompleted();
      update();
    }).catchError((error) {
      refreshController.refreshFailed();
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///点击角色列表项
  void roleItemClick(index) {
    Role roleData = roleList[index];
    Get.toNamed('/role',
        arguments: {"roleId": roleData.roleId, "roleData": roleData});
  }
}
