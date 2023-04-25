/*
 * @Date: 2023-04-13 10:43:55
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-20 11:29:29
 * @FilePath: \soulmate\lib\views\main\discount\view.dart
 */
import 'dart:ffi';

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
  var _cardList = [];

  getData() async {
    final userInfo = Application.userInfo;
    if (userInfo == null) return;
    final result = await NetUtils.diorequst("/base/getCoupon", 'get');

    if (result.data?["code"] == 200) {
      final data = result.data["data"]["data"];
      if (data != null) {
        setState(() {
          _cardList = data;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  List<Widget> renderCardList() {
    final List<Widget> widgets = [];
    _cardList.forEach((card) {
      final text = card["discount"];
      final money = int.parse(text).toStringAsFixed(2);
      widgets.add(DiscountCard(
        used: card['state'] == 1,
        child: Text(
          "\$ ${money}",
          style: TextStyle(fontSize: 36.sp, color: Colors.white),
        ),
      ));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("discount voucher",
        child: Container(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
              child: Column(
            children: renderCardList(),
          )),
        ));
  }
}
