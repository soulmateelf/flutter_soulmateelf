/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-19 17:07:19
 * @FilePath: \soulmate\lib\views\main\home\logic.dart
 */
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  var _roleList = [];

  get roleList {
    return _roleList;
  }

  set roleList(dynamic roleList) {
    _roleList = roleList;
    update();
  }

  var _checkedRoleId = 1;

  get checkedRoleId {
    return _checkedRoleId;
  }

  set checkedRoleId(dynamic id) {
    _checkedRoleId = id;
    update();
  }

  get checkedRole {
    if (_roleList.length == 0) {
      return null;
    }
    return _roleList?.firstWhere((role) => role["id"] == _checkedRoleId);
  }

  getRoleList() async {
    final result = await NetUtils.diorequst("/role/getRoleList", 'get');

    if (result.data?["code"] == 200) {
      APPPlugin.logger.d(result.data["data"]["data"]);
      roleList = result.data["data"]["data"];
    }
  }

  @override
  void onInit() {
    getRoleList();
    super.onInit();
    return;
  }

  @override
  void onReady() {
    super.onReady();
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }
}
