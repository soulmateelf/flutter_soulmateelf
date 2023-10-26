/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/chat.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class ChatPage extends StatelessWidget {
  final logic = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    logic.refreshController = RefreshController(initialRefresh: false);
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
                SizedBox(height: 28.w,),
                Container(
                  width: 46.w,
                  height: 46.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w)),
                  child: ClipOval(
                    child:  CachedNetworkImage(
                      imageUrl: logic.roleDetail?.avatar??"",
                      placeholder: (context, url) => const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Container(),
                    ), // 图像的来源，可以是网络图像或本地图像
                  )
                ),
                Text(logic.roleDetail?.name??'--',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'SFProRounded',
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 0, 0, 0.8))
                ),
              ],
            ),
            leading: IconButton(
                iconSize: 44.w,
                onPressed: () {
                  Get.back();
                },
                icon: Image.asset("assets/images/icons/backIcon.png",)),
            actions: [
              IconButton(
                  iconSize: 44.w,
                  onPressed: () {
                    Loading.toast("别点");
                    // Get.toNamed('/feedback');
                  },
                  icon: Image.asset("assets/images/icons/more.png",))
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
                          border: Border.symmetric( horizontal: BorderSide(color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1.w)),
                          // image: const DecorationImage(image: AssetImage(("assets/images/image/chatBg.png")),fit: BoxFit.fitWidth)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.w),
                        child: _refreshListView,
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
      enablePullDown: logic.canRefresh,
      enablePullUp: false,
      controller: logic.refreshController,
      scrollController: logic.scrollController,
      onRefresh: () {
        logic.getMessageList('refresh');
      },
      child: ListView.builder(
          cacheExtent: double.infinity,
          itemCount: logic.messageList.length,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {},
                child: _messageItem(index));
          }));

  /// 底部用户输入区域
  Widget _bottomContainer() {
    return Container(
        color: Colors.white,
        constraints: BoxConstraints(
          minHeight: 90.w, // 设置最小高度为100.0像素
        ),
        child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.w,),
        alignment: Alignment.center,
        child: Container(
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
                child:  Container(
                    padding: EdgeInsets.only(
                        top: 10.w,bottom: 10.w, left: 10.w,right: 1.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27.w),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      minLines: 1,
                      style: TextStyle(
                          fontSize: 16.sp, color: const Color.fromRGBO(0, 0, 0, 0.48),fontFamily: "SFProRounded",fontWeight: FontWeight.w400),
                      textInputAction: TextInputAction.send,
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: logic.inputContent,
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: logic.inputContent.length)))),
                      focusNode: logic.focusNode,
                      onChanged: logic.textInputChange,
                      onSubmitted: (String str) {
                        logic.inputContent = str;
                        logic.sendMessage(logic.inputContent);
                      },
                      decoration: InputDecoration(
                          hintText:"Talk to ${logic.roleDetail?.name??'me'}",
                          filled: true,
                          fillColor: Colors.transparent,
                          isCollapsed: true,
                          border: InputBorder.none),
                    )),
              ),
              Container(
                width: 48.w,
                padding: EdgeInsets.only(top:10.w,bottom: 5.w),
                child: GestureDetector(
                    onTap: () {},
                    child: Image.asset('assets/images/icons/microphone.png',width: 22.w,height: 23.w,)),
              )
            ],
          )
        )));
  }
  /// 聊天信息展示组件
  Widget _messageItem(index) {
    ChatHistory chatData = logic.messageList[index];
    return Container(
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
                  color: const Color.fromRGBO(255,255,255,0.7),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 30.w),
                child: Text(
                  Utils.messageTimeFormat(chatData.createTime),
                  style: TextStyle(
                      fontFamily: "SFProRounded",
                      fontSize: 16.sp,fontWeight: FontWeight.w400, color: const Color.fromRGBO(0, 0, 0, 0.48)),
                ),
                // ),
              ),
            ),
          ),
          Container(
              alignment: chatData.role == 'user'
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              margin: EdgeInsets.only(top: 12.w),
              child: Container(
                decoration: BoxDecoration(
                  color: chatData.role == 'user'
                      ? primaryColor
                      : const Color.fromRGBO(239, 239, 239, 1),
                  borderRadius: chatData.role == 'user'
                      ?BorderRadius.only(topLeft: Radius.circular(20.w),topRight: Radius.circular(20.w),bottomLeft: Radius.circular(20.w)):BorderRadius.only(topLeft: Radius.circular(20.w),topRight: Radius.circular(20.w),bottomRight: Radius.circular(20.w)),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.w),
                child: Text(
                  chatData.content,
                  style: TextStyle(
                    fontSize: 16.sp,fontWeight: FontWeight.w400,height: 1.3, color: chatData.role == 'user'
                    ? Colors.white:const Color.fromRGBO(0, 0, 0, 0.8)),
                ),
              )),
        ],
      ),
    );
  }


}
