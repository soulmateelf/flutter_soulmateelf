/*
 * @Date: 2023-04-24 13:54:29
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-26 15:14:41
 * @FilePath: \soulmate\lib\views\main\customRole\logic.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/IOSAppPurchase.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class CustomRoleLogic extends GetxController {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var _star = 3;

  int get star {
    return _star;
  }

  set star(int num) {
    _star = num;
    update();
  }
  ///服务端商品列表
  var productList = [];
  ///ios云端商品详情
  List<ProductDetails> appleProductsList = [];
  /// 服务端商品详情
  var productDetail = {};

  @override
  void onInit() {
    super.onInit();

    ///设置回调
    IOSAppPurchase.orderCallback = step3ViewSubmit;
  }

  @override
  void onReady() {
    super.onReady();
    getProductList();
  }

  @override
  void onClose() {
    ///清除回调
    IOSAppPurchase.orderCallback = null;
    super.onClose();
  }

  /// 获取商品详情
  getProductList() async {
    NetUtils.diorequst("/product/ByProductType", 'get',params:{'productType':2}).then((result) {
      if (result.data?["code"] == 200) {
        final data = result.data?["data"]?["data"] ?? [];
        productList = data;
        ///根据服务端商品列表获取ios商品列表
        getIOSProducts();
      }
    });
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

  step1ViewSubmit() {
    if (formKey.currentState!.validate()) {
      getCharacterList();
      ///根据星级选中的需要展示的商品详情
      productDetail = productList.firstWhere((element) => element["roleStar"] == star);
      Get.toNamed("/customRoleStep2");
    }
  }

  // 性格列表
  var _characterList = [];
  List<dynamic> get characterList {
    return _characterList;
  }

  set characterList(value) {
    _characterList = value;
    update();
  }

  /// 选中的性格id列表
  var _checkedCharacterIdList = [];
  List<dynamic> get checkedCharacterIdList {
    return _checkedCharacterIdList;
  }

  set checkedCharacterIdList(value) {
    _checkedCharacterIdList = value;
    update();
  }

  changeCharacterStatus(id) {
    final checked = checkedCharacterIdList.any((_id) => id == _id);
    if (checked) {
      checkedCharacterIdList.removeWhere(
        (_id) => id == _id,
      );
    } else {
      checkedCharacterIdList.add(id);
    }
    update();
  }

  getCharacterList() async {
    final result = await NetUtils.diorequst("/role/getCharacter", "get");
    if (result?.data?["code"] == 200) {
      final data = result.data?["data"] ?? [];
      characterList = data;
    }
  }

  step2ViewSubmit() async {
    Get.toNamed("/customRoleStep3");
  }

  final step3FormKey = GlobalKey<FormState>();
  final introductionController = TextEditingController();
  final replenishController = TextEditingController();
  final emailController = TextEditingController();
  var _sendEmail = false;

  get sendEmail {
    return _sendEmail;
  }

  set sendEmail(value) {
    _sendEmail = value;
    update();
  }

  step3ViewSubmit(PurchaseDetails? purchaseDetails) async {
    final validated = step3FormKey.currentState!.validate();
    if (!validated || purchaseDetails == null) return;
    Loading.show();
    ///根据商品id获取apple商品详情
    final ProductDetails? appleProductDetails = appleProductsList
        .firstWhereOrNull((product) => product.id == purchaseDetails?.productID);
    NetUtils.diorequst("/role/addcustomization", 'post', params: {
      "roleName": nameController.value.text,
      "gender": genderController.value.text,
      "age": ageController.value.text,
      "roleCharacter": checkedCharacterIdList.join(","),
      "roleIntroduction": introductionController.value.text,
      "replenish": replenishController.value.text,
      "gptModel": "3.5",
      "roleStar": star,
      "email": emailController.value.text ?? Application.userInfo?["email"],
      "sendEmail": sendEmail ? 1 : 0,
      "productId": productDetail["id"], //服务端商品id
      "money": appleProductDetails?.rawPrice, //apple商品价格
      "currencyCode": appleProductDetails?.currencyCode, //商品价格单位
      "status": purchaseDetails?.status?.toString(), //购买状态
      "purchaseID": purchaseDetails?.purchaseID, //购买id
      "appleProductID": purchaseDetails?.productID, //apple商品id
      "verificationData": {
        "localVerificationData": purchaseDetails?.verificationData?.localVerificationData, //local验证数据
        "serverVerificationData": purchaseDetails?.verificationData?.serverVerificationData, //server验证数据
      },
      "transactionDate": purchaseDetails?.transactionDate, //apple交易时间
    }).then((value) {
      Loading.success("${value?.data?["message"]}");
      /// 返回home，清空home之后的路由栈
      Get.until(ModalRoute.withName('/home'));
    }).whenComplete(() {
      Loading.dismiss();
    });
  }

  ///购买商品
  payNow() async {
    // 让页面失焦 达到关闭键盘输入的目的
    FocusManager.instance.primaryFocus?.unfocus();
    ///根据商品id获取ios商品详情
    final appleProductsDetail = appleProductsList
        .firstWhere((element) => element.id == productDetail["appleProductId"]);
    IOSAppPurchase.payProductNow(appleProductsDetail);
  }
}
