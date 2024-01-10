import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/order.dart';
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
                enablePullUp: true,
                controller: controller.refreshController,
                onLoading: () {
                  logic.getOrderList("loadMore");
                },
                onRefresh: () {
                  logic.getOrderList("refresh");
                },
                child: listViewNoDataPage(
                  isShowNoData: logic.orderList.isEmpty,
                  omit: 'No order yet',
                  child: SingleChildScrollView(
                    child: Column(
                      children: renderPurchaseList(),
                ),
                  )),
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
                      color: const Color.fromRGBO(0, 0, 0, 0.48),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(order.createTime).format(payload: "MMMM DD, YYYY [at] HH:mm"),
                  style: TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 0.48),
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
                      child: Image.asset(
                        order.type==2?"assets/images/icons/orderRoleIcon.png":"assets/images/icons/orderEnergyIcon.png",
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      order.type==2?"Add your ELF":"${order.productEnergy}",
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
                    text: TextSpan(
                        children: [
                          showOrderStatus(order),
                          WidgetSpan(
                              child: SizedBox(
                                  height: 20.w,
                                  child: Text(
                                    order.productType == 1 ? "\$ ${order.productAmount}" : "",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      decoration: TextDecoration.lineThrough,
                                      color: const Color.fromRGBO(0, 0, 0, 0.48),
                                    ),
                                  )
                              )
                          ),
                          WidgetSpan(
                              child: SizedBox(
                            width: 8.w,
                          )),
                          WidgetSpan(
                              child: SizedBox(
                                height: 26.w,
                                  child: Text(
                                    "\$ ${order.orderAmount}",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.SFProRoundedBlod,
                                    ),
                                  )
                              )
                          ),
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

/// 展示订单状态
InlineSpan showOrderStatus(Order order) {
  String text = "";
  Color textColor = const Color.fromRGBO(0, 0, 0, 0.48);
  Color backgroundColor = const Color.fromRGBO(239, 239, 239, 1);
  Color borderColor = const Color.fromRGBO(0, 0, 0, 0.06);
  switch (order.result) {
    case '0':
      text = "Pending";
      textColor = const Color.fromRGBO(0, 0, 0, 0.48);
      backgroundColor = const Color.fromRGBO(239, 239, 239, 1);
      borderColor = const Color.fromRGBO(0, 0, 0, 0.06);
      break;
    case '1':
      text = "Success";
      textColor = const Color.fromRGBO(255, 128, 0, 1);
      backgroundColor = const Color.fromRGBO(255, 128, 0, 0.16);
      borderColor = const Color.fromRGBO(255, 128, 0, 0.26);
      break;
    case '2':
      text = "Failure";
      textColor = const Color.fromRGBO(255, 90, 90, 1);
      backgroundColor = const Color.fromRGBO(255, 90, 90, 0.06);
      borderColor = const Color.fromRGBO(255, 90, 90, 0.16);
      break;
    case '3':
      text = "Cancel";
      textColor = const Color.fromRGBO(0, 0, 0, 0.48);
      backgroundColor = const Color.fromRGBO(239, 239, 239, 1);
      borderColor = const Color.fromRGBO(0, 0, 0, 0.06);
      break;
    default:
      text = "Pending";
      textColor = const Color.fromRGBO(0, 0, 0, 0.48);
      backgroundColor = const Color.fromRGBO(239, 239, 239, 1);
      borderColor = const Color.fromRGBO(0, 0, 0, 0.06);
      break;
  }
  InlineSpan widget = WidgetSpan(
      child: Container(
          margin: EdgeInsets.only(right: 12.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(20.w)),
            border: Border.all(
              color: borderColor,
              width: 2.w,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 13.sp,
            ),
          )
      )
  );
  return widget;
}
