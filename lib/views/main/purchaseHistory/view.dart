/*
 * @Date: 2023-04-13 14:21:37
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-19 10:21:46
 * @FilePath: \soulmate\lib\views\main\purchaseHistory\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/widgets/purchaseHistoryCard/view.dart';

import '../../../utils/core/application.dart';
import '../../../utils/core/httputil.dart';
import '../../../utils/plugin/plugin.dart';

class PurchaseHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PurchaseHistoryPage();
  }
}

class _PurchaseHistoryPage extends State<PurchaseHistoryPage> {
  getData() async {
    final userInfo = Application.userInfo;
    if (userInfo == null) return;
    final result =
        await NetUtils.diorequst("/base/orderHistory", 'get', params: {
      "userId": userInfo["userId"],
      "pageNum": 1,
      "pageSize": 10,
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
    return basePage("Purchase history",
        child: SingleChildScrollView(
          child: Column(
            children: [
              PurchaseHistoryCard(),
              PurchaseHistoryCard(),
              PurchaseHistoryCard(),
              PurchaseHistoryCard(),
            ],
          ),
        ));
  }
}
