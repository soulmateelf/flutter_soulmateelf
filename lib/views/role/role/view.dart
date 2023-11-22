/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class RolePage extends StatelessWidget {
  final logic = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return basePage('Friend',
        child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: GetBuilder<RoleController>(builder: (logic) {
              return Container(
                // padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 20.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 24.w, horizontal: 20.w),
                      child: _roleDetailContainer(),
                    ),
                    Expanded(
                        child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                ...renderRecordList(),
                              ],
                            ),
                          ),
                        ),
                        // ClipRect(
                        //   child: BackdropFilter(
                        //     filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        //     child: Container(
                        //       color: Colors.transparent,
                        //       width: double.infinity,
                        //       height: double.infinity,
                        //       child: Center(
                        //         child: Container(
                        //           width: 100,
                        //           height: 100,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )),
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
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: logic.roleDetail?.avatar ?? "",
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Container(),
            ), // 图像的来源，可以是网络图像或本地图像
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 4.w),
                child: Text(logic.roleDetail?.name ?? '--',
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
                  Text(
                      logic.roleDetail?.age != null
                          ? logic.roleDetail!.age!.toString()
                          : '--',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'SFProRounded-Medium',
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
                    showGender(logic.roleDetail?.gender ?? ''),
                    width: 16.w,
                    height: 16.w,
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 8.w),
                child: Text(logic.roleDetail?.hobby ?? '--',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'SFProRounded-Semibold',
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(0, 0, 0, 0.64)))),
            Container(
                margin: EdgeInsets.only(top: 16.w),
                child: Text(logic.roleDetail?.description ?? '--',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        color: const Color.fromRGBO(0, 0, 0, 0.56)))),
            GestureDetector(
              onTap: () {
                Get.toNamed('/chat',
                    arguments: {"roleId": logic.roleDetail?.roleId});
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 16.w),
                padding: EdgeInsets.symmetric(vertical: 10.w),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12.w))),
                child: Text(
                  "Chat now",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'SFProRounded-Bold',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ))
      ],
    );
  }

  /// 展示性别
  String showGender(String gender) {
    if (gender == "male") return "assets/images/icons/male.png";
    if (gender == "female") return "assets/images/icons/female.png";
    return "assets/images/icons/genderOther.png";
  }

  /// 朋友圈列表
  List<Widget> renderRecordList() {
    List<Widget> list = [];

    for (int i = 0; i < 4; i++) {
      list.add(Container(
        padding: EdgeInsets.fromLTRB(26.w, 20.w, 20.w, 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 63.w,
              height: 24.w,
              child: Text(Utils.messageTimeFormat(
                  DateTime.now().millisecondsSinceEpoch)),
            ),
            SizedBox(
              width: 31.w,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 288.w,
                    height: 234.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.w),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/image/chatBg.png",
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Text(
                    "Today, while in the park, I saw a little girl hiding during a game of hide-and-seek. A butterfly landed on her… ",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.64),
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icons/comment.png",
                              width: 18.w,
                              height: 18.w,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              "15",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.64),
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icons/like.png",
                              width: 18.w,
                              height: 18.w,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              "26",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.64),
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }

    return list;
  }
}
