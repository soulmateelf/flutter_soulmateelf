/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:37:56
 * @FilePath: \soulmate\lib\views\main\home\view.dart
 */
////////////////////////
///Author: guohl
///Date: 2022-02-08 09:30:30
///LastEditors: guohl
///LastEditTime: 2022-02-09 15:40:33
///Description:
////////////////////////
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'logic.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  final logic = Get.put(HomeLogic());

  @override
  void initState() {
    // TODO: implement initState
    print(logic);
    super.initState();
  }

  void toRecharge() async {
    await Get.toNamed('/recharge',
        arguments: {"checkedRoleId": logic.checkedRoleId});
    update();
  }

  update() {
    setState(() {});
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));

    return GetBuilder<HomeLogic>(builder: (logic) {
      return WillPopScope(
        child: basePage("homer",
            backgroundColor: Colors.transparent,
            showAppBar: false,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
                      color: Color.fromRGBO(232, 232, 223, 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.w),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(10.w)),
                                    child: Container(
                                      height: 448.w,
                                      width: 280.w,
                                      child: logic.checkedRole?["images"] !=
                                              null
                                          ? Image.network(
                                              logic.checkedRole["images"],
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                APPPlugin.logger.e('error');
                                                return Text(" ");
                                              },
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.w),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(20.w),
                                  height: 448.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 42.w,
                                        child: Row(
                                          children: renderStars(
                                              role: logic.checkedRole),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 24.w),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                logic.checkedRole?[
                                                        "roleName"] ??
                                                    "Soulmate ELF",
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                  fontSize: 36.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 36.w,
                                              height: 36.w,
                                              child: Image.asset(
                                                  "assets/images/icons/edit2.png"),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 8.w),
                                              width: 36.w,
                                              height: 36.w,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.toNamed('/testPay');
                                                },
                                                child: Image.asset(
                                                    "assets/images/icons/share2.png"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 24.w),
                                        child: Text(
                                            "Age：${logic.checkedRole?["age"].toString() ?? "unknown"}"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 24.w),
                                        // ignore: prefer_interpolation_to_compose_strings
                                        child: Text("Gender：" +
                                            (logic.checkedRole?["gender"] ??
                                                "unknown")),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(top: 24.w),
                                        child: Text(logic.checkedRole?[
                                                "roleIntroduction"] ??
                                            ""),
                                      )),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      height: 40.w,
                                      child: Image.asset(
                                          "assets/images/icons/flash.png"),
                                    ),
                                    Text(
                                      (logic.checkedRole?["amout"] ?? 0)
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 36.sp,
                                          color:
                                              Color.fromRGBO(78, 162, 79, 1)),
                                    ),
                                    Text(
                                      "/${logic.checkedRole?["baseAmout"] ?? 100}",
                                      style: TextStyle(
                                          fontSize: 26.sp,
                                          color: Color.fromRGBO(
                                              102, 102, 102, 100)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40.w,
                                  height: 40.w,
                                  child: InkWell(
                                    onTap: () {
                                      toRecharge();
                                    },
                                    child: Image.asset(
                                        "assets/images/icons/add.png"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15.w),
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.w),
                                color: const Color.fromRGBO(78, 162, 79, 1)),
                            child: LinearPercentIndicator(
                              percent: (logic.checkedRole?['amout'] ?? 0) / 100,
                              padding: EdgeInsets.zero,
                              progressColor:
                                  const Color.fromRGBO(78, 162, 79, 1),
                              lineHeight: 16.w,
                              barRadius: Radius.circular(15.w),
                              backgroundColor:
                                  const Color.fromRGBO(230, 239, 226, 1),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 34.w),
                              padding: EdgeInsets.only(bottom: 20.w),
                              height: 185.w,
                              child: SingleChildScrollView(
                                child: Text(
                                    logic.checkedRole?["characterBackGround"] ??
                                        ""),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                            padding: EdgeInsets.all(20.w),
                            child: Wrap(
                              runSpacing: 16.w,
                              spacing: 16.w,
                              children: renderRoleList(),
                            ),
                          )),
                          Container(
                            height: 84.w,
                            width: double.infinity,
                            child: renderFloatButton(),
                          ),
                        ],
                      ),
                    ))
                  ],
                ))),
        onWillPop: () {
          return logic.dealBack();
        },
      );
    });
  }

  List<Widget> renderStars({required role, double? size}) {
    List<Widget> widgets = [];
    final startCount = role?["roleStar"] ?? 0;
    for (int i = 0; i < startCount; i++) {
      widgets.add(Icon(
        Icons.star,
        color: Colors.yellow,
        size: size != null ? size.sp : null,
      ));
    }
    return widgets;
  }

  List<Widget> renderRoleList() {
    List<Widget> widgets = [];
    logic.roleList.forEach((role) {
      var amout = role["amout"] ?? 0;
      var images = role["images"];
      widgets.add(InkWell(
        onTap: () {
          // Get.toNamed('/settings');
          logic.checkedRoleId = role["id"];
        },
        child: Container(
          width: 220.w,
          height: 220.w,
          decoration: BoxDecoration(
              border: Border.all(
            color: logic.checkedRoleId == role["id"]
                ? Colors.green
                : Colors.transparent,
            width: 8.w,
          )),
          child: Stack(children: [
            Center(
              child: images != null
                  ? Image.network(
                      images,
                      width: 220.w,
                      height: 220.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Text("error");
                      },
                    )
                  : Image.asset("assets/images/icons/avatar.png"),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Row(
                children: [
                  SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: Image.asset("assets/images/icons/flash.png"),
                  ),
                  Text(
                    "${amout}",
                    style: TextStyle(
                        color: amout <= 0 ? Colors.red : Colors.green,
                        fontSize: 22.sp),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: renderStars(role: role, size: 38),
                ),
              ),
            )
          ]),
        ),
      ));
    });
    return widgets;
  }

  Widget? renderFloatButton() {
    if (logic.checkedRole == null) {
      return null;
    }
    var text = "";
    var onPressed = () async {};
    if (logic.checkedRole["roleType"] == 3) {
      text = "Character customization";
    } else {
      if ((logic.checkedRole["amout"] ?? 0) <= 0) {
        text = "Pay for me";
        onPressed = () async {
          toRecharge();
        };
      } else {
        text = "Chat now";
        onPressed = () async {
          await Get.toNamed('/chat');
          logic.getRoleList();
        };
      }
    }

    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
      child: Text(
        text,
        style: TextStyle(fontSize: 36.sp),
      ),
      onPressed: () {
        // Get.toNamed('/chat');
        onPressed();
        // Get.toNamed('/textToSpeech');
      },
    );
  }
}
