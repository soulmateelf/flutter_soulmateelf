/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'controller.dart';

class ChatListPage extends StatelessWidget {
  final logic = Get.put(ChatListController());
  @override
  Widget build(BuildContext context) {
    logic.refreshController = RefreshController(initialRefresh: false);
    /// 在三个主模块入口ScreenUtil初始化，真机调试刷新就没问题了
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return basePage('Chat',
        backGroundImage: BackGroundImageType.gray,
        leading: IconButton(
            onPressed: () {
              Get.toNamed('/message');
            },
            icon: Image.asset(
              "assets/images/icons/message.png",
              height: 44.w,
              width: 44.w,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/feedback');
              },
              icon: Image.asset(
                "assets/images/icons/email.png",
                height: 44.w,
                width: 44.w,
              )),
        ], child: GetBuilder<ChatListController>(builder: (logic) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 18.w, left: 16.w, right: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.sp),
              topRight: Radius.circular(24.sp)),
        ),
        child: _refreshListView,
      );
    }));
  }

  /// 下拉列表
  Widget get _refreshListView => SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      controller: logic.refreshController,
      onRefresh: logic.getDataList,
      child: listViewNoDataPage(
          isShowNoData: logic.dataList.isEmpty,
          omit: 'nothing here',
          child: ListView.builder(
              itemCount: logic.dataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      logic.chatItemClick(index);
                    },
                    child: _sliderItem(index));
              })));

  /// 滑动组件
  Widget _sliderItem(index) {
    var roleData = logic.dataList[index];
    return Slidable(
      key: ValueKey(roleData.roleId),
      endActionPane: ActionPane(
        extentRatio: 0.22,
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (context) {
              logic.deleteChatItem(index);
            },
            child: Image.asset('assets/images/icons/slideDelete.png',
                width: 44.w, height: 44.w),
          ),
        ],
      ),
      child: _listItem(index),
    );
  }

  /// 聊天列表项
  Widget _listItem(index) {
    var roleData = logic.dataList[index];
    return Container(
        margin: EdgeInsets.only(bottom: 20.w),
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              child: ClipOval(
                child:  CachedNetworkImage(
                  imageUrl: roleData.avatar??"",
                  placeholder: (context, url) => const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Container(),
                ), // 图像的来源，可以是网络图像或本地图像
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(12.w, 12.w, 0, 12.w),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(roleData.name ?? '--',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'SFProRounded-Medium',
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(0, 0, 0, 0.8))),
                      ),
                      Text(
                        Utils.messageTimeFormat(roleData.endSendTime),
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'PingFangRegular',
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(0, 0, 0, 0.24)),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.w, bottom: 1.w),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        roleData.content ?? '--',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(0, 0, 0, 0.32)),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
