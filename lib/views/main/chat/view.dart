import 'dart:ffi';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';

import 'logic.dart';

class ChatPage extends StatelessWidget {
  final logic = Get.put(ChatLogic());
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ChatLogic());
    return GetBuilder<ChatLogic>(builder: (logic) {
      return basePage(
        logic.roleInfo['roleName'] ?? '',
        bodyColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: ClipOval(
              child: Image.network(logic.roleInfo['images'] ?? '',
                  width: 60.w, height: 60.w, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            );
          })),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Get.toNamed('/settings');
            },
          ),
        ],
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromRGBO(242, 242, 242, 1),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Stack(
                            children: [
                              CachedNetworkImage(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                imageUrl: logic.roleInfo['roleBackground']??"",
                                errorWidget: (context, url, error) => Text(''),
                              ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 2.w),
                                    child: _refreshListView,
                                )
                            ],
                        )
                    ),
                    _bottomContainer()
                  ],
                ),
                Positioned(
                    right: -50.w,
                    bottom: -50.w,
                    child: Offstage(
                        offstage:
                        !logic.isRecording, // 设置是否可见：true:不可见 false:可见
                        child: CustomAnimationBuilder<double>(
                          control:
                          logic.isRecording ? Control.mirror : Control.stop,
                          tween: Tween(begin: 0.3, end: 0.8),
                          duration: const Duration(milliseconds: 1200),
                          delay: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          startPosition: 0.5,
                          animationStatusListener: (status) {
                            // debugPrint('status updated: $status');
                          },
                          builder: (context, value, child) {
                            return Opacity(
                                opacity: value,
                                child: Container(
                                  width: 260.w,
                                  height: 260.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(30, 141, 237, 0.4),
                                  ),
                                  child: child,
                                ));
                          },
                        ))),

                Positioned(
                    right: -50.w,
                    bottom: -50.w,
                    child: Offstage(
                        offstage:
                        !logic.isRecording, // 设置是否可见：true:不可见 false:可见
                        child: CustomAnimationBuilder<double>(
                          control:
                          logic.isRecording ? Control.mirror : Control.stop,
                          tween: Tween(begin: 0.3, end: 0.8),
                          duration: const Duration(milliseconds: 1200),
                          delay: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          startPosition: 0.5,
                          animationStatusListener: (status) {
                            // debugPrint('status updated: $status');
                          },
                          builder: (context, value, child) {
                            return Opacity(
                                opacity: value,
                                child: Container(
                                  width: 240.w,
                                  height: 240.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(30, 141, 237, 0.6),
                                  ),
                                  child: child,
                                ));
                          },
                        ))),
                Positioned(
                    right: -40.w,
                    bottom: -40.w,
                    child: Offstage(
                        offstage:
                        !logic.isRecording, // 设置是否可见：true:不可见 false:可见
                        child: CustomAnimationBuilder<double>(
                          control:
                          logic.isRecording ? Control.mirror : Control.stop,
                          tween: Tween(begin: 0.3, end: 0.8),
                          duration: const Duration(milliseconds: 1200),
                          delay: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          startPosition: 0.5,
                          animationStatusListener: (status) {
                            // debugPrint('status updated: $status');
                          },
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Container(
                                width: 200.w,
                                height: 200.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(30, 141, 237, 0.8),
                                ),
                                child: child,
                              ));
                          },
                        ))),
              ],
            )),
      );
    });
  }

  /// 下拉列表
  Widget get _refreshListView => SmartRefresher(
      enablePullDown: logic.canRefresh,
      enablePullUp: false,
      controller: logic.refreshController,
      scrollController: logic.scrollController,
      onRefresh: () {
        logic.getMessageList('refresh');
      },
      child: ListView.builder(
          itemCount: logic.messageList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {},
                child: _messageItem(index, logic.messageList[index]));
          }));

  /// 底部用户输入区域
  Widget _bottomContainer() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: logic.isRecording
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        logic.cancelStatus
                            ? 'release to cancel'
                            : 'slide up to cancel',
                        style: TextStyle(
                            fontSize: 34.sp,
                            color: const Color.fromRGBO(102, 102, 102, 0.6)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.w),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(1, 204, 204, 204),
                          borderRadius: BorderRadius.circular(27.w),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        minLines: 1,
                        style: const TextStyle(
                            fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.85)),
                        textInputAction: TextInputAction.send,
                        controller: TextEditingController.fromValue(
                            TextEditingValue(
                                text: logic.inputContent,
                                selection: TextSelection.fromPosition(
                                    TextPosition(
                                        affinity: TextAffinity.downstream,
                                        offset: logic.inputContent.length)))),
                        focusNode: logic.focusNode,
                        onChanged: (String str) {
                          logic.inputContent = str;
                        },
                        onSubmitted: (String str) {
                          logic.inputContent = str;
                          logic.sendMessage(logic.inputContent);
                        },
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            isCollapsed: true,
                            border: InputBorder.none),
                      )),
            ),
            Container(
              width: 80.w,
              child: _operateIcon(),
            )
          ],
        ));
  }

  /// 操作图标
  _operateIcon() {
    switch (logic.iconType) {
      case 'normal':
        //正常状态，显示录音按钮
        return GestureDetector(
            onLongPressStart: (event) {
              logic.startListening(event);
            },
            onLongPressEnd: (event) {
              logic.stopListening();
            },
            onLongPressUp: () {
              logic.stopListening();
            },
            onLongPressMoveUpdate: (event) {
              logic.moveListening(event);
            },
            child: Icon(
              Icons.keyboard_voice_outlined,
              size: 60.w,
            ));
      case 'input':
        //消息输入中，显示发送按钮
        return GestureDetector(
            onTap: () {
              logic.sendMessage(logic.inputContent);
            },
            child: Icon(
              Icons.send,
              color: Get.theme.primaryColor,
              size: 60.w,
            ));
    }
  }

  /// 聊天信息展示组件
  Widget _messageItem(index, itemData) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Offstage(
            offstage: !logic.showTime(itemData, index),
            child: Container(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 217, 217, 0.6),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 30.w),
                child: Text(
                  logic.messageTimeFormat(itemData, index),
                  style: TextStyle(
                      fontSize: 22.sp, color: Color.fromRGBO(102, 102, 102, 1)),
                ),
                // ),
              ),
            ),
          ),
          Container(
              alignment: itemData['role'] == 'user'
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: itemData['role'] == 'user'
                      ? const Color.fromRGBO(228, 253, 211, 1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                child: Text(
                  itemData['content'],
                  style: TextStyle(
                      fontSize: 28.sp, color: Color.fromRGBO(102, 102, 102, 1)),
                ),
              )),
        ],
      ),
    );
  }
}
