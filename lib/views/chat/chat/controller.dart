/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide FormData;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/chat.dart';
import 'package:soulmate/models/role.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/chat/chatList/controller.dart';
import 'package:soulmate/views/intro/index.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/services.dart';

class ChatController extends GetxController {
  /// 角色id
  String roleId = "";

  /// 角色详情信息
  Role? roleDetail;

  /// 聊天记录
  List<ChatHistory> messageList = [];

  ///刷新控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  ///滚动控制器
  ScrollController scrollController = ScrollController();

  ///键盘控制器
  // KeyboardVisibilityController keyboardVisibilityController =
  //     KeyboardVisibilityController();

  ///输入框焦点
  FocusNode focusNode = FocusNode();

  ///页码
  int page = 0;

  ///可以下拉刷新
  bool canRefresh = true;

  ///消息输入框内容
  String inputContent = '';

  /// 防抖，用户停止输入2秒调用接口，使用gpt回答
  Timer? _debounce;

  /// 延迟时间
  Duration duration = const Duration(seconds: 2);

  /// 是否聊过天，然后更新首页的聊天历史
  bool hasChat = false;

  /// 是否显示底部与语音模块
  bool showVoiceWidget = false;

  /// 是否是需要引导功能
  bool isIntro = false;

  /// 引导数据
  dynamic introData;

  /// 遮罩层
  OverlayEntry? overlayEntry;

  void toggleShowVoiceWidget() {
    showVoiceWidget = !showVoiceWidget;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    roleId = Get.arguments?["roleId"];
    isIntro = Get.arguments['intro'] ?? false;
    getRoleDetail();
    getMessageList('init');
    if (isIntro) {
      getIntroData().then((res) {
        showIntro();
      });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  @override
  void onClose() {
    if (hasChat == true) {
      /// 聊过天，更新首页聊天列表
      final chatController = Get.find<ChatListController>();
      chatController.getDataList();
    }
    refreshController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    _debounce?.cancel();
    super.onClose();
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

  /// 获取聊天记录
  void getMessageList(String from) {
    Map<String, dynamic> query = {
      'page': from == 'newMessage' ? 1 : (page + 1),
      'size': from == 'newMessage' ? 1 : 10,
      'roleId': roleId
    };
    HttpUtils.diorequst('/chat/getMessageList', query: query).then((response) {
      page++;
      refreshController.refreshCompleted();
      List chatListMap = response["data"];
      APPPlugin.logger.d(chatListMap);
      List<ChatHistory> newList =
          chatListMap.map((json) => ChatHistory.fromJson(json)).toList();
      if (from == 'newMessage') {
        ///新消息，往下加
        messageList.addAll(newList);

        /// 记录聊过天的状态
        hasChat = true;
      } else {
        ///历史消息,往上插入
        messageList.insertAll(0, newList);
      }

      if (chatListMap == null || chatListMap.isEmpty) {
        ///没有更多数据了
        canRefresh = false;
      } else {
        canRefresh = true;
      }
      update();
      if (from != 'refresh') {
        ///新消息或者第一页，滚动到底部
        Future.delayed(const Duration(milliseconds: 300), () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    }).catchError((error) {
      refreshController.refreshCompleted();
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///发送消息
  void sendMessage(
      {String? message, required String message_type, dynamic? message_file}) {
    APPPlugin.logger.d(message_file);
    if (message_type == "0" && Utils.isEmpty(message)) {
      return;
    } else if (message_type == "1" && message_file == null) {
      return;
    }
    FormData params = FormData();

    params.fields.add(MapEntry("roleId", roleId));
    params.fields.add(MapEntry("message_type", message_type));

    if (message_type == "0" && !Utils.isEmpty(message)) {
      focusNode.unfocus();
      params.fields.add(MapEntry("messages", message!));
    } else if (message_type == "1" && message_file != null) {
      params.files.add(MapEntry("file", message_file));
    }

    // {'message': message, 'roleId': roleId,'message_type' : 0}
    HttpUtils.diorequst('/chat/sendMessage', method: 'post', params: params)
        .then(
      (response) {
        if (response?['data'] == true) {
          //清空当前消息
          inputContent = '';
          update();
          //获取最新消息列表
          getMessageList('newMessage');
          //启动定时器，如果已存在，删掉，搞个新的
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(duration, startGptTask);
        } else {
          exSnackBar(response?['message'], type: ExSnackBarType.error);
        }
      },
    ).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///发送信号给后台，可以调用gpt接口了
  void startGptTask() {
    Map<String, dynamic> params = {'roleId': roleId};
    HttpUtils.diorequst('/chat/chatRollBack', method: 'post', params: params)
        .then((response) {
      getMessageList('newMessage');
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///是否展示时间模块
  bool showTime(ChatHistory chatData, int index) {
    if (index == 0) {
      ///第一条消息就展示时间
      return true;
    }

    ///与上一条消息的时间差在5分钟内不展示
    var lastMessgeDate =
        DateTime.fromMillisecondsSinceEpoch(messageList[index - 1].createTime);
    var currentMessgeDate =
        DateTime.fromMillisecondsSinceEpoch(chatData.createTime);
    var diffMinutes = currentMessgeDate.difference(lastMessgeDate).inMinutes;
    if (diffMinutes < 5) {
      return false;
    } else {
      return true;
    }
  }

  /// 监听用户输入事件
  void textInputChange(String value) {
    inputContent = value;

    /// 存在才能删除建新的，不存在说明是刚进页面第一次输入
    if (_debounce?.isActive == true) {
      _debounce?.cancel();
      _debounce = Timer(duration, startGptTask);
    }
  }

  Future<void> getIntroData() async {
    Map<String, dynamic> json =
        jsonDecode(await rootBundle.loadString("assets/introList.json"));
    final List<dynamic> data = json['data'];

    introData = data.firstWhereOrNull((role) => role['roleId'] == roleId);
  }

  /// 引导步骤数据
  dynamic currentIntro = null;
  List<String> introHistoryList = [];

  void endIntro() {
    APPPlugin.logger.d(introHistoryList);
    if (introHistoryList.length == 0) {
      return;
    }
    final firstStep = introHistoryList[0];

    HttpUtils.diorequst('/guide', method: "post", params: {
      "chooseRoleId": roleId,
      "oneChoose": firstStep,
      "towChoose": introHistoryList[1],
      "threeChoose": introHistoryList[2],
      "chooseType": firstStep == "chatNow" ? 0 : 1
    }).then((res) {
      if (firstStep == "chatNow") {
        /// 请后后端打招呼
        getMessageList("newMessage");
      } else if (firstStep == "test") {
        /// 帮助用户发送一条消息
        late String message = "";
        if (roleId == "3333") {
          message =
              "Begin the divination for ${introHistoryList[1]}(I ${introHistoryList[2]}).";
        } else if (roleId == "otyuiyiytuiyuiuiytui") {
          message = introHistoryList[2];
        } else if (roleId == "opasdioaoduiowe") {
          message = introHistoryList[2];
        } else if (roleId == "fsdgasagsagsagsgsg") {
          message = introHistoryList[2];
        } else if (roleId == "qeqqeqwqeqee") {
          message = introHistoryList[2];
        }

        sendMessage(message_type: "0", message: message);
      }
    }).catchError((err) {
      APPPlugin.logger.d(err);
    });
  }

  void nextIntro(String option) {
    introHistoryList.add(option);
    List<dynamic> options = currentIntro?['options'] ?? [];
    final next =
        options.firstWhereOrNull((opt) => opt?['text'] == option)?['next'];
    currentIntro = next;
    if (currentIntro != null) {
      overlayEntry?.markNeedsBuild();
    } else {
      overlayEntry?.remove();
      endIntro();
    }
  }

  void fristIntroStep(String type) {
    if (overlayEntry != null) {
      overlayEntry!.remove();
    }
    introHistoryList.add(type);
    final inrolList = introData?['introList'];
    if (type == "chatNow") {
      currentIntro = inrolList[0];
    } else if (type == "test") {
      currentIntro = inrolList[1];
    }

    List<Widget> renderOptions(List<dynamic> options) {
      List<Widget> list = [];
      for (var i = 0; i < options.length; i++) {
        final opt = options[i];
        list.add(
          GestureDetector(
            onTap: () {
              nextIntro(opt?['text']);
            },
            child: Container(
              height: 34.w,
              width: 213.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image:
                    AssetImage('assets/images/image/introOptionButtonBg.png'),
                fit: BoxFit.cover,
              )),
              child: Text(
                "${opt?['text']}",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        );
      }
      return list;
    }

    overlayEntry = OverlayEntry(builder: (_) {
      return GestureDetector(
        onTap: () {
          // overlayEntry?.remove();
        },
        child: Container(
          padding: EdgeInsets.all(20.w),
          color: Color.fromRGBO(0, 0, 0, 0.74),
          alignment: Alignment.center,
          child: Container(
            width: 388.w,
            height: 352.w,
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(introData?['SkillBg']),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: 213.w,
              constraints: BoxConstraints(maxWidth: 213.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 170.w,
                    height: 119.w,
                    padding: EdgeInsets.only(
                      left: 17.w,
                      right: 33.w,
                      top: 17.w,
                    ),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/image/introBubble.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      "${currentIntro?['message']}",
                      key: UniqueKey(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamily.SFProRoundedMedium,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  Expanded(
                    child: Column(
                      key: UniqueKey(),
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: renderOptions(currentIntro?['options'] ?? []),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    Overlay.of(Get.context!).insert(overlayEntry!);
  }

  void showIntro() {
    overlayEntry = OverlayEntry(builder: (_) {
      return GestureDetector(
        onTap: () {
          // overlayEntry?.remove();
        },
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.74),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "${introData?['avatar']}",
                width: 86.w,
                height: 86.w,
              ),
              SizedBox(
                height: 34.w,
              ),
              Container(
                width: 388.w,
                height: 352.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.w),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/image/greetingBg.png")),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${introData?["greeting"]}",
                      style: TextStyle(
                          color: textColor, fontSize: 15.sp, height: 1.25),
                    ),
                    SizedBox(
                      height: 29.w,
                    ),
                    IntroChatButton(
                        backgroundImage:
                            "assets/images/image/introOptionButtonBg.png",
                        onTap: () {
                          fristIntroStep("chatNow");
                        },
                        child: Text(
                          "Chat now",
                          style:
                              TextStyle(color: primaryColor, fontSize: 15.sp),
                        )),
                    SizedBox(
                      height: 29.w,
                    ),
                    IntroChatButton(
                        backgroundImage:
                            "assets/images/image/introOptionButtonBg.png",
                        onTap: () {
                          fristIntroStep("test");
                        },
                        child: Text(
                          "Test",
                          style:
                              TextStyle(color: primaryColor, fontSize: 15.sp),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });

    Overlay.of(Get.context!).insert(overlayEntry!);
  }
}
