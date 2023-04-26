/*
 * @Date: 2023-04-20 10:33:15
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-26 15:41:13
 * @FilePath: \soulmate\lib\views\main\recharge\logic.dart
 */

import 'package:flutter_soulmateelf/utils/plugin/IOSAppPurchase.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../utils/core/httputil.dart';
import '../../../utils/plugin/plugin.dart';

class RechargetLogic extends GetxController {
  ///ios云端商品列表
  List<ProductDetails> appleProductsList = [];

  /// 角色列表
  var _roleList = [];

  get roleList {
    return _roleList;
  }

  set roleList(dynamic roleList) {
    _roleList = roleList;
  }

  /// 选中的角色id
  var _checkedRoleId = 1;

  get checkedRoleId {
    return _checkedRoleId;
  }

  set checkedRoleId(dynamic id) {
    _checkedRoleId = id;
    update();
  }

  get checkedRole {
    if (_roleList.length == 0) {
      return null;
    }
    return _roleList?.firstWhere((role) => role["id"] == _checkedRoleId);
  }

  /// 获取角色列表
  getRoleList() {
    NetUtils.diorequst("/role/getRoleList", 'get').then((result) {
      if (result?.data?["code"] == 200) {
        final data = result?.data?["data"]?["data"] ?? [];
        roleList = data;

        checkedRoleId = Get.arguments["checkedRoleId"] ??
            (data.length > 0 ? (data[0]?["id"]) : 1);
      }
    });
  }

  ///服务端商品列表
  var _productList = [];

  List<dynamic> get productList {
    return _productList;
  }

  set productList(List<dynamic> value) {
    _productList = value;
    update();
  }

  // 获取商品列表
  getProductList() {
    NetUtils.diorequst("/product/ByProductType", 'get',params:{'productType':1}).then((result) {
      if (result.data?["code"] == 200) {
        final data = result.data?["data"]?["data"] ?? [];
        productList = data;
        ///根据服务端商品列表获取ios商品列表
        getIOSProducts();
      }
    });
  }

  /// 优惠券列表
  var _couponList = [];

  List<dynamic> get couponList {
    return _couponList;
  }

  set couponList(List<dynamic> value) {
    _couponList = value;
    update();
  }

  ///获取ios云端的商品列表
  getIOSProducts() async {
    ///取出服务端商品列表中的ios商品id
    Set<String> pIds = <String>{};
    productList.forEach((product) {
      if (!Utils.isEmpty(product['appleProductId']))
        pIds.add(product["appleProductId"]);
    });

    ///根据商品id获取ios云端商品列表
    appleProductsList = await IOSAppPurchase.getIOSServerProducts(pIds);

    ///服务端的商品如果在ios云端没有找到，就不能购买，所以需要过滤掉
    productList = productList
        .where((element) => appleProductsList
            .any((product) => product.id == element["appleProductId"]))
        .toList();
    update();
  }

  ///购买商品
  payNow(var productDetail) async {
    ///根据服务端商品详情获取apple商品详情
    final ProductDetails? appleProductDetails =
        appleProductsList.firstWhereOrNull((product) =>
            product.id ==
            productDetail[
                "appleProductId"]); // Saved earlier from queryProductDetails().
    if (appleProductDetails == null) {
      Loading.error("something wrong");
      return;
    }

    ///购买商品
    IOSAppPurchase.payProductNow(appleProductDetails);
  }

  ///通知服务端商品购买成功或者失败
  notifyServerPurchaseResult(PurchaseDetails purchaseDetails) async {
    ///根据商品id获取apple商品详情
    final ProductDetails? appleProductDetails = appleProductsList
        .firstWhereOrNull((product) => product.id == purchaseDetails.productID);

    ///根据apple商品详情获取服务端商品详情
    final productDetail = productList.firstWhere(
        (element) => element["appleProductId"] == purchaseDetails.productID);
    final Map<String, dynamic> params = {
      "roleId": checkedRoleId, //角色id
      "productId": productDetail["id"], //服务端商品id
      "money": appleProductDetails?.rawPrice, //apple商品价格
      "currencyCode": appleProductDetails?.currencyCode, //商品价格单位
      "status": purchaseDetails.status.toString(), //购买状态
      "purchaseID": purchaseDetails.purchaseID, //购买id
      "appleProductID": purchaseDetails.productID, //apple商品id
      "verificationData": {
        "localVerificationData":
            purchaseDetails.verificationData.localVerificationData, //local验证数据
        "serverVerificationData": purchaseDetails
            .verificationData.serverVerificationData, //server验证数据
      },
      "transactionDate": purchaseDetails.transactionDate, //apple交易时间
    };
    void successFn(res) {
      update();
    }

    void errorFn(error) {
      Loading.error("${error['message']}");
    }

    return NetUtils.diorequst(
      '/order/payment',
      'post',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }

  @override
  void onInit() {
    super.onInit();

    ///设置回调
    IOSAppPurchase.orderCallback = notifyServerPurchaseResult;
  }

  @override
  void onReady() {
    super.onReady();
    getRoleList();
    getProductList();
  }

  @override
  void onClose() {
    ///清除回调
    IOSAppPurchase.orderCallback = null;
    super.onClose();
  }
}
