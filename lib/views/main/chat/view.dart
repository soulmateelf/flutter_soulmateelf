
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class ChatPage extends StatelessWidget {
  final logic = Get.put(ChatLogic());
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ChatLogic());
    return GetBuilder<ChatLogic>(builder: (logic) {
      return basePage('role name',
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                'assets/images/icons/avatar.png',
                width: 60.w,
                height: 60.w,
              ),
          ),
          actions:[
            IconButton(icon:const Icon(Icons.settings_outlined), onPressed: () {  },),
          ],
          child:Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
            child: Column(
              children: [
                Expanded(child: _refreshListView),
                _bottomContainer()
              ],
            ),
          )
      );
    });
  }
  /// 下拉列表
  Widget get _refreshListView => SmartRefresher(
      enablePullDown: logic.canRefresh,
      enablePullUp: false,
      controller: logic.refreshController,
      onRefresh: logic.getDataList,
      child: ListView.builder(
          itemCount: logic.messageList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {},
                child: _messageItem(index, logic.messageList[index]));
          }));
  /// 底部用户输入区域
  Widget _bottomContainer(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.w),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(1,204, 204, 204),
                  borderRadius: BorderRadius.circular(27.w),
                  border:Border.all(color:Colors.grey,width: 1)
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                minLines: 1,
                style: const TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.85)),
                textInputAction: TextInputAction.send,
                decoration: const InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none
                ),
                onSubmitted: (String str) {
                  APPPlugin.logger.i(str);
                },
              )
          ),
        ),
        GestureDetector(onLongPress: (){print('long press');}, child: Icon(Icons.keyboard_voice_outlined,size: 60.w,))
      ],
    );
  }
  /// 聊天信息展示组件
  Widget _messageItem(index,itemData){
    print(index);
    return Text(itemData['content']);
  }
}
