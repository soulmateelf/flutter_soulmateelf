/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:23:04
 * @FilePath: \soulmate\lib\views\main\home\logic.dart
 */
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  /// 角色列表
  var _roleList = [];

  get roleList {
    return _roleList;
  }

  set roleList(dynamic roleList) {
    _roleList = roleList;
    update();
  }

  /// 选中的角色id
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
    return (_roleList ?? []).firstWhere(
      (role) => role["id"] == _checkedRoleId,
      orElse: () => null,
    );
  }

  /// 获取角色列表
  getRoleList() async {
    final result = await NetUtils.diorequst("/role/getRoleList", 'get');

    if (result?.data?["code"] == 200) {
      // APPPlugin.logger.d(result.data["data"]["data"]);
      roleList = result.data["data"]["data"];
      if (roleList.length > 0) {
        checkedRoleId = roleList[0]?["id"];
      }
    }
  }

  // 分享成功，修改角色名称状态
  shareCallBack() async {
    final result = await NetUtils.diorequst("/role/updateShare", 'post',
        params: {
          "roleId": checkedRoleId,
        }
    );
    if (result?.data?["code"] == 200) {
      getRoleList();
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

  // 上次点击返回键时间
  int lastClickTime = 0;
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
}
