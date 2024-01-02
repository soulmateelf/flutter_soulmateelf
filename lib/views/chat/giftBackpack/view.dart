/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: GetBuilder<GiftBackpackController>(
                    builder: (controller) {
                      if (controller.tabKey == GiftTabKey.energy) {
                        return SmartRefresher(
                            key: ObjectKey(GiftTabKey.energy),
                            controller: logic.energyRefreshController,
                            enablePullUp: true,
                            onRefresh: () {
                              logic.getEnergyHistoryList(LoadDataType.refresh);
                            },
                            onLoading: () {
                              logic.getEnergyHistoryList(LoadDataType.loadMore);
                            },
                            child: listViewNoDataPage(
                                isShowNoData: logic.energyCardList.isEmpty,
                                omit: 'No data',
                                child: Column(
                                    children: renderEnergyCardList(
                                        controller.tabKey))));
                      }
                      return SmartRefresher(
                          key: ObjectKey(GiftTabKey.rechargeable),
                          onRefresh: () {
                            logic.getCardList(LoadDataType.refresh);
                          },
                          onLoading: () {
                            logic.getCardList(LoadDataType.loadMore);
                          },
                          controller: logic.rechargeRefreshController,
                          enablePullUp: true,
                          child: listViewNoDataPage(
                              isShowNoData: logic.rechargeableCardList.isEmpty,
                              omit: 'No data',
                              child: Column(
                                  children: renderRechargeCardList(
                                      controller.tabKey))));
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> renderEnergyCardList(GiftTabKey tabKey) {
    List<Widget> list = [];
    logic.energyCardList.forEach((energy) {
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
              "${DateTime.fromMillisecondsSinceEpoch(energy.createTime).format(payload: "YYYY-MM-DD HH:mm [Obtained]")}",
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
                  "+ ${energy.value}",
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
    });
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
    logic.rechargeableCardList.forEach((gc) {
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
              "${DateTime.fromMillisecondsSinceEpoch(gc.expiredTime).format(payload: "YYYY-MM-DD HH:mm")} expire",
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
                    "${gc.title}",
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
                gc.couponStatus == 0
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            border: Border.all(width: 2.w, color: primaryColor),
                            color: Color.fromRGBO(255, 128, 0, 0.16),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 11.w, vertical: 4.w),
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
                      )
                    : Text(
                        gc.couponStatus == 1 ? "Used" : "Expired",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.48),
                          fontSize: 16.sp,
                          fontFamily: FontFamily.SFProRoundedBlod,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            )
          ],
        ),
      ));
    });
    return list;
  }
}
