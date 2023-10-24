import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SoulMateMenuController extends GetxController {

  int currentIndex = 0;/// 菜单index
  int chatMessageNumber = 0;/// 聊天列表未读消息数
  int roleEventNumber = 0;/// 角色朋友圈未读消息数
  int lastClickTime = 0;/// 点击安卓返回键时间
  late PageController controller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = PageController(initialPage: currentIndex);
  }
  /// 切换菜单
  changeMenu(index){
    currentIndex = index;
    controller.jumpToPage(index);
    update();
  }
  /// 处理安卓返回键
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
  /// 修改未读消息数
  void updateMessageNum({int? chatMessageNum,int? roleMessageNum,}){
    chatMessageNumber = chatMessageNum??chatMessageNumber;
    roleEventNumber = chatMessageNum??roleEventNumber;
    update();
  }

}
