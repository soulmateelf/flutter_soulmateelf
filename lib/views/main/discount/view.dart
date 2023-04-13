/*
 * @Date: 2023-04-13 10:43:55
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-13 14:17:06
 * @FilePath: \soulmate\lib\views\main\discount\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/discountCard/view.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';

class DiscountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("discount voucher",
        child: Container(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
              child: Column(
            children: [
              DiscountCard(
                used: false,
                child: Text(
                  "\$ 2.00",
                  style: TextStyle(fontSize: 36.sp, color: Colors.white),
                ),
              ),
              DiscountCard(
                used: false,
                child: Text(
                  "\$ 2.00",
                  style: TextStyle(fontSize: 36.sp, color: Colors.white),
                ),
              ),
              DiscountCard(
                used: true,
                child: Text(
                  "\$ 2.00",
                  style: TextStyle(fontSize: 36.sp, color: Colors.white),
                ),
              )
            ],
          )),
        ));
  }
}
