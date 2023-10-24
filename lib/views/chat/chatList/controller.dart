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
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List dataList = [];

  @override
  void onReady() {
    super.onReady();
    getDataList();
    return;
  }

  /// 获取聊天列表数据
  void getDataList() {
    HttpUtils.diorequst('/chat/chatList', query: {"limit": 999})
        .then((response) {
      print(response);
      refreshController.refreshCompleted();
      update();
      // update();
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///点击聊天列表项
  void chatItemClick(index) {
    var itemData = dataList[index];
    print(itemData);
    Get.toNamed('/chat');
  }

  void deleteChatItem(index) {
    print(index);
    dataList.removeAt(index);
    update();
  }
}
