import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class TestPay extends GetxController {
  late StreamSubscription<dynamic> _subscription;
  List<ProductDetails> products = [];
  @override
  void onInit() {
    super.onInit();
    //初始化订单状态订阅
    initConfig();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  initConfig() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    print('purchaseDetailsList:${purchaseDetailsList.length}}');
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        //购买进行中，展示加载框
        Loading.show();
      } else {
        Loading.dismiss();
        if (purchaseDetails.status == PurchaseStatus.error) {
          //购买失败，展示失败信息
          exSnackBar(purchaseDetails.error!.message,
              type: ExSnackBarType.error);
          print('购买进行中');
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          //购买成功，展示成功信息
          print('购买成功或者restored是什么？？');
          print(purchaseDetails.status);
          print('purchaseID：${purchaseDetails.purchaseID}');
          print('purchaseID：${purchaseDetails.productID}');
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   _deliverProduct(purchaseDetails);
          // } else {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
          //这一段是干啥的！！！！
        }
        if (purchaseDetails.pendingCompletePurchase) {
          //通知IAP平台，已经完成了购买，不管成功还是失败都是结束
          await InAppPurchase.instance.completePurchase(purchaseDetails);
          print('pendingCompletePurchase');
        }
      }
    });
  }

  showProducts() async {
    // final ProductDetailsResponse response =
    const Set<String> _kIds = <String>{
      'test2',
      'soumatedongan',
      'littlecake',
      'abc'
    };
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }
    products = response.productDetails;
    products.forEach((element) {
      // print(jsonEncode(element));
    });
  }

  payNow() {
    final ProductDetails productDetails =
        products[0]; // Saved earlier from queryProductDetails().
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  restorePurchases() async {
    print('恢复购买记录');
    await InAppPurchase.instance.restorePurchases();
  }
}
