/*
 * @Date: 2023-04-20 10:33:15
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-20 14:22:30
 * @FilePath: \soulmate\lib\views\main\recharge\logic.dart
 */

import 'package:get/get.dart';

import '../../../utils/core/httputil.dart';
import '../../../utils/plugin/plugin.dart';

class RechargetLogic extends GetxController {
  /// 角色列表
  var _roleList = [];

  get roleList {
    return _roleList;
  }

  set roleList(dynamic roleList) {
    _roleList = roleList;
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
    return _roleList?.firstWhere((role) => role["id"] == _checkedRoleId);
  }

  /// 获取角色列表
  getRoleList() {
    NetUtils.diorequst("/role/getRoleList", 'get').then((result) {
      if (result.data?["code"] == 200) {
        APPPlugin.logger.d(result.data["data"]["data"]);
        final data = result.data["data"]["data"];
        roleList = data;

        checkedRoleId = Get.arguments["checkedRoleId"] ??
            (data.length > 0 ? (data[0]?["id"]) : 1);
      }
    });
  }

  // 获取商品列表
  getProductList() {
    NetUtils.diorequst("/product/list", 'get').then((result) {
      if (result.data?["code"] == 200) {
        APPPlugin.logger.d(result.data);
      }
    });
  }

  /// 优惠券列表
  var _couponList = [];

  List<dynamic> get couponList {
    return _couponList;
  }

  set couponList(List<dynamic> value) {
    _couponList = value;
  }

  @override
  void onInit() {
    super.onInit();
    return;
  }

  @override
  void onReady() {
    super.onReady();
    getRoleList();
    getProductList();
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }
}
