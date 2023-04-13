/*
 * @Date: 2023-04-13 10:47:18
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-13 14:17:26
 * @FilePath: \soulmate\lib\widgets\discountCard\view.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountCard extends StatelessWidget {
  Widget? prefixIcon;

  ///cupertino
  Widget? child;
  bool used = false;
  DiscountCard({
    super.key,
    Widget? child,
    Widget? prefixIcon = const Icon(
      CupertinoIcons.ticket_fill,
      color: Color.fromARGB(255, 255, 154, 59),
    ),
    required bool used,
  }) {
    this.child = child;
    this.prefixIcon = prefixIcon;
    this.used = used;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 128.w,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      margin: EdgeInsets.only(top: 10.w),
      decoration: BoxDecoration(
        color: used
            ? Color.fromRGBO(204, 204, 204, 1)
            : Color.fromRGBO(78, 162, 79, 1),
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.w), color: Colors.white),
            child: Center(
              child: prefixIcon,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: child,
          )),
          OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  foregroundColor: const Color.fromRGBO(204, 204, 204, 1)),
              child: Text(
                used ? "Used" : "To use",
                style: TextStyle(color: Colors.white, fontSize: 22.sp),
              ))
        ],
      ),
    );
  }
}
