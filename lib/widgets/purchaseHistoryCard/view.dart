/*
 * @Date: 2023-04-13 14:25:53
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-13 14:34:31
 * @FilePath: \soulmate\lib\widgets\purchaseHistoryCard\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseHistoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      color: Colors.white,
      height: 126.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "49684684645641654",
                style: TextStyle(
                  fontSize: 28.sp,
                ),
              ),
              Text(
                "\$ 4.99",
                style: TextStyle(
                  fontSize: 28.sp,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.flash_on,
                    color: Colors.orange,
                  ),
                  Text(
                    "50",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: const Color.fromRGBO(102, 102, 102, 1)),
                  )
                ],
              ),
              Text(
                "March 22, 2023 at 12:23",
                style: TextStyle(
                    fontSize: 22.sp,
                    color: const Color.fromRGBO(102, 102, 102, 1)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
