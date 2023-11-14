import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:soulmate/utils/plugin/AppPurchase.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

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
  List<ProductDetails> productList = [];
  ///服务端商品列表
  List serverProductList = [];

  EnergyTabKey _tabKey = EnergyTabKey.vip;

  EnergyTabKey get tabKey => _tabKey;

  set tabKey(EnergyTabKey value) {
    _tabKey = value;
    update();
  }

  int _starEnergyCardIndex = 0;

  int get starEnergyCardIndex => _starEnergyCardIndex;

  set starEnergyCardIndex(int value) {
    _starEnergyCardIndex = value;
    update();
  }

  // 获取商品列表
  getProductList() {
    serverProductList = [
      {"id":"energy1"},
      {"id":"energy2"},
    ];
    print("serverProductList");
    ///根据服务端商品列表获取商店配置的商品列表
    // getStoreProducts();
    // NetUtils.diorequst("/product/ByProductType", 'get',params:{'productType':1}).then((result) {
    //   if (result.data?["code"] == 200) {
    //     final data = result.data?["data"]?["data"] ?? [];
    //     productList = data;
    //     ///根据服务端商品列表获取ios商品列表
    //     getIOSProducts();
    //   }
    // });
  }
  ///获取商店配置的商品列表
  getStoreProducts() async {
    ///取出服务端商品列表中的ios商品id
    Set<String> pIds = <String>{};
    serverProductList.forEach((product) {
      if (!Utils.isEmpty(product['id']))
        pIds.add(product["id"]);
    });
    print("9999999");
    ///根据商品id获取商店的商品列表
    productList = await AppPurchase.getServerProducts(pIds);
    print(productList);
    ///服务端的商品如果在ios云端没有找到，就不能购买，所以需要过滤掉
    // productList = productList
    //     .where((element) => productList
    //     .any((product) => product.id == element.id))
    //     .toList();
    // update();
  }

  ///购买商品
  payNow(var productDetail) async {
    ///根据服务端商品详情获取apple商品详情
    final ProductDetails? appleProductDetails =
    productList.firstWhereOrNull((product) =>
    product.id ==
        productDetail[
        "appleProductId"]); // Saved earlier from queryProductDetails().
    if (appleProductDetails == null) {
      exSnackBar("something wrong", type: ExSnackBarType.error);
      return;
    }

    ///购买商品
    AppPurchase.payProductNow(appleProductDetails);
  }

  ///通知服务端商品购买成功或者失败
  notifyServerPurchaseResult(PurchaseDetails purchaseDetails) async {
    print(purchaseDetails.status);
  }

  void ttttt() async{
    print("11");
    const Set<String> _kIds = <String>{'energy1', 'energy2'};
    print("22");
    InAppPurchase.instance.isAvailable().then((value) => print(value));
    final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(_kIds);
    print(response.productDetails.length);
    // if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    // }
    print("44");
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
  }

  @override
  void onClose() {
    ///清除回调
    AppPurchase.orderCallback = null;
    super.onClose();
  }

}
