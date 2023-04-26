/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\logic.dart
 */
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  /// 角色列表
  var _roleList = [];

  List<dynamic> get roleList {
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
  getRoleList() {
    NetUtils.diorequst("/role/getRoleList", 'get').then((result) {
      if (result?.data?["code"] == 200) {
        roleList = result?.data?["data"]?["data"] ?? [];
        if (roleList.length > 0) {
           final  hasCheckedRole =   roleList.any((element) => element["id"] == checkedRoleId);
           if(!hasCheckedRole){
             checkedRoleId = roleList?[0]?["id"];
           }
        }
      }
    });
  }
  /// 修改角色名称
  updateRoleName(BuildContext context) async{
    if (checkedRole?["share"] != 1) return;
    final result = await showTextInputDialog(
        context: context,
        title: "name",
        message: "Changing role names",
        textFields: [
          DialogTextField(
              validator:
                  (value) {
                if (value == null || value.length <= 0) {
                  return "The name cannot be empty";
                }
              },
              initialText: checkedRole?["roleName"] ?? "Soulmate ELF")
        ]);
    if (result == null) return;
    final newName = result[0];
    Loading.show();
    NetUtils.diorequst(
        "/role/updateRole",
        'post',
        params: {
          "roleId": checkedRoleId,
          "roleName": newName
        }).then((value) {
      getRoleList();
    }).whenComplete(() {
      Loading.dismiss();
      Loading.success("success");
    });
  }
  // 分享成功，修改角色名称状态
  shareCallBack() {
    NetUtils.diorequst("/role/updateShare", 'post', params: {
      "roleId": checkedRoleId,
    }).then((result) {
      if (result?.data?["code"] == 200) {
        getRoleList();
      }
    }).whenComplete(() {});
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
      Loading.toast('再按一次退出应用');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
