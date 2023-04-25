/*
 * @Date: 2023-04-13 14:21:37
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-20 18:15:29
 * @FilePath: \soulmate\lib\views\main\purchaseHistory\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/widgets/purchaseHistoryCard/view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'logic.dart';
import 'package:get/get.dart';

class PurchaseHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PurchaseHistoryPage();
  }
}

class _PurchaseHistoryPage extends State<PurchaseHistoryPage> {

  final logic = Get.put(PurchaseHistoryLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<PurchaseHistoryLogic>(builder: (logic) {
      return basePage("Purchase history",
        child: Container(
          child: _refreshListView
        ));});
  }

  /// 上下拉列表
  Widget get _refreshListView => SmartRefresher(
      enablePullDown: true,
      enablePullUp: logic.refreshController.footerMode?.value != LoadStatus.noMore,
      controller: logic.refreshController,
      onRefresh: logic.onRefresh,
      onLoading: logic.onLoading,
      child: ListView.builder(
          itemCount: logic.orderList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {},
                child: PurchaseHistoryCard(history: logic.orderList[index]));
          }));
}
