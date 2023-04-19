/*
 * @Date: 2023-04-13 10:43:55
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-18 19:33:44
 * @FilePath: \soulmate\lib\views\main\discount\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/discountCard/view.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';

class DiscountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DiscountPage();
  }
}

class _DiscountPage extends State<DiscountPage> {
  getData() async {
    final userInfo = Application.userInfo;
    if (userInfo == null) return;
    final result = await NetUtils.diorequst("/base/getCoupon", 'get', params: {
      "userId": userInfo["userId"],
    });

    APPPlugin.logger.d(result);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

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
