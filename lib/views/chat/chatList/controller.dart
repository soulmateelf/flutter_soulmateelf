/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/role.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/views/base/menu/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<Role> dataList = [];
  final menuLogic = Get.find<SoulMateMenuController>();
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

  /// 获取聊天列表数据
  void getDataList() {
    HttpUtils.diorequst('/role/roleListByUser', query: {"limit": 999})
        .then((response) {
      List roleListMap = response["data"];
      dataList = roleListMap.map((json) => Role.fromJson(json)).toList();
      refreshController.refreshCompleted();
      // menuLogic.updateMessageNum(chatMessageNum: 8);
      update();
    }).catchError((error) {
      refreshController.refreshCompleted();
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///点击聊天列表项
  void chatItemClick(index) {
    Role itemData = dataList[index];
    Get.toNamed("/chat",arguments: {"roleId":itemData.roleId});
  }

  void deleteChatItem(index) {
    dataList.removeAt(index);
    update();
  }
}
