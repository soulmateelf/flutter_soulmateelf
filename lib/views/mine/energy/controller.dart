import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:soulmate/models/recharge.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/AppPurchase.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/mine/mine/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:soulmate/models/product.dart';

enum EnergyTabKey {
  vip,
  star,
}

Map<EnergyTabKey, String> energyTabMap = {
  EnergyTabKey.vip: "Subscribe",
  EnergyTabKey.star: "Star energy",
};

class EnergyController extends GetxController {
  ///tab 控制器
  late TabController tabController;

  ///商店配置的商品列表
  List<ProductDetails> storeProductList = [];

  ///服务端消耗品能量商品列表
  List<Product> energyProductList = [];

  ///服务端月度订阅商品
  Product? monthProduct;

  ///卡券列表
  List<RechargeableCard> cardList = [];

  ///当前选中的商品类型
  EnergyTabKey tabKey = EnergyTabKey.vip;

  ///当前选中的商品
  Product? currentProduct;

  ///卡券列表跳转到充值页面，带了卡券id
  String? couponId;

  ///当前选中的卡券
  RechargeableCard? currentCard;

  ///当前订单id
  String? currentOrderId;

  /// 月度订阅协议勾选
  bool isAgree = false;

  // 获取商品列表
  getProductList() {
    HttpUtils.diorequst("/product/productList",
        query: {'page': 1, 'size': 999, 'productType': '0,1'}).then((response) {
      if (response['code'] == 200) {
        List dataMap = response["data"];
        List<Product> serverDataList =
            dataMap.map((json) => Product.fromJson(json)).toList();

        ///根据服务端商品列表获取商店配置的商品列表
        if (serverDataList.isNotEmpty) getStoreProducts(serverDataList);
      }
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  // 获取充值卡券列表
  void getChargeCardList() {
    HttpUtils.diorequst('/coupon/couponList', query: {"page": 1, "size": 10})
        .then((res) {
      List<dynamic> data = res['data'] ?? [];
      cardList = data.map((e) => RechargeableCard.fromJson(e)).toList();
      if (cardList.isNotEmpty) {
        ///如果是从卡券列表跳转过来的，就选中卡券列表中的那个
        if (couponId != null) {
          currentCard = cardList.firstWhereOrNull(
              (RechargeableCard card) => card.couponId == couponId!);
        }

        ///如果找不到这张券或者不是卡券列表过来的就用第一张
        currentCard = currentCard ?? cardList.first;
      } else {
        currentCard = null;
      }
      update();
    }).catchError((err) {});
  }

  ///获取商店配置的商品列表
  getStoreProducts(List<Product> serverData) async {
    ///取出服务端商品列表中的商品id
    Set<String> pIds = <String>{};
    serverData.forEach((Product product) {
      if (!Utils.isEmpty(product.productId)) {
        pIds.add(GetPlatform.isAndroid ? product.androidId : product.iosId);
      }
    });
    ///根据商品id获取商店的商品列表
    storeProductList = await AppPurchase.getServerProducts(pIds);
    if (storeProductList.isEmpty) {
      exSnackBar("products is empty", type: ExSnackBarType.warning);
      return;
    }

    ///服务端的商品如果在ios云端没有找到，就不能购买，所以需要过滤掉
    energyProductList = serverData
        .where((Product serverProduct) =>
            storeProductList.any((ProductDetails storeProduct) {
              return (GetPlatform.isAndroid
                      ? serverProduct.androidId == storeProduct.id
                      : serverProduct.iosId == storeProduct.id) &&
                  serverProduct.type == 0;
            }))
        .toList();
    if (energyProductList.isEmpty) {
      exSnackBar("products is empty", type: ExSnackBarType.warning);
      return;
    }

    ///获取月度订阅商品
    monthProduct =
        serverData.firstWhereOrNull((Product product) => product.type == 1);

    ///默认选中第一个商品
    currentProduct = energyProductList.first;
    update();
  }

  // 创建订单
  createOrder(ProductDetails storeProductDetails, int type) async {
    Map<String, dynamic> params = {
      "orderAmount": storeProductDetails.rawPrice,
      "orderType": type, //0:购买商品 1:月度订阅 2:定制create角色
      "productId": type == 0
          ? currentProduct?.productId ?? ''
          : monthProduct?.productId ?? '',
      "paymentMethodType": GetPlatform.isIOS ? 0 : 1,
      "moneyType": storeProductDetails.currencyCode,
      "currencySymbol": storeProductDetails?.currencySymbol, //商品价格单位符号(用户当地货币符号)
      "couponId": currentCard?.couponId.toString(),
    };
    return await HttpUtils.diorequst("/order/createOrder",
            method: 'post', params: params)
        .then((response) {
      if(response['data'] == null){
        exSnackBar(response['message'],type: ExSnackBarType.warning);
      }
      if (response['code'] == 200) {
        return response['data'];
      }
      return '';
    }).catchError((error) {
      return '';
    });
  }

  ///购买商品
  payNow() async {
    ///根据服务端商品详情获取商店里面的商品详情
    String storeId = GetPlatform.isAndroid
        ? currentProduct?.androidId ?? ''
        : currentProduct?.iosId ?? '';
    final ProductDetails? storeProductDetails =
        storeProductList.firstWhereOrNull((product) => product.id == storeId);
    if (storeProductDetails == null) {
      exSnackBar("Purchase failure", type: ExSnackBarType.error);
      return;
    }

    /// 创建订单
    currentOrderId = await createOrder(storeProductDetails, 0);
    if (Utils.isEmpty(currentOrderId)) {
      // exSnackBar("create order fail!", type: ExSnackBarType.error);
      return;
    }

    ///购买商品
    AppPurchase.payProductNow(storeProductDetails, 1, currentOrderId!);
  }

  ///月度订阅
  payMonthly() async {
    if (isAgree == false) {
      exSnackBar("Please agree to the service agreement!",
          type: ExSnackBarType.warning);
      return;
    }
    ///当前月度订阅商品的id
    String storeId = GetPlatform.isAndroid
        ? monthProduct?.androidId ?? ''
        : monthProduct?.iosId ?? '';

    ///根据服务端商品详情获取商店里面的商品详情
    final ProductDetails? storeProductDetails =
        storeProductList.firstWhereOrNull((product) => product.id == storeId);
    if (storeProductDetails == null) {
      exSnackBar("Purchase failure", type: ExSnackBarType.error);
      return;
    }

    /// 创建订单
    currentOrderId = await createOrder(storeProductDetails, 1);
    if (Utils.isEmpty(currentOrderId)) {
      // exSnackBar("create order fail!", type: ExSnackBarType.error);
      return;
    }

    ///购买商品
    AppPurchase.payProductNow(storeProductDetails!, 2, currentOrderId!);
  }

  ///通知服务端商品购买成功或者失败
  notifyServerPurchaseResult(PurchaseDetails purchaseDetails) async {
    // print(purchaseDetails.status);
    ///ios在月度订阅扣费的时候也会进入这里，android就不会
    ///订单支付成功或者失败都会清空currentOrderId,如果currentOrderId为空，就不在执行更新订单信息的回调操作
    if (Utils.isEmpty(currentOrderId)) {
      return;
    }
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      orderSuccess(purchaseDetails);
    }
    if (purchaseDetails == null ||
        purchaseDetails.status == PurchaseStatus.canceled ||
        purchaseDetails.status == PurchaseStatus.error) {
      orderFail(purchaseDetails);
    }
  }

  //订单成功
  orderSuccess(PurchaseDetails purchaseDetails) async {
    ///根据商品id获取商店商品详情
    final ProductDetails? storeProductDetails = storeProductList
        .firstWhereOrNull((product) => product.id == purchaseDetails.productID);
    ///根据商店商品id获取服务端商品详情
    final Product? serverProductDetails = energyProductList.firstWhereOrNull(
        (product) => GetPlatform.isAndroid
            ? product.androidId == purchaseDetails.productID
            : product.iosId == purchaseDetails.productID);

    final Map<String, dynamic> params = {
      "orderId": currentOrderId, //订单id
      "productId": serverProductDetails?.productId, //服务端商品id
      "receipt": storeProductDetails?.rawPrice, //商品实际价格(用户当地货币价格)
      "currencyCode": storeProductDetails?.currencyCode, //商品价格单位(用户当地货币单位)
      "status": purchaseDetails.status.toString(), //购买状态
      "purchaseID": purchaseDetails?.purchaseID ?? '', //购买id
      "appleProductID": purchaseDetails.productID ?? '', //apple商品id
      "verificationData": {
        "localVerificationData":
            purchaseDetails?.verificationData?.localVerificationData ??
                '', //local验证数据
        "serverVerificationData":
            purchaseDetails?.verificationData?.serverVerificationData ??
                '', //server验证数据
      },
      "transactionDate": purchaseDetails?.transactionDate ?? '', //apple交易时间
    };
    Loading.show();
    HttpUtils.diorequst("/order/iosPay", method: 'post', params: params)
        .then((response) {
      Loading.dismiss();
      if (response['code'] == 200) {
        exSnackBar("purchase success", type: ExSnackBarType.success);
      } else {
        exSnackBar("purchase failed", type: ExSnackBarType.error);
      }

      ///清空当前订单id
      currentOrderId = '';

      ///刷新卡券列表
      getChargeCardList();

      ///刷新用户信息
      MineController userController = Get.find<MineController>();
      userController.getUser();
    }).catchError((error) {
      Loading.dismiss();
      exSnackBar(error, type: ExSnackBarType.error);

      ///清空当前订单id
      currentOrderId = '';
    });
  }

  //订单失败
  orderFail(PurchaseDetails? purchaseDetails) async {
    //订单状态,0进行中,1功,2失败,3取消
    final Map<String, dynamic> params = {
      "orderId": currentOrderId,
      //订单id
      "status": purchaseDetails?.status == PurchaseStatus.canceled ? 3 : 2,
      //购买状态
    };
    Loading.show();
    HttpUtils.diorequst("/order/orderFail", method: 'post', params: params)
        .then((response) {
      Loading.dismiss();
      if (response['code'] == 200) {
        //如果是取消和失败的订单,提示不一样
        if (purchaseDetails?.status == PurchaseStatus.canceled) {
          exSnackBar("purchase canceled", type: ExSnackBarType.warning);
        } else {
          exSnackBar("purchase failed", type: ExSnackBarType.error);
        }

        ///清空当前订单id
        currentOrderId = '';
      }
    }).catchError((error) {
      Loading.dismiss();
      exSnackBar(error, type: ExSnackBarType.error);

      ///清空当前订单id
      currentOrderId = '';
    });
  }

  @override
  void onInit() {
    super.onInit();

    /// 卡券列表跳转过来的带了个卡券id
    couponId = Get.arguments?["couponId"];
    if (!Utils.isEmpty(couponId)) {
      tabKey = EnergyTabKey.star;
    }

    ///设置回调
    AppPurchase.orderCallback = notifyServerPurchaseResult;
  }

  @override
  void onReady() {
    super.onReady();
    getProductList();
    getChargeCardList();
  }

  @override
  void onClose() {
    ///清除回调
    AppPurchase.orderCallback = null;
    super.onClose();
  }
}
