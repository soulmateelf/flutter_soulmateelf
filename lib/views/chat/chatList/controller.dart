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
    Future.delayed(const Duration(milliseconds: 500), () {
      dataList = [
        {
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "1Daisy Riley",
          "content": "Hi, could you help me find the science fiction",
          "time": "20231010"
        },
        {
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "2Daisy Riley",
          "content": "Hi, could you help me find the science fiction",
          "time": "20231010"
        },
        {
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "3Daisy Riley",
          "content": "Hi, could you help me find the science fiction",
          "time": "20231010"
        },
      ];
      refreshController.refreshCompleted();
      update();
    });
  }

  ///点击聊天列表项
  void chatItemClick(item) {
    print(item);
  }
}
