/*
 * @Date: 2023-04-13 14:21:37
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-20 18:15:29
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
  var _historyList = [];

  getData() async {
    final userInfo = Application.userInfo;
    if (userInfo == null) return;
    final result =
        await NetUtils.diorequst("/base/orderHistory", 'post', params: {
      "userId": userInfo["userId"],
      "pageNum": 1,
      "pageSize": 10,
    });
    if (result.data?['code'] == 200) {
      final data = result.data['data']?['data'];
      if (data != null) {
        setState(() {
          _historyList = data;
        });
      }
    }
    APPPlugin.logger.d(result.data);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  List<Widget> renderHistoryList() {
    List<Widget> widgets = [];
    _historyList.forEach((history) {
      widgets.add(PurchaseHistoryCard(
        history: history,
      ));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Purchase history",
        child: SingleChildScrollView(
          child: Column(
            children: renderHistoryList(),
          ),
        ));
  }
}
