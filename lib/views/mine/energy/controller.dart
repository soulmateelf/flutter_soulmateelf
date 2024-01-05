import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:soulmate/models/recharge.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/AppPurchase.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/mine/account/controller.dart';
import 'package:soulmate/views/mine/mine/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:soulmate/models/product.dart';
import 'package:soulmate/models/energyCard.dart';

enum EnergyTabKey {
  vip,
  star,
}

Map<EnergyTabKey, String> energyTabMap = {
  EnergyTabKey.vip: "VIP package",
  EnergyTabKey.star: "Star energy",
};

class EnergyController extends GetxController {
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

  ///当前选中的卡券
  RechargeableCard? currentCard;

  ///当前订单id
  String? currentOrderId;

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
  void getEnergyCardList() {
    HttpUtils.diorequst('/coupon/couponList', query: {"page": 1, "size": 10})
        .then((res) {
      List<dynamic> data = res['data'] ?? [];
      cardList = data.map((e) => RechargeableCard.fromJson(e)).toList();
      if (cardList.isNotEmpty) {
        currentCard = cardList.first;
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
      "couponId": currentCard?.couponId.toString(),
    };
    return await HttpUtils.diorequst("/order/createOrder",
            method: 'post', params: params)
        .then((response) {
      if (response['code'] == 200) {
        return response['data'];
      }
      return '';
    }).catchError((error) {
      // exSnackBar(error, type: ExSnackBarType.error);
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
      exSnackBar("create order fail!", type: ExSnackBarType.error);
      return;
    }

    ///购买商品
    AppPurchase.payProductNow(storeProductDetails, 1, currentOrderId!);
  }

  ///月度订阅
  payMonthly() async {
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
      exSnackBar("create order fail!", type: ExSnackBarType.error);
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
      "receipt": storeProductDetails?.rawPrice, //商品实际价格
      "currencyCode": storeProductDetails?.currencyCode, //商品价格单位
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
      getEnergyCardList();

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
          exSnackBar("purchase canceled", type: ExSnackBarType.error);
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

    ///设置回调
    AppPurchase.orderCallback = notifyServerPurchaseResult;
  }

  @override
  void onReady() {
    super.onReady();
    getProductList();
    getEnergyCardList();
  }

  @override
  void onClose() {
    ///清除回调
    AppPurchase.orderCallback = null;
    super.onClose();
  }
}
