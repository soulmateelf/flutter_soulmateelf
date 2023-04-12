/*
 * @Date: 2023-04-12 18:45:02
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-12 18:49:02
 * @FilePath: \soulmate\lib\views\main\account\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Your account",
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.w),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text("Email")),
                      Text("Lee023@gmail.com")
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
