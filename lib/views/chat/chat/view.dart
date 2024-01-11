/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'dart:async';
import 'dart:convert';
import 'dart:ffi' hide Size;
import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/dataService/model/localChatMessage.dart';
import 'package:soulmate/models/chat.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/chat/chat/chat_blubble.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatState();
  }
}

class ChatState extends State<ChatPage> with WidgetsBindingObserver {
  final logic = Get.put(ChatController());
  late final RecorderController recorderController;

  String? path;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  bool isPause = false;
  int count = 5;
  late Directory appDirectory;
  Timer? timer;

  int recordDuration = 0;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
    WidgetsBinding.instance.addObserver(this);
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() async {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
    final result = await recorderController.checkPermission();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();

    WidgetsBinding.instance.removeObserver(this);
  }
  /// 临时高度变量
  double tempHeight = 0.0;
  /// 记录上一次滚动列表内容的实际高度，只有在高度变化的时候才计算
  double oldSliverListHeight = 0.0;
  /// 滚动列表内容的实际高度
  double sliverListHeight = 0.0;
  /// 滚动区域视窗高度
  double viewportHeight = 0.0;
  /// 填充区域高度
  double computedHeight = 0.0;
  @override
  Widget build(BuildContext context) {
    logic.chatMessageController = RefreshController(initialRefresh: false);
    return GetBuilder<ChatController>(builder: (logic) {
      return basePage('chat',
          appBar: AppBar(
            leadingWidth: 64.w,
            elevation: 0,
            toolbarHeight: 100.w,
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 28.w,
                ),
                Container(
                    width: 46.w,
                    height: 46.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w)),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: logic.roleDetail?.avatar ?? "",
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Container(),
                      ), // 图像的来源，可以是网络图像或本地图像
                    )),
                Text(logic.roleDetail?.name ?? '--',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'SFProRounded',
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 0, 0, 0.8))),
              ],
            ),
            leading: Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  key: logic.leadingKey,
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44.w),
                  ),
                  child: Image.asset(
                    "assets/images/icons/backIcon.png",
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                  iconSize: 44.w,
                  onPressed: () {
                    Get.toNamed('/chatBackground');
                  },
                  icon: Image.asset(
                    "assets/images/icons/backGroundIcon.png",
                  ))
            ],
            actionsIconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
          ),
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 14.w),
                    child: Container(
                      decoration: BoxDecoration(
                        image: logic.roleDetail?.imageId != null
                            ? DecorationImage(
                                image: AssetImage(
                                    "assets/images/chatBackground/${logic.roleDetail!.imageId}.png"),
                                fit: BoxFit.cover,
                              )
                            : null,
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: const Color.fromRGBO(0, 0, 0, 0.1),
                                width: 1.w)),
                        // image: const DecorationImage(image: AssetImage(("assets/images/image/chatBg.png")),fit: BoxFit.fitWidth)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric( horizontal: 16.w, vertical: 10.w),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            viewportHeight = constraints.maxHeight;
                            _computedContainerHeight("viewport");
                            return _refreshListView;
                          }
                        ),
                      ),
                    ),
                  ),
                ),
                _bottomContainer()
              ],
            ),
          ));
    });
  }

  /// 下拉列表
  Widget get _refreshListView => SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: logic.chatMessageController,
      onLoading: (){
        logic.getLocalChatMessageList('loadMore');
      },
    footer: CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Text("load failed!");
        } else  {
          body = const Text("");
        }
        return SizedBox(
          // height: 55.0,
          child: Center(child: body),
        );
      }),
    child: CustomScrollView(
            reverse: true,
            controller: logic.scrollController,
            cacheExtent: double.infinity,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  height: computedHeight,
                  // 可以在这里添加任何你想要的撑开内容的控件
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    // 这里假设 _messageItem 是你的列表项构建方法
                    Widget listItem = _messageItem(index);
                    if(index == 0){
                      ///重绘，重置变量
                      sliverListHeight=0;
                      tempHeight = 0;
                    }
                    // 使用 Builder 获取每个列表项的高度
                    return Builder(
                      ///这个key很重要，当没有的时候，messageList往后新增数据不会有什么问题，往前插入数据就会导致整个列表项重新渲染，和vue react 一样
                      ///要配合findChildIndexCallback使用才行
                      key: Key(logic.messageList[index].localChatId),
                      builder: (BuildContext context) {
                        // 使用 Builder 获取子项的实际渲染高度
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                          double itemHeight = renderBox.size.height;
                          // 更新 SliverList 的高度
                          tempHeight += itemHeight;
                          if(index == logic.messageList.length-1 ){
                            sliverListHeight = tempHeight;
                            if(oldSliverListHeight != sliverListHeight){
                              oldSliverListHeight = sliverListHeight;
                              _computedContainerHeight("sliverList");
                            }
                          }

                        });

                        return listItem;
                      },
                    );
                  },
                  childCount: logic.messageList.length,
                  findChildIndexCallback: (key) {
                    return logic.messageList.indexWhere((element) => Key(element.localChatId) == key);;
                  },
                ),
              ),
            ],
          ),
  );

  /// 底部用户输入区域
  Widget _bottomContainer() {
    return Container(
        color: Colors.white,
        constraints: BoxConstraints(
          minHeight: 90.w, // 设置最小高度为100.0像素
        ),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(
            16.w,
          ),
          alignment: Alignment.center,
          child: GetBuilder<ChatController>(builder: (logic) {
            if (logic.showVoiceWidget) {
              return Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await _stopRecording();
                        logic.toggleShowVoiceWidget(false);
                      },
                      child: Image.asset(
                        "assets/images/icons/activeRemove.png",
                        width: 21.w,
                        height: 21.w,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: Container(
                        height: 56.w,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _pauseOrContinueRecording();
                              },
                              child: Icon(
                                isPause
                                    ? Icons.play_circle
                                    : Icons.pause_circle,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: Center(
                              child: AudioWaveforms(
                                enableGesture: true,
                                size: Size(264.w, 56.w),
                                recorderController: recorderController,
                                waveStyle: const WaveStyle(
                                  waveColor: Colors.white,
                                  extendWaveform: true,
                                  showMiddleLine: false,
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "${recordDuration / 1000}S",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontFamily: FontFamily.SFProRoundedMedium,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(logic.showVoiceWidget==false || recordDuration<1000) return;
                        logic.toggleShowVoiceWidget(false);
                        await _stopRecording();
                        final messageFile = await MultipartFile.fromFile(path!,
                            filename: "voice.m4a");
                        logic.sendMessage(
                            messageType: "1", message_file: messageFile,filePath: path!);
                      },
                      child: Image.asset(
                        "assets/images/icons/activeSend.png",
                        width: 21.w,
                        height: 21.w,
                      ),
                    )
                  ],
                ),
              );
            }
            return Container(
                constraints: BoxConstraints(
                  minHeight: 56.w, // 设置最小高度为100.0像素
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.06),
                  borderRadius: BorderRadius.circular(27.w),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 10.w, bottom: 10.w, left: 10.w, right: 1.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(27.w),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            minLines: 1,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color.fromRGBO(0, 0, 0, 0.48),
                                fontFamily: "SFProRounded",
                                fontWeight: FontWeight.w400),
                            textInputAction: TextInputAction.send,
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: logic.inputContent,
                                    selection: TextSelection.fromPosition(
                                        TextPosition(
                                            affinity: TextAffinity.downstream,
                                            offset:
                                                logic.inputContent.length)))),
                            focusNode: logic.focusNode,
                            onChanged: logic.textInputChange,
                            onSubmitted: (String str) {
                              logic.inputContent = str;
                              logic.sendMessage(
                                  message: logic.inputContent,
                                  messageType: "0");
                            },
                            decoration: InputDecoration(
                                hintText:
                                    "Talk to ${logic.roleDetail?.name ?? 'me'}",
                                filled: true,
                                fillColor: Colors.transparent,
                                isCollapsed: true,
                                border: InputBorder.none),
                          )),
                    ),
                    Container(
                      width: 48.w,
                      padding: EdgeInsets.only(top: 10.w, bottom: 5.w),
                      child: GestureDetector(
                          onTap: () {
                            logic.toggleShowVoiceWidget(true);
                            _startRecording();
                          },
                          child: Image.asset(
                            'assets/images/icons/activeMicrophone.png',
                            width: 22.w,
                            height: 23.w,
                          )),
                    )
                  ],
                ));
          }),
        ));
  }

  /// 聊天信息展示组件
  Widget _messageItem(index) {
    LocalChatMessage chatData = logic.messageList[index];
    bool isUser = chatData.role == 'user';
    return chatData.inputType == 0
        ? Container(
            key: Key(chatData.localChatId),
            margin: EdgeInsets.only(bottom: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Offstage(
                  offstage: !logic.showTime(chatData, index),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 5.w, horizontal: 30.w),
                      child: SelectableText(
                        Utils.messageTimeFormat(chatData.createTime),
                        style: TextStyle(
                            fontFamily: "SFProRounded",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(0, 0, 0, 0.48)),
                      ),
                      // ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      textDirection: isUser?TextDirection.ltr:TextDirection.rtl,
                      children: [
                        ///0发送中, 1已发送, 2发送失败，3已删除
                        ///状态是0发送中，并且是3分钟内的消息，才显示loading，因为特殊情况下，发送失败的事件没接收到，状态就还是0，显示loading就很奇怪
                        Offstage(
                          offstage: (chatData.localStatus == 0 && DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(chatData.createTime)).inMinutes < 3) == false,
                          child:CupertinoActivityIndicator(radius: 8.w,)
                        ),
                        Offstage(
                            offstage: chatData.localStatus != 2,
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 20.w,
                            ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: isUser ? primaryColor : const Color.fromRGBO(239, 239, 239, 1),
                              borderRadius: isUser ? BorderRadius.only(
                                  topLeft: Radius.circular(20.w),
                                  topRight: Radius.circular(20.w),
                                  bottomLeft: Radius.circular(20.w))
                                  : BorderRadius.only(
                                  topLeft: Radius.circular(20.w),
                                  topRight: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w)),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12.w, horizontal: 20.w),
                            child: Text(
                              chatData.content,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
                                  color: isUser ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.8)),
                            ),
                          ))
                      ],
                    )),
              ],
            ),
          )
        : ChatBlubble(
            key: Key(chatData.localChatId),
            chatData: chatData,
          );
  }


  void createRecordTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      recordDuration = recorderController.elapsedDuration.inMilliseconds;
      setState(() {});
    });
  }
  //计算填充区域高度
  void _computedContainerHeight(String from){
    double diffHeight = viewportHeight - sliverListHeight;
    if(from == "viewport") {
      computedHeight = diffHeight > 0 ? diffHeight : 0;
    }else if(from == "sliverList"){
      Future.delayed(Duration(milliseconds: 10),(){
        setState(() {
          computedHeight = diffHeight > 0 ? diffHeight : 0;
        });
      });
    }
  }

  /// 开始录音
  void _startRecording() async {
    try {

      await recorderController.record(path: path);
      createRecordTimer();

      setState(() {
        isPause = false;
        isRecordingCompleted = false;
        isRecording = !isRecording;
      });
    } catch (e) {
      debugPrint("debug:${e.toString()}");
    }
  }

  /// 暂停录制
  void _pauseOrContinueRecording() async {
    try {
      if (isRecording) {
        if (isPause) {
          await recorderController.record();
          timer?.cancel();
        } else {
          await recorderController.pause();
          createRecordTimer();
        }

        setState(() {
          isPause = !isPause;
        });
      }
    } catch (e) {
      debugPrint("debug:${e.toString()}");
    }
  }

  /// 停止录制
  Future<void> _stopRecording() async {
    try {
      if (isRecording) {
        recorderController.reset();
        timer?.cancel();
        recordDuration = 0;
        final path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
        }
        setState(() {
          isRecording = !isRecording;
        });
      }
    } catch (e) {
      debugPrint("debug:${e.toString()}");
    }
  }
}
