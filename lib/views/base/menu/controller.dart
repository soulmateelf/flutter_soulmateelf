import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/dataService/model/localChatMessage.dart';
import 'package:soulmate/dataService/model/syncRecord.dart';
import 'package:soulmate/dataService/service/localChatMessageService.dart';
import 'package:soulmate/dataService/service/syncRecordService.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/DBUtil.dart';
import 'package:soulmate/utils/plugin/mqtt.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/chat/chat/controller.dart';
import 'package:soulmate/views/chat/chatList/controller.dart';
import 'package:uuid/uuid.dart';

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

  /// 聊天列表控制器
  ChatListController? chatListController;

  /// 获取左上角未读消息的数量
  void getUnreadMessage() {
    HttpUtils.diorequst("/message/messageNoReadCount").then((res) {
      unreadMessageCount = res?['data'] ?? 0;
      update();
    });
  }

  ///收到mqtt推送的聊天gpt回复消息后的操作，插入本地数据库，如果存在聊天界面则刷新聊天界面
  void mqttServerMessageBack(String payload) async {
    ///gpt回复的内容总是有换行符，需要替换掉
    payload = payload.replaceAll('\n', '\\n');
    Map<String, dynamic> payloadMap = jsonDecode(payload);

    /// 如果不存在用户角色聊天记录表，创建
    String tableName =
        'chat_${Application.userInfo?.userId}_${payloadMap['roleId']}';
    await DBUtil.createTableIfNotExists(tableName);

    ///构建本地消息
    LocalChatMessage tempLocalChatMessage = LocalChatMessage(
        localChatId: const Uuid().v4(),
        serverChatId: payloadMap['chatId'] ?? '',
        role: payloadMap['role'] ?? 'assistant',
        origin: 0,
        content: payloadMap['content'] ?? '',
        voiceUrl: payloadMap['voiceUrl'] ?? '',
        inputType: payloadMap['inputType'] ?? '0',
        status: payloadMap['status'] ?? 0,
        localStatus: 1,
        createTime: payloadMap['createTime']);

    ///插入本地数据库
    LocalChatMessageService.insertChatMessage(tableName, tempLocalChatMessage)
        .then((value) {
      ///插入成功
      ///如果存在聊天界面则刷新聊天界面
      try {
        ChatController chatController = Get.find<ChatController>();
        if (chatController != null) {
          chatController.mqttUpdateMessageList(
              payloadMap['roleId'], tempLocalChatMessage);
        }
      } catch (e) {
        ///刷新角色聊天列表页面
        chatListController?.getDataList();
      }

      ///接收消息成功，更新同步记录表，记录本地最新的消息id
      SyncRecordService.insertOrUpdateSyncRecord(
          Application.userInfo!.userId,
          payloadMap['roleId'],
          tempLocalChatMessage.serverChatId!,
          tempLocalChatMessage.createTime);
    });
  }

  ///数据同步
  void syncServerData() async {
    ///获取本地存储的同步记录，记录里存的是本地最新的消息id
    List<SyncRecord> syncRecordList =
        await SyncRecordService.getSyncRecordList(Application.userInfo!.userId);
    Map<String, String> params = {};
    for (var syncRecord in syncRecordList) {
      params[syncRecord.roleId] = syncRecord.lastChatId;
    }

    ///请求服务器，获取消息
    HttpUtils.diorequst("/chat/chatSync", method: 'post', params: params)
        .then((res) {
      Map<String, dynamic> dataMap = res['data'];

      ///如果有数据，插入本地数据库
      dataMap.forEach((roleId, chatList) async {
        /// 如果不存在用户角色聊天记录表，创建
        String tableName = 'chat_${Application.userInfo?.userId}_$roleId';
        await DBUtil.createTableIfNotExists(tableName);
        List<LocalChatMessage> localChatMessageList = [];
        for (var chatData in chatList) {
          ///构建本地消息
          LocalChatMessage tempLocalChatMessage = LocalChatMessage(
              localChatId: const Uuid().v4(),
              serverChatId: chatData['chatId'] ?? '',
              role: chatData['role'],
              origin: 0,
              content: chatData['content'] ?? '',
              voiceUrl: chatData['voiceUrl'] ?? '',
              inputType: chatData['inputType'] ?? '0',
              status: chatData['status'] ?? 0,
              localStatus: 1,
              createTime: chatData['createTime']);
          localChatMessageList.add(tempLocalChatMessage);
        }
        if (localChatMessageList.isNotEmpty) {
          ///插入本地数据库
          LocalChatMessageService.multipleInsertChatMessage(
                  tableName, localChatMessageList)
              .then((value) {
            ///接收消息成功，更新同步记录表，记录本地最新的消息id
            SyncRecordService.insertOrUpdateSyncRecord(
                Application.userInfo!.userId,
                roleId,
                localChatMessageList.last.serverChatId!,
                localChatMessageList.last.createTime);
          });
        }
      });
    });
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    controller = PageController(initialPage: currentIndex);
    user = Application.userInfo;
    if (user != null) {
      ///订阅mqtt消息
      await APPPlugin.mqttClient?.connect().then((value) {
        APPPlugin.mqttClient?.topicSubscribe([
          Topic(user!.userId!, (message) {
            ///0是日常消息与系统消息刷新，1是聊天未读数刷新,2是gpt聊天消息模块
            if (message.messageType == 0) {
              if (message.clear == true) {
                getUnreadMessage();
              }
            } else if (message.messageType == 1) {
              if (message.clear == true) {
                chatListController?.getRoleListUnreadCount();
              }
            } else if (message.messageType == 2) {
              mqttServerMessageBack(message.content);
            }
          })
        ]);
      });

      ///开启本地数据库服务端数据库的数据同步
      syncServerData();
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
    if (currentIndex == index) {
      return;
    }
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
