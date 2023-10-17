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
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class RoleListController extends GetxController {

  RefreshController refreshController = RefreshController(initialRefresh: false);
  /// 原始角色列表
  List roleList = [];

  @override
  void onReady() {
    super.onReady();
    getDataList();
    return;
  }

  /// 获取聊天列表数据
  void getDataList() {
    Future.delayed(const Duration(milliseconds: 500), () {
      roleList = [
        {
          "id":"111",
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "Daisy Riley",
          "hobby": "Baking, Reading, Writing, Dancing, Knitting",
          "intimacy": 5
        },
        {
          "id":"222",
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "Andre Goodwin",
          "hobby": "Learning languages",
          "intimacy": 100
        },
        {
          "id":"333",
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "Johanna Gonzalez",
          "hobby": "Playing musical instruments, Collecting stamps/coins, Rock climbing, Singing, Chess",
          "intimacy": 55
        },
        {
          "id":"4",
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "4Daisy Riley",
          "hobby": "Hi, could you help me find the science fiction",
          "intimacy": 56
        },
        {
          "id":"5",
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "5Daisy Riley",
          "hobby": "Playing musical instruments, Collecting stamps/coins, Rock climbing, Singing, Chess",
          "intimacy": 0
        },
        {
          "id":"6",
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "6Daisy Riley",
          "hobby": "Hi, could you help me find the science fiction",
          "intimacy": 5
        },
        {
          "id":"7",
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "7Daisy Riley",
          "hobby": "Hi, could you help me find the science fiction",
          "intimacy": 5
        },
        {
          "id":"8",
          "avatar": "http://kele.bestkele.cn/beaut.jpg",
          "roleName": "8Daisy Riley",
          "hobby": "Hi, could you help me find the science fiction",
          "intimacy": 5
        },
      ];
      refreshController.refreshCompleted();
      update();
    });
  }

  ///点击角色列表项
  void roleItemClick(index) {
    var itemData = roleList[index];
    print(itemData);
    Get.toNamed('/chat');
  }

}
