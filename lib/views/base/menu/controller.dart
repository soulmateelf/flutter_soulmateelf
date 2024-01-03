import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/mqtt.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/chat/chat/controller.dart';
import 'package:soulmate/views/chat/chatList/controller.dart';
import 'package:soulmate/views/chat/message/controller.dart';

import '../../../models/user.dart';

class SoulMateMenuController extends GetxController {
  late User? user;

  int currentIndex = 0;

  /// 菜单index
  int chatMessageNumber = 0;

  /// 聊天列表未读消息数
  int roleEventNumber = 0;

  /// 角色朋友圈未读消息数
  int lastClickTime = 0;

  /// 点击安卓返回键时间
  late PageController controller;

  ///左上角铃铛
  int unreadMessageCount = 0;

  ChatListController? chatListController;

  /// 获取左上角未读消息的数量
  void getUnreadMessage() {
    HttpUtils.diorequst("/message/messageNoReadCount").then((res) {
      unreadMessageCount = res?['data'] ?? 0;
      update();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = PageController(initialPage: currentIndex);
    user = Application.userInfo;
    if (user != null) {
      APPPlugin.mqttClient?.topicSubscribe([
        Topic(user!.userId!, (message) {
          ///0是日常消息与系统消息刷新，1是聊天未读数刷新,2是gpt聊天消息模块
          if (message.clear == true) {
            if (message.messageType == 0) {
              getUnreadMessage();
            } else if (message.messageType == 1) {
              chatListController?.getRoleListUnreadCount();
            } else if (message.messageType == 2) {
              print(222);
              ChatController chatController = Get.find<ChatController>();
              if(chatController != null){
                chatController.mqttServerMessageback(message.content);
              }
            }
          }
        })
      ]);
    }
  }

  @override
  void onReady() {
    final hasIntro = Application.hasIntro;
    getUnreadMessage();
    if (!hasIntro) {
      Get.toNamed("/introWelcome");
    }
  }

  /// 切换菜单
  changeMenu(index) {
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
  void updateMessageNum({
    int? chatMessageNum,
    int? roleMessageNum,
  }) {
    chatMessageNumber = chatMessageNum ?? chatMessageNumber;
    roleEventNumber = roleMessageNum ?? roleEventNumber;
    update();
  }
}
