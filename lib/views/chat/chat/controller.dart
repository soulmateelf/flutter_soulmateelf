/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/role.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ChatController extends GetxController {
  /// 角色id
  String roleId = "";

  /// 角色详情信息
  Role? roleDetail;

  /// 聊天记录
  List messageList = [
    {
      "role": "user",
      "content":
          "ok记录得到了打开都觉得多劳多得顶顶顶顶夸德拉多ok记录得到了打开都觉得多劳多得顶顶顶顶夸德拉多ok记录得到了打开都觉得多劳多得多",
      "createTime": 1684597262000,
    },
    {
      "role": "system",
      "content": "555",
      "createTime": 1698062170000,
    },
    {
      "role": "user",
      "content": "好多快递寄快递",
      "createTime": 1698062170000,
    },
    {
      "role": "system",
      "content":
          "好多快递寄快递好多快递寄快递好多快递寄快递好多快递寄快递好多快递寄快递好多快递寄快递好多快递寄快递好多快递寄快递好多快递寄快递好多快递寄快递好多快递寄快递",
      "createTime": 1698062170000,
    },
  ];

  ///刷新控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  ///滚动控制器
  ScrollController scrollController = ScrollController();

  ///键盘控制器
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  ///输入框焦点
  FocusNode focusNode = FocusNode();

  ///页码
  int page = 0;

  ///可以下拉刷新
  bool canRefresh = true;

  ///消息输入框内容
  String inputContent = '';

  @override
  void onReady() {
    super.onReady();
    roleId = Get.arguments?["roleId"];
    getRoleDetail();
    // getMessageList('init');
    return;
  }

  @override
  void onClose() {
    scrollController.dispose();
    focusNode.dispose();
    // keyboardVisibilitySubscriber?.cancel();
    super.onClose();
  }

  /// 获取角色详情
  void getRoleDetail() {
    HttpUtils.diorequst('/role/roleInfo', query: {"roleId": roleId})
        .then((response) {
      var roleDetailMap = response["data"];
      roleDetail = Role.fromJson(roleDetailMap);
      print(roleDetail?.name);
      update();
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  /// 获取聊天记录
  void getMessageList(String from) {
    return;
    Map<String, dynamic> query = {
      'pageNum': from == 'newMessage' ? 1 : (page + 1),
      'pageSize': from == 'newMessage' ? 2 : 10,
      'roleId': roleId
    };
    HttpUtils.diorequst('/role/roleInfo', query: query).then((response) {
      print(response);
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///发送消息
  void sendMessage(String message) {
    if (Utils.isEmpty(message)) {
      return;
    }
    focusNode.unfocus();
    Map<String, dynamic> params = {'message': message, 'roleId': roleId};
    HttpUtils.diorequst('/chat/sendMessage', method: 'post', params: params)
        .then((response) {
      print(response);
      // //清空当前消息
      // inputContent = '';
      // speechResult = '';
      // focusNode.unfocus();
      // update();
      // //获取最新消息列表
      // getMessageList('newMessage');
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///是否展示时间模块
  bool showTime(dynamic itemData, int index) {
    if (index == 0) {
      ///第一条消息就展示时间
      return true;
    }

    ///与上一条消息的时间差在5分钟内不展示
    var lastMessgeDate = DateTime.fromMillisecondsSinceEpoch(
        messageList[index - 1]['createTime']);
    var currentMessgeDate =
        DateTime.fromMillisecondsSinceEpoch(itemData['createTime']);
    var diffMinutes = currentMessgeDate.difference(lastMessgeDate).inMinutes;
    if (diffMinutes < 5) {
      return false;
    } else {
      return true;
    }
  }
}
