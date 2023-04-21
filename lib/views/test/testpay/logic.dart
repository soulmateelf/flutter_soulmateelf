import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


class TestPay extends GetxController {

  @override
  void onInit() {
    super.onInit();
    //初始化订单状态订阅
    initConfig();
  }
  initConfig(){

  }
  showProducts() async {
    // final ProductDetailsResponse response =
    const Set<String> _kIds = <String>{'test2', 'soumatedongan','littlecake','abc'};
    final ProductDetailsResponse response = await InAppPurchase.instance
        .queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }
    List<ProductDetails> products = response.productDetails;
    products.forEach((element) {
      // print(jsonEncode(element));
      APPPlugin.logger.i({'id':element.id,'title':element.title,'description':element.description,'price':element.price,'currencyCode':element.currencyCode,'rawPrice':element.rawPrice,'currencySymbol':element.currencySymbol});
    });
  }
}