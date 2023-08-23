/// Author: kele
/// Date: 2022-01-18 17:53:28
/// LastEditors: kele
/// LastEditTime: 2022-03-08 18:43:42
/// Description:

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/views/chat/chatList/view.dart';
import 'package:soulmate/views/role/roleList/view.dart';
import 'package:soulmate/widgets/library/resource/keepalive.dart';
import 'package:soulmate/views/mine/mine/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MenuPage extends StatelessWidget {
  final logic = Get.put(MenuLogic());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: logic.dealBack,
        child: Scaffold(
          bottomNavigationBar: GetBuilder<MenuLogic>(builder: (logic) {
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

  /// 菜单
  Widget _buildBottomNavigationBar() {
    return CustomNavigationBar(
      scaleFactor: 0.5,
      iconSize: 25.w,
      strokeColor: const Color.fromRGBO(255, 255, 255, 0),

      /// 设置透明度0，去掉波纹效果
      backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
      items: [
        CustomNavigationBarItem(
            icon: Image.asset(logic.currentIndex == 0
                ? 'assets/images/menuIcon/homeActive.png'
                : 'assets/images/menuIcon/home.png'),
            title: Text('首页',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: logic.currentIndex == 0
                        ? const Color.fromRGBO(0, 123, 245, 1)
                        : const Color.fromRGBO(162, 162, 162, 1)))),
        CustomNavigationBarItem(
            icon: Image.asset(logic.currentIndex == 1
                ? 'assets/images/menuIcon/projectActive.png'
                : 'assets/images/menuIcon/project.png'),
            title: Text('项目',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: logic.currentIndex == 1
                        ? const Color.fromRGBO(0, 123, 245, 1)
                        : const Color.fromRGBO(162, 162, 162, 1)))),

        CustomNavigationBarItem(
            icon: Image.asset(logic.currentIndex == 4
                ? 'assets/images/menuIcon/mineActive.png'
                : 'assets/images/menuIcon/mine.png'),
            title: Text('我的',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: logic.currentIndex == 4
                        ? const Color.fromRGBO(0, 123, 245, 1)
                        : const Color.fromRGBO(162, 162, 162, 1))))
      ],
      currentIndex: logic.currentIndex,
      onTap: (index) {
        logic.changeMenu(index);
      },
    );
  }
}
