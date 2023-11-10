/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class GiftBackpackPage extends StatelessWidget {
  final logic = Get.put(GiftBackpackController());

  @override
  Widget build(BuildContext context) {
    return basePage('Gift backpack',
        backGroundImage: null,
        backgroundColor: Color.fromARGB(1, 242, 242, 242),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: GetBuilder<GiftBackpackController>(
                  builder: (controller) {
                    return CupertinoSlidingSegmentedControl<GiftTabKey>(
                        groupValue: controller.tabKey,
                        padding: EdgeInsets.all(4.w),
                        children: {
                          GiftTabKey.energy: Container(
                            height: 44.w,
                            alignment: Alignment.center,
                            child: Text(
                              "Energy card",
                              style: TextStyle(
                                fontFamily: FontFamily.SFProRoundedBlod,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: controller.tabKey != GiftTabKey.energy
                                    ? Colors.black45
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          GiftTabKey.rechargeable: Container(
                            height: 44.w,
                            alignment: Alignment.center,
                            child: Text(
                              "Rechargeable card",
                              style: TextStyle(
                                fontFamily: FontFamily.SFProRoundedBlod,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color:
                                    controller.tabKey != GiftTabKey.rechargeable
                                        ? Colors.black45
                                        : Colors.black87,
                              ),
                            ),
                          ),
                        },
                        onValueChanged: (value) {
                          controller.tabKey = value!;
                        });
                  },
                ),
              ),
              SizedBox(
                height: 16.w,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: GetBuilder<GiftBackpackController>(
                      builder: (controller) {
                        return Column(
                          children: controller.tabKey == GiftTabKey.energy
                              ? renderEnergyCardList(controller.tabKey)
                              : renderRechargeCardList(controller.tabKey),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> renderEnergyCardList(GiftTabKey tabKey) {
    List<Widget> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(Container(
        margin: EdgeInsets.only(bottom: 8.w),
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2023-06-08 23:59 Obtained",
              style: TextStyle(
                fontSize: 13.sp,
                color: Color.fromRGBO(0, 0, 0, 0.48),
              ),
            ),
            SizedBox(
              height: 16.w,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/icons/giftEnergyIcon.png",
                  width: 32.w,
                  height: 32.w,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Expanded(
                  child: Text(
                    "Star energy",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 7.w,
                ),
                Text(
                  "+ 20",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20.sp,
                    fontFamily: FontFamily.SFProRoundedBlod,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ));
    }
    return list;
  }

  List<Widget> renderRechargeCardList(GiftTabKey tabKey) {
    List<Widget> list = [];
    list.add(Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 16.w),
      child: Text(
        "Double the energy used when purchasing star energy",
        style: TextStyle(
          fontSize: 14.sp,
          color: Color.fromRGBO(0, 0, 0, 0.48),
        ),
      ),
    ));
    for (int i = 0; i < 10; i++) {
      list.add(Container(
        margin: EdgeInsets.only(bottom: 8.w),
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2023-06-08 23:59 expire",
              style: TextStyle(
                fontSize: 13.sp,
                color: Color.fromRGBO(0, 0, 0, 0.48),
              ),
            ),
            SizedBox(
              height: 16.w,
            ),
            Row(
              children: [
                Image.asset(
                  true
                      ? "assets/images/icons/giftRechargeIcon.png"
                      : "assets/images/icons/giftRechargeDisabledIcon.png",
                  width: 32.w,
                  height: 32.w,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Expanded(
                  child: Text(
                    "Doubling of energy",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 7.w,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(width: 2.w, color: primaryColor),
                      color: Color.fromRGBO(255, 128, 0, 0.16),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 11.w, vertical: 4.w),
                    child: Text(
                      "To use",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16.sp,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Text(
                //   "Used",
                //   style: TextStyle(
                //     color: Color.fromRGBO(0, 0, 0, 0.48),
                //     fontSize: 16.sp,
                //     fontFamily: FontFamily.SFProRoundedBlod,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            )
          ],
        ),
      ));
    }
    return list;
  }
}
