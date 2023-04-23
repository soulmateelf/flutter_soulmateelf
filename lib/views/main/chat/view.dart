
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
      return basePage(logic.roleInfo['roleName']??'',
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: ClipOval(
                child: Image.network(
                  logic.roleInfo['images']??'',
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.arrow_back_ios_new,color: Colors.black,);
                  }
                )
              ),
          ),
          actions:[
            IconButton(icon:const Icon(Icons.settings_outlined), onPressed: () { Get.toNamed('/settings'); },),
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
      onRefresh: logic.getMessageList,
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
                controller: TextEditingController.fromValue(TextEditingValue(text: logic.currentMessage)),
                focusNode: logic.focusNode,
                onChanged: (String str) {
                  logic.currentMessage = str;
                },
                onSubmitted: (String str) {
                  logic.currentMessage = str;
                },
                decoration: const InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none
                ),
              )
          ),
        ),
        _operateIcon(),
      ],
    );
  }
  /// 操作图标
  _operateIcon(){
    switch(logic.iconType){
      case 'normal':
        //正常状态，显示录音按钮
        return GestureDetector(onTap: (){}, child: Icon(Icons.keyboard_voice_outlined,size: 60.w,));
      case 'input':
        //消息输入中，显示发送按钮
        return GestureDetector(onTap: (){logic.sendMessage();}, child: Icon(Icons.send,color: Get.theme.primaryColor,size: 60.w,));
    }
  }
  /// 聊天信息展示组件
  Widget _messageItem(index,itemData){
    return Container(
      margin: EdgeInsets.only(bottom: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment:Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 217, 217, 0.6),
                borderRadius: BorderRadius.circular(40),
              ),
              padding: EdgeInsets.symmetric(vertical: 5.w,horizontal: 30.w),
              child: Text(itemData['createTime'].toString(),style: TextStyle(fontSize: 22.sp, color: Color.fromRGBO(102, 102, 102, 1)),),
            ),
          ),
          Container(
            alignment: itemData['role']=='user'?Alignment.centerRight:Alignment.centerLeft,
            margin: EdgeInsets.only(top: 20.w),
            child:Container(
              decoration: BoxDecoration(
                color: itemData['role']=='user'?const Color.fromRGBO(228, 253, 211, 1):Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.w,horizontal: 20.w),
              child: Text(itemData['content'],style: TextStyle(fontSize: 28.sp, color: Color.fromRGBO(102, 102, 102, 1)),),
            )
          ),
        ],
      ),
    );
  }
}
