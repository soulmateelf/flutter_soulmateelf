/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'dart:io';
import 'dart:ui';
import 'package:flutter/src/services/asset_bundle.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'controller.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePage();
  }
}

class _MinePage extends State<MinePage> {
  final logic = Get.put(MineController());

  final _scrollController = ScrollController();

  double appBarMaxHeight = 117;

  double gap = 44;

  @override
  void initState() {
    // TODO: implement initState

    _scrollController.addListener(() {
      final offset = _scrollController.offset / 3;
      setState(() {
        if (offset > gap) {
          logic.setSize(appBarMaxHeight - gap);
        } else {
          logic.setSize(appBarMaxHeight - offset);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// 在三个主模块入口ScreenUtil初始化，真机调试刷新就没问题了
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return basePage('Chat',
        backGroundImage: BackGroundImageType.gray,
        showAppbar: false,
        child: GetBuilder<MineController>(builder: (logic) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.w),
            height: logic.size,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/mineAccount");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3.w, color: Colors.white)),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 80.w,
                      width: 80.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: logic.user?.avatar ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/icons/avatar.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${logic.user?.nickName}",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 24.sp,
                            fontFamily: FontFamily.SFProRoundedSemibold),
                      ),
                      Offstage(
                        offstage: logic.size < appBarMaxHeight - gap / 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 4.w),
                          child: Text(
                            "${logic.user?.email}",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.48),
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/feedback');
                  },
                  child: Image.asset(
                    "assets/images/icons/email.png",
                    width: 44.w,
                    height: 44.w,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250.w,
                    padding: EdgeInsets.all(20.w),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/image/balanceCardBg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/icons/energy.png",
                              width: 92.w,
                              height: 92.w,
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Balance",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.SFProRoundedBlod),
                                ),
                                SizedBox(
                                  height: 13.w,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: logic.CurrentEnergy.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40.sp,
                                            fontFamily:
                                                FontFamily.SFProRoundedBlod),
                                      ),
                                      WidgetSpan(
                                          child: SizedBox(
                                        width: 5.w,
                                      )),
                                      TextSpan(
                                        text: "Star energy",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          textBaseline: TextBaseline.alphabetic,
                                        ),
                                      ),
                                    ])),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     Get.toNamed("/energy");
                                    //   },
                                    //   child: Container(
                                    //     width: 90.w,
                                    //     height: 40.w,
                                    //     alignment: Alignment.center,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20.w),
                                    //         gradient: const RadialGradient(
                                    //             radius: 0.8,
                                    //             colors: [
                                    //               Color.fromRGBO(
                                    //                   255, 236, 192, 1),
                                    //               Colors.white,
                                    //             ])),
                                    //     child: Text(
                                    //       "Buy",
                                    //       style: TextStyle(
                                    //         color: primaryColor,
                                    //         fontSize: 24.sp,
                                    //         fontWeight: FontWeight.bold,
                                    //         fontFamily:
                                    //             FontFamily.SFProRoundedBlod,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 33.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed('/energy');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 48.w,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Stack(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.w),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/icons/shop.png",
                                                width: 24.w,
                                                height: 24.w,
                                              ),
                                              Expanded(
                                                  child: Center(
                                                child: Text(
                                                  "Buy",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontFamily: FontFamily
                                                        .SFProRoundedSemibold,
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        ColorFiltered(
                                          colorFilter: const ColorFilter.mode(
                                              Colors.white, BlendMode.srcOut),
                                          child: ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                                sigmaX: 16,
                                                sigmaY: 16,
                                                tileMode: TileMode.decal),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  logic.share();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 48.w,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Stack(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.w),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/icons/plane.png",
                                                width: 24.w,
                                                height: 24.w,
                                              ),
                                              Expanded(
                                                  child: Center(
                                                child: Text(
                                                  "Share",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontFamily: FontFamily
                                                        .SFProRoundedSemibold,
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              Colors.white, BlendMode.srcOut),
                                          child: ImageFiltered(
                                            imageFilter: ImageFilter.blur(
                                                sigmaX: 16,
                                                sigmaY: 16,
                                                tileMode: TileMode.decal),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Get.toNamed("/giftBackpack");
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Your gift backpack",
                                  style: TextStyle(
                                      color: Color.fromRGBO(148, 74, 0, 1),
                                      fontSize: 16.sp),
                                ),
                                Image.asset(
                                  "assets/images/icons/right_arrow_orange.png",
                                  width: 20.w,
                                  height: 20.w,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        MineCardItem(
                            onTap: () {
                              Get.toNamed("/chatSettings");
                            },
                            text: "Chat settings",
                            iconSrc: "assets/images/icons/settings.png"),
                        Container(
                          height: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                        ),
                        MineCardItem(
                            onTap: () {
                              Get.toNamed("/minePurchaseHistory");
                            },
                            text: "Purchase history",
                            iconSrc: "assets/images/icons/bag.png"),
                        Container(
                          height: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                        ),
                        MineCardItem(
                            onTap: () {
                              LaunchReview.launch(
                                  androidAppId: "cn.soulmate.elf",
                                  iOSAppId: "6473983973");
                            },
                            text: "Please give us a 5 star rating",
                            iconSrc: "assets/images/icons/mineLike.png"),
                        Container(
                          height: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                        ),
                        MineCardItem(
                            onTap: () {
                              Get.toNamed("/about");
                            },
                            text: "About",
                            iconSrc: "assets/images/icons/small.png"),
                        Container(
                          height: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                        ),
                        Container(
                          height: 98.w,
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/icons/user.png",
                                width: 26.w,
                                height: 26.w,
                              ),
                              SizedBox(
                                width: 19.w,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Emergency contact",
                                        style: TextStyle(
                                            color: textColor, fontSize: 18.sp),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Add your emergency contact email \nlet us care about you",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.32)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 19.w,
                              ),
                              CupertinoSwitch(
                                  activeColor: primaryColor,
                                  value: logic.contact,
                                  onChanged: (c) {
                                    logic.setContact(c);
                                  }),
                            ],
                          ),
                        ),
                        Offstage(
                          offstage: !logic.contact,
                          child: Column(
                            children: [
                              Container(
                                height: 1,
                                color: Color.fromRGBO(0, 0, 0, 0.06),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/mineContactEmail");
                                },
                                child: Container(
                                  height: 64.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 19.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 26.w,
                                        height: 26.w,
                                      ),
                                      SizedBox(
                                        width: 19.w,
                                      ),
                                      Text(
                                        "Email",
                                        style: TextStyle(
                                            color: textColor, fontSize: 18.sp),
                                      ),
                                      SizedBox(
                                        width: 19.w,
                                      ),
                                      Expanded(
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            child: logic.user?.emergencyEmail !=
                                                    null
                                                ? Text(
                                                    "${logic.user?.emergencyEmail}",
                                                    style: TextStyle(
                                                        color:
                                                            const Color.fromRGBO(
                                                                0, 0, 0, 0.48),
                                                        fontSize: 18.sp))
                                                : Text("To be perfected",
                                                    style: TextStyle(
                                                        color:
                                                            const Color.fromRGBO(
                                                                255, 90, 90, 1),
                                                        fontSize: 18.sp))),
                                      ),
                                      SizedBox(
                                        width: 19.w,
                                      ),
                                      Image.asset(
                                        "assets/images/icons/right_arrow.png",
                                        width: 26.w,
                                        height: 26.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 64.w,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.w))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: logic.logout,
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.SFProRoundedBlod,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 24.w,
                  ),
                ],
              ),
            ),
          ))
        ],
      );
    }));
  }

  Widget MineCardItem({
    required Function onTap,
    required String text,
    required String iconSrc,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 64.w,
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        child: Row(
          children: [
            Image.asset(
              iconSrc,
              width: 26.w,
              height: 26.w,
            ),
            SizedBox(
              width: 19.w,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontSize: 18.sp),
              ),
            ),
            SizedBox(
              width: 19.w,
            ),
            Image.asset(
              "assets/images/icons/right_arrow.png",
              width: 26.w,
              height: 26.w,
            ),
          ],
        ),
      ),
    );
  }
}
