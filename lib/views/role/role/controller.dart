/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */

import 'package:pull_to_refresh/pull_to_refresh.dart';
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

enum GetRoleEventType { loadMore, refresh }

class RoleController extends GetxController {
  /// 角色id
  String roleId = "";

  /// 角色详情信息
  Role? roleDetail;

  void setRoleDetail(Role? value) {
    roleDetail = value;
    showEventList = value?.intimacy != null && value!.intimacy! >= 20;
    update();
  }

  User? user;

  /// 角色朋友圈列表
  late List<RoleEvent> roleEventList = [];

  final Map<String, List<String>> sendLikeMap = {};

  RoleListController roleListController = Get.find<RoleListController>();

  RefreshController refreshController = RefreshController();

  bool showEventList = false;

  @override
  void onReady() {
    super.onReady();
    roleId = Get.arguments?["roleId"];
    setRoleDetail(Get.arguments?['roleData']);
    // getRoleDetail();
    getRoleRecordList(GetRoleEventType.refresh);
    roleListController.getDataList();
    user = Application.userInfo;

    update();
  }

  /// 获取角色详情
  void getRoleDetail() {
    HttpUtils.diorequst('/role/roleInfo', query: {"roleId": roleId})
        .then((response) {
      var roleDetailMap = response["data"];
      setRoleDetail(Role.fromJson(roleDetailMap));
      update();
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  int page = 1;
  int size = 5;

  /// 获取朋友圈列表
  void getRoleRecordList(GetRoleEventType type) {
    if (type == GetRoleEventType.refresh) {
      sendLikeMap.clear();
      page = 1;
    } else if (type == GetRoleEventType.loadMore) {
      page++;
    }
    HttpUtils.diorequst('/role/roleEventList',
        query: {"roleId": roleId, "page": page, "size": size}).then((res) {
      final List<dynamic> data = res?['data'] ?? [];
      if (data != null) {
        final list = data?.map((e) => RoleEvent.fromJson(e))?.toList() ?? [];
        list.forEach((element) {
          List<String> likes = [];
          element.activities.forEach((element) {
            if (element.type == 0) {
              likes.add(element.userId);
            }
          });
          sendLikeMap.addAll({element.memoryId: likes});
        });
        if (type == GetRoleEventType.refresh) {
          roleEventList = list;
          refreshController.refreshCompleted();
        } else if (type == GetRoleEventType.loadMore) {
          roleEventList.addAll(list);
          refreshController.loadComplete();
        }
        update();
      }
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
      if (type == GetRoleEventType.refresh) {
        refreshController.refreshFailed();
      } else if (type == GetRoleEventType.loadMore) {
        refreshController.loadFailed();
        page--;
      }
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
        final activity =
            sendLikeMap?[roleEvent.memoryId]?.indexOf(user!.userId) != -1;
        HttpUtils.diorequst("/role/sendLike", method: "post", params: {
          "roleId": roleDetail!.roleId!,
          "memoryId": roleEvent.memoryId,
          "activityId": activity ?? '',
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
