/*
 * @Date: 2023-04-13 14:21:37
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-13 14:35:32
 * @FilePath: \soulmate\lib\views\main\purchaseHistory\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/widgets/purchaseHistoryCard/view.dart';

class PurchaseHistoryPage extends StatelessWidget {
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
