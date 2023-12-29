import 'dart:async';

import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AppPurchase {
  ///订单信息订阅
  static late StreamSubscription<dynamic> _subscription;

  ///订单业务回调
  static Function? orderCallback;


  ///初始化支付订单状态订阅
  static initAppPayConfig() async {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
  }

  ///支付状态逻辑处理
  static void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) {
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
        } else if (purchaseDetails.status == PurchaseStatus.restored) {
          ///恢复购买
          // print(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          ///这个方法是为了应对购买成功后，app崩溃了，重新打开app，此时需要通知IAP平台，已经完成了购买流程
          InAppPurchase.instance.completePurchase(purchaseDetails);
        }
        // APPPlugin.logger.d(purchaseDetails.status);
        ///调用回调的后台接口，通知后台购买成功或者失败
        if (orderCallback != null) {
          orderCallback!(purchaseDetails);
        }
      }
    });
  }

  ///获取ios和android商店里面配置的商品列表
  static Future<List<ProductDetails>> getServerProducts(
      Set<String> pIds) async {
    ///根据商品id获取云端商品列表
    try{
      final bool isAvailable = await InAppPurchase.instance.isAvailable();
      if (!isAvailable) {
        return [];
      }
      final ProductDetailsResponse response =
      await InAppPurchase.instance.queryProductDetails(pIds);
      if (response.notFoundIDs.isNotEmpty) {
        return [];
      }
      return response.productDetails;
    }catch(err){
      print(err);
    }
    return [];
  }

  ///购买商品 type 1:购买 2:订阅
  static payProductNow(ProductDetails productDetails,int type, String orderId) {
    if (productDetails == null) {
      exSnackBar("please check you product", type: ExSnackBarType.warning);
      return;
    }
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails,applicationUserName: orderId);
    // 消耗型商品(一次性购买)和非消耗型商品(月度订阅，年度订阅)的购买是不一样的
    if (type == 1) {
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    } else {
      InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  ///恢复购买
  ///消耗型项目，非消耗型，自动续期订阅，非续期订阅
  ///恢复购买是恢复非消耗型的商品或者自动续期订阅这两种类型
  ///这个需要提供一个手动按钮恢复，不然上架不给过哦
  static restorePuchases() async {
    await InAppPurchase.instance.restorePurchases();
  }

  ///取消支付订阅
  static disposeSubscription() {
    _subscription.cancel();
  }
}
