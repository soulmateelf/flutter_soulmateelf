/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-26 15:47:05
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

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../utils/core/httputil.dart';
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
    super.initState();
  }

  void toRecharge() async {
    await Get.toNamed('/recharge',
        arguments: {"checkedRoleId": logic.checkedRoleId});
    logic.getRoleList();
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
    return GetBuilder<HomeLogic>(builder: (logic) {
      return WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value();
          return logic.dealBack();
        },
        child: basePage("home",
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
                                color: Colors.white30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.w)),
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
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    logic.updateRoleName(context);
                                                  },
                                                  child: logic.checkedRole?[
                                                              "share"] ==
                                                          1
                                                      ? Image.asset(
                                                          "assets/images/icons/edit2.png")
                                                      : Image.asset(
                                                          "assets/images/icons/edit.png"),
                                                )),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 8.w),
                                                width: 36.w,
                                                height: 36.w,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Utils.share(
                                                      "https://icyberelf.com",
                                                      "assets/images/icons/avatar.png",
                                                      successCallBack:
                                                          logic.shareCallBack,
                                                    );
                                                  },
                                                  child: Image.asset(
                                                      "assets/images/icons/share2.png"),
                                                ))
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
                              percent: min(
                                  (logic.checkedRole?['amout'] ?? 0) /
                                      (logic.checkedRole?["baseAmout"] ?? 100),
                                  1),
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
    /// roleType 1 为普通角色 2 为用户自定义角色 3 为可点击定制的假角色
    if (logic.checkedRole["roleType"] == 3) {
      text = "Character customization";
      onPressed = () async {
        Get.toNamed('/customRole');
      };
    } else {
      if ((logic.checkedRole["amout"] ?? 0) <= 0) {
        text = "Pay for me";
        onPressed = () async {
          toRecharge();
        };
      } else {
        text = "Chat now";
        onPressed = () async {
          await Get.toNamed('/chat',
              arguments: {"roleId": logic.checkedRole["id"]});
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
