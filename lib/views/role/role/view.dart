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
import 'package:like_button/like_button.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/roleEvent.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
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
                child: SmartRefresher(
                  controller: logic.refreshController,
                  enablePullUp: true,
                  physics: logic.showEventList
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  onLoading: () {
                    logic.getRoleRecordList(GetRoleEventType.loadMore);
                  },
                  onRefresh: () {
                    logic.getRoleRecordList(GetRoleEventType.refresh);
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 24.w, horizontal: 20.w),
                          child: _roleDetailContainer(),
                        ),
                        Stack(
                          children: [
                            Container(
                              child: GetBuilder<RoleController>(
                                builder: (controller) {
                                  return Column(
                                    children: renderRecordList(
                                        controller.roleEventList),
                                  );
                                },
                              ),
                            ),
                            Offstage(
                              offstage: logic.showEventList,
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10.0, sigmaY: 10.0),
                                  child: Container(
                                    color: Colors.transparent,
                                    width: double.infinity,
                                    height: 530.h,
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            clipBehavior: Clip.none,
                                            width: double.infinity,
                                            height: 308.w,
                                            padding: EdgeInsets.only(top: 75.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40.w),
                                                topRight: Radius.circular(40.w),
                                              ),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(12.w),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Intimacy greater than 20 to view.Come chat with me!",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color: textColor,
                                                      fontFamily: FontFamily
                                                          .SFProRoundedMedium,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 24.w,
                                                  ),
                                                  Container(
                                                    height: 64.w,
                                                    width: double.infinity,
                                                    child: MaterialButton(
                                                      color: primaryColor,
                                                      onPressed: () {
                                                        logic.toChat();
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                borderRadius),
                                                      ),
                                                      child: Text(
                                                        "Chat now",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.sp,
                                                          fontFamily: FontFamily
                                                              .SFProRoundedBlod,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -65.w,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              width: 130.w,
                                              height: 130.w,
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                  "assets/images/image/successfully.png"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
              height: 130.w,
              child: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(top: 16.w),
                    child: Text(logic.roleDetail?.description ?? '--',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: const Color.fromRGBO(0, 0, 0, 0.56)))),
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Offstage(
                offstage: !(logic.roleDetail?.intimacy != null &&
                    logic.roleDetail!.intimacy! >= 20),
                child: GestureDetector(
                  onTap: () {
                    logic.toChat();
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
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
                )),
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
  List<Widget> renderRecordList(List<RoleEvent> events) {
    List<Widget> list = [];
    events.forEach((event) {
      var likes = logic.sendLikeMap?[event.memoryId] ?? [];

      var likeCount = likes.length;
      var commentCount = 0;
      bool hasLike = likes.indexOf(logic.user!.userId!) != -1;
      event.activities.forEach((element) {
        if (element.type == 1) {
          commentCount++;
        }
      });

      list.add(Container(
        padding: EdgeInsets.fromLTRB(26.w, 20.w, 20.w, 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 73.w,
              height: 24.w,
              child: RichText(
                overflow: TextOverflow.visible,
                text: TextSpan(children: [
                  TextSpan(
                      text: DateTime.fromMillisecondsSinceEpoch(
                              event.publishTime!)
                          .format(payload: "DD"),
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: FontFamily.SFProRoundedMedium,
                          color: textColor)),
                  WidgetSpan(
                      child: SizedBox(
                    width: 4.w,
                  )),
                  TextSpan(
                      text: DateTime.fromMillisecondsSinceEpoch(
                              event.publishTime!)
                          .format(payload: "MMM"),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: textColor,
                      )),
                ]),
              ),
            ),
            SizedBox(
              width: 21.w,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  logic.toEventDetail(event);
                },
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: 288.w,
                      height: 234.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: CachedNetworkImage(
                        width: 288.w,
                        height: 234.w,
                        fit: BoxFit.cover,
                        imageUrl: event.image ?? "",
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    Text(
                      event.content,
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
                        Row(
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
                              "${commentCount}",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.64),
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 32.w,
                        ),
                        Row(
                          children: [
                            LikeButton(
                              size: 18.sp,
                              isLiked: hasLike,
                              circleColor: const CircleColor(
                                  start: Colors.grey, end: primaryColor),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: primaryColor,
                                dotSecondaryColor: primaryColor,
                              ),
                              likeCount: likeCount,
                              countBuilder: (c, _, __) {
                                return Text(
                                  "$c",
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.64),
                                    fontSize: 15.sp,
                                  ),
                                );
                              },
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color:
                                      isLiked ? primaryColor : Colors.black87,
                                  size: 18.sp,
                                );
                              },
                              onTap: (liked) async {
                                logic.debounceSendLike(event);
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
    });

    return list;
  }
}
