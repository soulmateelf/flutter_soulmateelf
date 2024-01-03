/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/role.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/base/menu/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/material/dialog.dart';

class ChatListController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<Role> dataList = [];
  final menuLogic = Get.find<SoulMateMenuController>();


  @override
  void onReady() {
    super.onReady();
    getDataList();
    menuLogic.chatListController = this;
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  /// 获取聊天列表数据
  void getDataList() {
    HttpUtils.diorequst('/role/roleListByUser', query: {"limit": 999})
        .then((response) {
      List roleListMap = response["data"];
      dataList = roleListMap.map((json) => Role.fromJson(json)).toList();
      refreshController.refreshCompleted();
      // menuLogic.updateMessageNum(chatMessageNum: 8);
      update();
    }).catchError((error) {
      refreshController.refreshFailed();
      exSnackBar(error, type: ExSnackBarType.error);
    });

    getRoleListUnreadCount();
  }

  /// 获取角色消息未读的总数量
  void getRoleListUnreadCount() {
    HttpUtils.diorequst('/chat/getNoReadMessageCount').then((res) {
      menuLogic.updateMessageNum(chatMessageNum: res?['data'] ?? 0);
    });
  }



  ///点击聊天列表项
  void chatItemClick(index) {
    Role itemData = dataList[index];
    Get.toNamed("/chat", arguments: {"roleId": itemData.roleId});
  }

  void deleteConfirm(index) {
    final makeDialogController = MakeDialogController();

    makeDialogController.show(
      context: Get.context!,
      controller: makeDialogController,
      iconWidget: Image.asset("assets/images/icons/deleteChat.png"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 8.w,
          ),
          Text(
            "Intimacy and chat history will be cleared.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.SFProRoundedMedium,
            ),
          ),
          SizedBox(
            height: 70.w,
          ),
          Container(
            height: 64.w,
            width: double.maxFinite,
            child: TextButton(
                onPressed: () {
                  makeDialogController.close();
                  deleteChatItem(index);
                },
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white)),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w)))),
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.w,
                    fontFamily: FontFamily.SFProRoundedBlod,
                  ),
                )),
          ),
          SizedBox(
            height: 10.w,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              makeDialogController.close();
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.32),
                  fontSize: 20.sp,
                  fontFamily: FontFamily.SFProRoundedMedium,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.w,
          ),
        ],
      ),
    );
  }

  void deleteChatItem(index) {
    HttpUtils.diorequst('/role/deleteUserRole',
        method: 'post',
        params: {"roleId": dataList[index].roleId}).then((response) {
      dataList.removeAt(index);
      update();
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }
}
