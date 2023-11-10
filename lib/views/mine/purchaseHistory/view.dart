import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';

import 'controller.dart';

class MinePurchaseHistoryPage extends StatelessWidget {
  MinePurchaseHistoryPage({super.key});

  final logic = Get.put(MinePurchaseHistoryController());

  @override
  Widget build(BuildContext context) {
    return basePage("Purchase history",
        backGroundImage: null,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...renderPurchaseList(),
              ],
            ),
          ),
        ));
  }

  List<Widget> renderPurchaseList() {
    List<Widget> list = [];

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
              Text(
                "20220506002112325",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.48),
                  fontSize: 13.sp,
                ),
              ),
              Text(
                "March 22, 2023 at 12:23",
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
                    "50",
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
                  text: "\$ 5.99",
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
                    text: "\$ 2.99",
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

    return list;
  }
}
