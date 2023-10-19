/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class RolePage extends StatelessWidget {
  final logic = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return basePage('Friend',
        showBgImage: true,
        child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: GetBuilder<RoleController>(builder: (logic) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 20.w),
                child: Column(
                  children: [
                    _roleDetailContainer(),
                    // const Expanded(child: Text('roleEventList'))
                  ],
                ),
              );
            })));
  }

  /// 角色详情部分
  Widget _roleDetailContainer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          margin: EdgeInsets.only(right: 20.w),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.w)),
          child: CircleAvatar(
            backgroundImage: logic.roleDetail?['avatar'] != null
                ? Image.network("${logic.roleDetail?['avatar']}",fit: BoxFit.cover,).image: Image.asset("assets/images/icons/avatar.png",fit: BoxFit.cover).image,
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 4.w),
                child: Text(logic.roleDetail['roleName'] ?? '--',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'SFProRounded-Semibold',
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 0.8)))),
            Container(
              margin: EdgeInsets.only(top: 8.w),
              width: 80.w,
              padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 12.w),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.56),
                  borderRadius: BorderRadius.all(Radius.circular(11.w))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(logic.roleDetail['age']?.toString() ?? '--',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'PingFangSC-Medium',
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: const Color.fromRGBO(55, 61, 67, 1))),
                  Container(
                    width: 1.w,
                    height: 13.w,
                    color: const Color.fromRGBO(167, 167, 167, 1),
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                  ),
                  Image.asset(
                    'assets/images/icons/male.png',
                    width: 16.w,
                    height: 16.w,
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 8.w),
                child: Text(logic.roleDetail['hobby'] ?? '--',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'SFProRounded-Semibold',
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(0, 0, 0, 0.64)))),
            Container(
                margin: EdgeInsets.only(top: 16.w),
                child: Text(logic.roleDetail['describe'] ?? '--',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'PingFangSC-Regular',
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        color: const Color.fromRGBO(0, 0, 0, 0.56)))),
            GestureDetector(
                onTap: () {
                  logic.getRoleDetail();
                  // Get.toNamed('/chat');
                },
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 16.w),
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(12.w))),
                    child: Text("Chat now",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'SFProRounded-Bold',
                            fontWeight: FontWeight.bold,
                            color: Colors.white))))
          ],
        ))
      ],
    );
  }
}
