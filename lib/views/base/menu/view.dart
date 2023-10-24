/// Author: kele
/// Date: 2022-01-18 17:53:28
/// LastEditors: kele
/// LastEditTime: 2022-03-08 18:43:42
/// Description:

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/chat/chatList/view.dart';
import 'package:soulmate/views/role/roleList/view.dart';
import 'package:soulmate/widgets/library/resource/keepalive.dart';
import 'package:soulmate/views/mine/mine/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';

class MenuPage extends StatelessWidget {
  final logic = Get.put(SoulMateMenuController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: logic.dealBack,
        child: Scaffold(
          backgroundColor:const Color.fromRGBO(242, 242, 242, 1),
          bottomNavigationBar: GetBuilder<SoulMateMenuController>(builder: (logic) {
            return _buildBottomNavigationBar();
          }),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: logic.controller,
            children: [
              KeepAliveBox(contentWidget: ChatListPage()),
              KeepAliveBox(contentWidget: RoleListPage()),
              KeepAliveBox(contentWidget: MinePage())
            ],
          ),
        ));
  }
  /// 图标列表
  final normalIconList = <String>[
    'assets/images/menuIcon/message.png',
    'assets/images/menuIcon/role.png',
    'assets/images/menuIcon/mine.png',
  ];
  /// 选中状态图标列表
  final activeIconList = <String>[
    'assets/images/menuIcon/messageActive.png',
    'assets/images/menuIcon/roleActive.png',
    'assets/images/menuIcon/mineActive.png',
  ];
  /// 菜单
  Widget _buildBottomNavigationBar() {
    return AnimatedBottomNavigationBar.builder(
      itemCount: normalIconList.length,
      tabBuilder: (int index, bool isActive) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 70.w,
                height: 50.w,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(logic.currentIndex == index?activeIconList[index]:normalIconList[index],width: 26.w,height: 24.w,),
                    ),
                    /// 聊天的未读消息展示组件
                    (index == 0 && logic.chatMessageNumber > 0) ? Positioned(
                      top: -1,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9.sp),  // Defines the border radius
                        ),
                        child: Container(
                            width: 32.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 1.w,horizontal: 2.w),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(9.sp),  // Defines the border radius
                            ),
                            child: Text(logic.chatMessageNumber>99?'99+':logic.chatMessageNumber.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.white),
                            )),
                      ),
                    ):Container(),
                    /// 角色的朋友圈的未读消息展示组件
                    (index == 1 && logic.roleEventNumber > 0) ? Positioned(
                      top: 8,
                      right: 14,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(9.sp),  // Defines the border radius
                        ),
                      ),
                    ):Container(),
                  ],
                ))
          ],
        );
      },
      backgroundColor: Colors.white,
      activeIndex: logic.currentIndex,
      splashColor: primaryColor,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.none,
      leftCornerRadius: 24.w,
      rightCornerRadius: 24.w,
      onTap: (index) {
        logic.changeMenu(index);
      },
      // hideAnimationController: _hideBottomBarAnimationController,
      shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 1,
          color: Color.fromRGBO(0, 0, 0, 0.08)),
    );
  }
}
