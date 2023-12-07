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
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'controller.dart';

class RoleListPage extends StatelessWidget {
  final logic = Get.put(RoleListController());
  @override
  Widget build(BuildContext context) {
    logic.refreshController = RefreshController(initialRefresh: false);
    /// 在三个主模块入口ScreenUtil初始化，真机调试刷新就没问题了
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return basePage('Friend',
        backGroundImage: BackGroundImageType.gray,
        leading: IconButton(
            iconSize: 44.w,
            onPressed: () {
              Get.toNamed('/message');
            },
            icon: Image.asset(
              "assets/images/icons/message.png",)),
        actions: [
          IconButton(
              iconSize: 44.w,
              onPressed: () {
                Get.toNamed('/feedback');
              },
              icon: Image.asset(
                "assets/images/icons/email.png",))
        ], child: GetBuilder<RoleListController>(builder: (logic) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.w,horizontal: 14.w),
        color: Colors.transparent,
        child: Column(
          children: [_customContainer(), Expanded(child: _refreshListView)],
        ),
      );
    }));
  }

  /// 定制按钮区域
  Widget _customContainer() {
    return GestureDetector(
      onTap: (){
        Get.toNamed('/customRoleStep1');
      },
      child: Container(
          width: double.infinity,
          height: 64.w,
          margin: EdgeInsets.only(bottom: 10.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(0, 252, 255, 1),
                Color.fromRGBO(133, 232, 233, 1),
                Color.fromRGBO(0, 159, 255, 1),
                Color.fromRGBO(31, 255, 0, 1),
                Color.fromRGBO(0, 110, 255, 1),
                Color.fromRGBO(255, 0, 246, 1),
                Color.fromRGBO(128, 16, 255, 1),
                Color.fromRGBO(255, 51, 0, 1),
                Color.fromRGBO(255, 232, 0, 1),
                Color.fromRGBO(255, 150, 0, 1),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius:
                BorderRadius.circular(10.w), // Optional: for rounded corners
          ),
          child: Container(
            margin: EdgeInsets.all(2.w),
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20.w),
                  child: Image.asset(
                    'assets/images/icons/customRole.png',
                    width: 32.w,
                    height: 28.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add your ELF',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'SFProRounded-Semibold',
                            fontWeight: FontWeight.w600,
                            color: const Color.fromRGBO(0, 0, 0, 0.8))),
                    Text('Customize your own',
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'SFProRounded-Medium',
                            height: 1.3,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(0, 0, 0, 0.48)))
                  ],
                )
              ],
            ),
          )),
    );
  }

  /// 下拉列表
  Widget get _refreshListView => SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      controller: logic.refreshController,
      onRefresh: logic.getDataList,
      child: listViewNoDataPage(
          isShowNoData: logic.roleList.isEmpty,
          omit: 'nothing here',
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 8.w,
            itemCount: logic.roleList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    logic.roleItemClick(index);
                  },
                  child: _roleItem(index));
            },
          )));

  /// 列表项
  Widget _roleItem(index) {
    var roleData = logic.roleList[index];
    return Container(
      decoration: BoxDecoration(
        /// todo-这里是有朋友圈事件展示边框，第二版做
        gradient: roleData.intimacy == -1
            ? const LinearGradient(
                colors: [
                  Color.fromRGBO(217, 78, 255, 1),
                  Color.fromRGBO(255, 202, 71, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(10.w), // Optional: for rounded corners
      ),
      child: Container(
          margin: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(10.w), // Optional: for rounded corners
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: 192.w),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.w), // 圆角半径
                        child: CachedNetworkImage(
                          imageUrl: roleData.avatar??"",
                          placeholder: (context, url) => const CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) => Container(),
                        ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 8.w, left: 12.w, right: 12.w, bottom: 4.w),
                    alignment: Alignment.centerLeft,
                    child: Text(roleData.name??"--",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'SFProRounded-Medium',
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(0, 0, 0, 0.8))),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          left: 12.w, right: 12.w, bottom: 12.w),
                      alignment: Alignment.centerLeft,
                      child: Text(roleData.hobby??'--',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'SFProRounded',
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(0, 0, 0, 0.4))))
                ],
              ),
              Positioned(
                  top: 5.w,
                  left: 5.w,
                  child: Container(
                    // width: 50.w,
                    // height: 20.w,
                    alignment: Alignment.centerLeft,
                    padding:
                        EdgeInsets.symmetric(vertical: 3.w, horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          10.w), // Optional: for rounded corners
                    ),
                    child: Row(children: [
                      Image.asset(
                        'assets/images/icons/heart.png',
                        width: 18.w,
                        height: 16.w,
                        fit: BoxFit.cover,
                      ),
                      Text(roleData.intimacy != null?roleData.intimacy.toString():'0',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'SFProRounded-Medium',
                              height: 1.3,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(0, 0, 0, 0.64)))
                    ]),
                  ))
            ],
          )),
    );
  }
}
