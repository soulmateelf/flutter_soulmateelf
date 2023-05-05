
import 'dart:async';

import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IOSAppPurchase {
  ///ios订单信息订阅
  static late StreamSubscription<dynamic> _subscription;
  ///订单业务回调
  static Function? orderCallback;

  ///初始化ios支付订单状态订阅
  static initApplePayConfig() async {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
  }

  ///applePay支付状态逻辑处理
  static void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        ///购买进行中，展示加载框
        Loading.show();
      } else {
        // APPPlugin.logger.d(purchaseDetails.status);
        // APPPlugin.logger.d(purchaseDetails.purchaseID);
        Loading.dismiss();
        if (purchaseDetails.status == PurchaseStatus.error) {
          ///购买失败，展示失败信息
          // Loading.error(purchaseDetails.error!.message!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          ///购买成功，展示成功信息
          // print(purchaseDetails.status);
          // print('purchaseID：${purchaseDetails.purchaseID}');
          // print('productID：${purchaseDetails.productID}');
        }
        if (purchaseDetails.pendingCompletePurchase) {
          ///这个方法是为了应对购买成功后，app崩溃了，重新打开app，此时需要通知IAP平台，已经完成了购买流程
          InAppPurchase.instance.completePurchase(purchaseDetails);
        }
        // APPPlugin.logger.d(purchaseDetails.status);
        ///调用回调的后台接口，通知后台购买成功或者失败
        if(orderCallback != null){
          orderCallback!(purchaseDetails);
        }
      }
    });
  }
  ///获取ios云端的商品列表
  static Future<List<ProductDetails>> getIOSServerProducts(Set<String> pIds) async {
    ///根据商品id获取ios云端商品列表
    final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(pIds);
    if (response.notFoundIDs.isNotEmpty) {
      Loading.error("something wrong");
      return [];
    }
    return response.productDetails;
  }

  ///购买商品
  static payProductNow(ProductDetails appleProductDetails) {
    if (appleProductDetails == null) {
      Loading.error("something wrong");
      return;
    }
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: appleProductDetails);
    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }
  ///取消支付订阅
  static disposeSubscription() {
    _subscription.cancel();
  }
}
