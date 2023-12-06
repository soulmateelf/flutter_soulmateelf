import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';

import 'controller.dart';

class MinePurchaseHistoryPage extends StatelessWidget {
  MinePurchaseHistoryPage({super.key});

  final logic = Get.put(MinePurchaseHistoryController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MinePurchaseHistoryController>(
      builder: (controller) {
        return basePage("Purchase history",
            backGroundImage: null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
              child: SmartRefresher(
                controller: controller.refreshController,
                onLoading: () {
                  logic.getOrderList("loadMore");
                },
                onRefresh: () {
                  logic.getOrderList("refresh");
                },
                child: Column(
                  children: renderPurchaseList(),
                ),
              ),
            ));
      },
    );
  }

  List<Widget> renderPurchaseList() {
    List<Widget> list = [];
    logic.orderList.forEach((order) {
      list.add(Container(
        margin: EdgeInsets.only(bottom: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160.w,
                  child: Text(
                    order.orderId,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Color.fromRGBO(0, 0, 0, 0.48),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Text(
                  "${DateTime.fromMillisecondsSinceEpoch(order.createTime).format(payload: "MMMM DD, YYYY [at] HH:mm")}",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.48),
                    fontSize: 13.sp,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Icon(
                        Icons.flash_on_sharp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "${order.productInfo.energy}",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20.sp,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text:
                        "${order.productInfo.amount != order.orderAmount ? "" : "\$ ${order.productInfo.amount}"}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      decoration: TextDecoration.lineThrough,
                      color: Color.fromRGBO(0, 0, 0, 0.48),
                    ),
                  ),
                  WidgetSpan(
                      child: SizedBox(
                    width: 8.w,
                  )),
                  TextSpan(
                      text: "\$ ${order.orderAmount}",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.SFProRoundedBlod,
                      ))
                ]))
              ],
            ),
          ],
        ),
      ));
    });

    return list;
  }
}
