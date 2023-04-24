/*
 * @Date: 2023-04-23 19:37:53
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-24 10:26:16
 * @FilePath: \soulmate\lib\views\main\customRole\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';

class CustomRole extends StatefulWidget {
  var checkedIndex = 0;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomRole();
  }
}

class _CustomRole extends State<CustomRole> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Custom role",
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  widget.checkedIndex = (widget.checkedIndex + 1) % 3;
                });
              },
              child: Text("Next"))
        ],
        child: Container(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24.w),
                      child: Text(
                        "Some question(1/3)",
                        style: TextStyle(fontSize: 36.sp),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
