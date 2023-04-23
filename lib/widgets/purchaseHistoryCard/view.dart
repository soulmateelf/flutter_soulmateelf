/*
 * @Date: 2023-04-13 14:25:53
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-23 16:21:29
 * @FilePath: \soulmate\lib\widgets\purchaseHistoryCard\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:moment_dart/moment_dart.dart';

class PurchaseHistoryCard extends StatelessWidget {
  var history = null;

  PurchaseHistoryCard({required this.history});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final time =
        Moment(DateTime.fromMillisecondsSinceEpoch(history?["createTime"]));

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
                "${history?["id"]}",
                style: TextStyle(
                  fontSize: 28.sp,
                ),
              ),
              Text(
                "\$ ${history?["orderPrice"]}",
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
                  Image.asset(
                    "assets/images/icons/flash.png",
                    width: 22.w,
                    height: 22.w,
                  ),
                  Text(
                    "${history?["amout"] ?? "0"}",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: const Color.fromRGBO(102, 102, 102, 1)),
                  )
                ],
              ),
              Text(
                "${time}",
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
