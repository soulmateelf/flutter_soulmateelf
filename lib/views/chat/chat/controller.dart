/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide FormData;
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/dataService/model/localChatMessage.dart';
import 'package:soulmate/dataService/service/localChatMessageService.dart';
import 'package:soulmate/dataService/service/syncRecordService.dart';
import 'package:soulmate/models/chat.dart';
import 'package:soulmate/models/role.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/DBUtil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/base/menu/controller.dart';
import 'package:soulmate/views/chat/chatList/controller.dart';
import 'package:soulmate/views/intro/index.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

class ChatController extends GetxController {
  /// 角色id
  String roleId = "";

  /// 角色详情信息
  Role? roleDetail;

  /// 聊天记录
  List<LocalChatMessage> messageList = [];

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

  GlobalKey leadingKey = GlobalKey();

  SoulMateMenuController menuLogic = Get.find<SoulMateMenuController>();

  /// 本地数据库表名
  String tableName = '';

  /// 调用gpt的lockId,为了多条消息合并成一条调用gpt，后端要求的参数
  String lockId = '';

  void toggleShowVoiceWidget(value) {
    showVoiceWidget = value;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    roleId = Get.arguments?["roleId"];
    isIntro = Get.arguments['intro'] ?? false;
    getRoleDetail();
    getLocalChatMessageList('init');
    if (isIntro) {
      ///开启引导功能
      getIntroData().then((res) {
        showIntro();
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    roleId = Get.arguments?["roleId"];
    /// 如果不存在用户角色聊天记录表，创建
    tableName = 'chat_${Application.userInfo?.userId}_$roleId';
    DBUtil.createTableIfNotExists(tableName);
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

  /// 获取本地聊天记录
  void getLocalChatMessageList(String from) {
    int queryPage = page + 1;
    int limit =  10;
    LocalChatMessageService.getChatMessageList(tableName,page:queryPage, limit:limit).then((List<LocalChatMessage> newList) {
      refreshController.refreshCompleted();
      page++;
      ///历史消息,往上插入
      messageList.insertAll(0, newList.reversed);
      if (newList.isEmpty) {
        ///没有更多数据了
        canRefresh = false;
      }
      update();
      if (from == 'init') {
        ///进来第一页，滚动到底部
        toEndMessage();
      }
    }).catchError((error) {
      refreshController.refreshFailed();
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  /// 消息列表滚动到最底部
  void toEndMessage() {
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    });
  }
  ///本地数据库插入新消息
  void insertLocalChatMessage(LocalChatMessage localChatMessage) async{
    LocalChatMessageService.insertChatMessage(tableName, localChatMessage).then((value) {
      ///插入成功
      ///清空当前消息
      inputContent = '';
      ///更新本地消息列表
      messageList.add(localChatMessage);
      update();
      ///滚动到底部
      toEndMessage();
    }).catchError((error) {
      exSnackBar(error.toString(), type: ExSnackBarType.error);
    });
  }
  /// 消息发送至服务端，成功或者失败，更新本地数据库消息状态
  void updateLocalChatData(String localChatId,{ChatHistory? chatHistory}) async{
    ///先查询本地数据库的消息
    LocalChatMessage? localChatMessage = await LocalChatMessageService.getChatMessageRecord(tableName, localChatId);
    if (localChatMessage == null) {
      return;
    }
    ///有chatHistory，是发送成功的消息
    if(chatHistory != null) {
      ///更新本地消息
      localChatMessage.serverChatId = chatHistory.chatId;
      localChatMessage.voiceUrl = chatHistory.voiceUrl??"";
      localChatMessage.status = chatHistory.status;
      localChatMessage.createTime = chatHistory.createTime;
      localChatMessage.updateTime = DateTime.now().millisecondsSinceEpoch;
      localChatMessage.localStatus = 1;
    }else {
      ///更新本地消息
      localChatMessage.updateTime = DateTime.now().millisecondsSinceEpoch;
      localChatMessage.localStatus = 2;
    }
    LocalChatMessageService.updateChatMessage(tableName, localChatMessage).then((value) {
      ///查找到本地消息列表的那一条，更新本地消息列表
      int index = messageList.indexWhere((element) => element.localChatId == localChatMessage.localChatId);
      if (index != -1) {
        messageList[index] = localChatMessage;
        update();
      }
      ///发送消息成功，更新同步记录表，记录本地最新的消息id
      if (chatHistory != null) {
        SyncRecordService.insertOrUpdateSyncRecord(Application.userInfo!.userId,roleId,chatHistory.chatId,chatHistory.createTime);
      }
    }).catchError((error) {
      exSnackBar(error.toString(), type: ExSnackBarType.error);
    });
  }
  ///mqtt回复消息了，更新页面消息列表
  void mqttUpdateMessageList(String roleId,LocalChatMessage localChatMessage) async{
    ///不是当前角色的消息，不处理
    if (roleId != this.roleId) {
      return;
    }
    ///更新本地消息列表
    messageList.add(localChatMessage);
    update();
    ///滚动到底部
    toEndMessage();
    /// 如果是引导功能进来的，角色回复第一条消息，显示引导结束提示框
    if (isIntro) {
      showGiftIntro();
    }
  }
  ///本地数据库的数据处理
  void localDataHandle({required String localChatId,String? message, required String messageType, dynamic? message_file,String? filePath}) async{
    ///立即往本地数据库新增一条消息
    ///构建本地消息
    LocalChatMessage tempLocalChatMessage = LocalChatMessage(
        localChatId: localChatId,
        role: 'user',
        origin: 0,
        content: message??'',
        voiceUrl: '',
        inputType: int.parse(messageType),
        status: 0,
        localStatus: 0,
        createTime: DateTime.now().millisecondsSinceEpoch
    );
    ///如果是语音，复制一份语音文件到本地，这样就能直接播放，不需要等mqtt推送再下载了
    if (messageType == "1" && message_file != null && filePath != null) {
      File file = File(filePath!);
      final appDirectory = await getApplicationDocumentsDirectory();
      ///目标文件路径
      String destinationFilePath = "${appDirectory.path}/${tempLocalChatMessage.localChatId}.wav";
      ///复制文件，这里我直接把录音的m4a文件复制成wav文件了
      file.copySync(destinationFilePath);
    }
    ///插入本地数据库
    insertLocalChatMessage(tempLocalChatMessage);
  }
  ///发送消息
  Future<void> sendMessage(
      {String? message, required String messageType, dynamic? message_file,String? filePath}) async {
    if (messageType == "0" && Utils.isEmpty(message)) {
      return;
    } else if (messageType == "1" && message_file == null) {
      return;
    }
    /// 本地消息的id
    String localChatId = const Uuid().v4();
    ///本地数据库的数据处理
    localDataHandle(localChatId: localChatId,message: message,messageType: messageType,message_file: message_file,filePath: filePath);
    ///构建FormData请求参数
    FormData params = FormData();
    params.fields.add(MapEntry("roleId", roleId));
    params.fields.add(MapEntry("message_type", messageType));
    if (messageType == "0" && !Utils.isEmpty(message)) {
      focusNode.unfocus();
      params.fields.add(MapEntry("messages", message!));
    } else if (messageType == "1" && message_file != null) {
      params.files.add(MapEntry("file", message_file));
    }
    HttpUtils.diorequst('/chat/sendMessage', method: 'post', params: params)
        .then(
      (response) {
        if (response?['data'].isNotEmpty) {
          /// 记录聊过天的状态
          hasChat = true;
          ///发送成功，更新本地消息状态
          lockId = response?['data']['lockId'];
          ChatHistory chatHistory = ChatHistory.fromJson(response?['data']['message']);
          updateLocalChatData(localChatId,chatHistory: chatHistory);
          //启动定时器，如果已存在，删掉，搞个新的
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(duration, startGptTask);
        } else {
          exSnackBar(response?['message'], type: ExSnackBarType.error);
        }
      },
    ).catchError((error) {
      updateLocalChatData(localChatId);
      exSnackBar(error.toString(), type: ExSnackBarType.error);
    });
  }

  ///发送信号给后台，可以调用gpt接口了
  void startGptTask() {
    Map<String, dynamic> params = {'roleId': roleId, 'lockId': lockId};
    HttpUtils.diorequst('/chat/chatRollBack', method: 'post', params: params)
        .then((response) {
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///是否展示时间模块
  bool showTime(LocalChatMessage chatData, int index) {
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
  /// 加载引导数据
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
      if (firstStep == "test") {
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
        sendMessage(messageType: "0", message: message);
      }
    }).catchError((err) {
      APPPlugin.logger.e(err);
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
              decoration: const BoxDecoration(
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
  /// 开始引导展示框
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
  ///  引导结束提示框
  void showGiftIntro() {
    final ctx = leadingKey.currentContext!;
    RenderBox renderBox = ctx.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    EdgeInsets _margin = getMargin(ctx);
    EdgeInsets _padding = getPadding(ctx);
    BorderRadius _borderRadius = getBorderRadius(ctx);
    overlayEntry = OverlayEntry(builder: (_) {
      return Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    // overlayEntry?.remove();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        backgroundBlendMode: BlendMode.dstOut),
                  ),
                ),
                AnimatedPositioned(
                    duration: Duration(milliseconds: 1000),
                    top: offset.dy + _margin.top,
                    left: offset.dx + _margin.left,
                    child: GestureDetector(
                      onTap: () {
                        overlayEntry?.remove();
                        Application.hasIntro = true;
                        menuLogic.changeMenu(2);
                        Get.until((route) => Get.currentRoute == "/menu");
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: size.width - _margin.left,
                        height: size.height - _margin.top,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: _borderRadius),
                      ),
                    )),
              ],
            ),
          ),
          Positioned(
            left: 20.w,
            top: size.height + offset.dy,
            right: 20.w,
            bottom: 20.w,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width, right: 38.w),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 17.w, vertical: 10.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius),
                          bottomLeft: Radius.circular(borderRadius),
                        ),
                      ),
                      child: Text(
                        "Click here to return, then go to the personal center, where you can check the balance.",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15.sp,
                          fontFamily: FontFamily.SFProRoundedMedium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 127.w,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 388.w,
                        height: 377.w,
                        padding: EdgeInsets.only(
                            top: 77.w, left: 32.w, right: 32.w, bottom: 32.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 12.w,
                            ),
                            Text(
                              "Your gift",
                              style: TextStyle(
                                color: textColor,
                                fontFamily: FontFamily.SFProRoundedMedium,
                                fontSize: 24.sp,
                              ),
                            ),
                            Text(
                              "Star energy   +1",
                              style: TextStyle(
                                color: primaryColor,
                                fontFamily: FontFamily.SFProRoundedBlod,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                              ),
                            ),
                            Text(
                              "Intimacy  +20",
                              style: TextStyle(
                                color: primaryColor,
                                fontFamily: FontFamily.SFProRoundedBlod,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                              ),
                            ),
                            SizedBox(
                              height: 21.w,
                            ),
                            Container(
                              width: double.infinity,
                              height: 64.w,
                              child: MaterialButton(
                                onPressed: () {
                                  overlayEntry?.remove();
                                  Application.hasIntro = true;
                                },
                                color: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                ),
                                child: Text(
                                  "Receive",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: -77.w,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 154.w,
                          alignment: Alignment.center,
                          child:
                              Image.asset("assets/images/icons/giftIcon.png"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
    Overlay.of(Get.context!).insert(overlayEntry!);
  }
}
