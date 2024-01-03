/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */

import 'package:soulmate/models/role.dart';
import 'package:soulmate/models/roleEvent.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/role/roleList/controller.dart';
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

  final Map<String, List<String>> sendLikeMap = {};

  RoleListController roleListController = Get.find<RoleListController>();

  @override
  void onReady() {
    super.onReady();
    roleId = Get.arguments?["roleId"];
    roleDetail = Get.arguments?['roleData'];
    // getRoleDetail();
    getRoleRecordList();
    roleListController.getDataList();
    user = Application.userInfo;

    update();
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
    sendLikeMap.clear();
    HttpUtils.diorequst('/role/roleEventList', query: {"roleId": roleId})
        .then((res) {
      final List<dynamic> data = res?['data'] ?? [];
      if (data != null) {
        final list = data?.map((e) => RoleEvent.fromJson(e))?.toList() ?? [];
        roleEventList = list;
        roleEventList.forEach((element) {
          List<String> likes = [];
          element.activities.forEach((element) {
            if (element.type == 0) {
              likes.add(element.userId);
            }
          });
          sendLikeMap.addAll({element.memoryId: likes});
        });
        update();
      }
    }).catchError((err) {
      APPPlugin.logger.e(err.toString());
    });
  }

  Debouncer debouncer = Debouncer(delay: Duration(milliseconds: 500));

  void debounceSendLike(RoleEvent roleEvent) {
    sendLikeMap.update(roleEvent.memoryId, (value) {
      final index = value.indexOf(user!.userId);
      if (index == -1) {
        value.add(user!.userId);
      } else {
        value.removeAt(index);
      }
      return value;
    });
    update();
    debouncer.debounce((arguments) {
      sendLike(roleEvent);
    });
  }

  /// 点赞
  void sendLike(RoleEvent roleEvent) async {
    try {
      if (roleDetail != null) {
        final activity = sendLikeMap?[roleEvent.memoryId]?.indexOf(user!.userId) != -1;
        HttpUtils.diorequst("/role/sendLike", method: "post", params: {
          "roleId": roleDetail!.roleId!,
          "memoryId": roleEvent.memoryId,
          "activityId": activity??'',
          "isAdd": activity,
        });
      }
    } catch (err) {
      exSnackBar(err.toString(), type: ExSnackBarType.error);
    }
  }

  /// 更新某一条事件
  void updateOneEvent(RoleEvent event) {
    roleEventList = roleEventList.map((e) {
      if (e.memoryId == event.memoryId) {
        return event;
      }
      return e;
    }).toList();
    update();
  }

  void toEventDetail(RoleEvent roleEvent) {
    Get.toNamed('/roleEvent', arguments: {
      "memoryId": roleEvent.memoryId,
    });
  }

  void toChat() {
    Get.toNamed('/chat', arguments: {"roleId": roleDetail?.roleId});
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    debouncer.dispose();
  }
}
