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
import 'package:soulmate/utils/core/constants.dart';
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
            iconSize: 44.w,
            onPressed: () {
              Get.toNamed('/message');
            },
            icon: GetBuilder<ChatListController>(
              builder: (controller) {
                return Stack(
                  children: [
                    Image.asset(
                      "assets/images/icons/message.png",
                    ),
                    Positioned(
                      top: 10.w,
                      right: 10.w,
                      child: AnimatedOpacity(
                        opacity: controller.unreadMessageCount > 0 ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.w),
                            color: const Color.fromRGBO(255, 90, 90, 1),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            )),
        actions: [
          IconButton(
              iconSize: 44.w,
              onPressed: () {
                Get.toNamed('/feedback');
              },
              icon: Image.asset(
                "assets/images/icons/email.png",
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
        child: SlidableAutoCloseBehavior(
          child: _refreshListView,
        ),
      );
    }));
  }

  /// 下拉列表
  Widget get _refreshListView => SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: logic.refreshController,
      onRefresh: logic.getDataList,
      onLoading: () {
        print("loading");
      },
      child: listViewNoDataPage(
          isShowNoData: logic.dataList.isEmpty,
          omit: 'No messages yet',
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
      groupTag: "0",
      endActionPane: ActionPane(
        extentRatio: 0.22,
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (context) {
              logic.deleteConfirm(index);
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
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: roleData.avatar ?? "",
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Container(),
                    ), // 图像的来源，可以是网络图像或本地图像
                  ),
                ),
                roleData.countSize != null && roleData.countSize! > 0
                    ? Positioned(
                        top: -5.w,
                        right: -10.w,
                        child: Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                18.sp), // Defines the border radius
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.w, horizontal: 5.w),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 86, 0, 1),
                                borderRadius: BorderRadius.circular(
                                    9.sp), // Defines the border radius
                              ),
                              child: Text(
                                roleData.countSize! > 99
                                    ? '99+'
                                    : roleData.countSize.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    : Container(),
              ],
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
