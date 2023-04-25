/*
 * @Date: 2023-04-24 13:54:29
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 18:19:47
 * @FilePath: \soulmate\lib\views\main\customRole\logic.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/IOSAppPurchase.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
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

  ///ios云端商品详情
  late ProductDetails appleProductsDetail;
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
    getProductDetail();
  }

  @override
  void onClose() {
    ///清除回调
    IOSAppPurchase.orderCallback = null;
    super.onClose();
  }
  /// 获取商品详情
  getProductDetail() async {
    /// 获取服务端商品详情
    productDetail = {'appleProductId': 'test2'};
    /// 获取ios端商品列表
    Set<String> pIds = <String>{productDetail['appleProductId']};
    List<ProductDetails> list = await IOSAppPurchase.getIOSServerProducts(pIds);
    if(list.length != 1){
      Loading.error('something wrong');
    }
    appleProductsDetail = list[0];
    return;
    final result = await NetUtils.diorequst("/product/getProductDetail", "get");
    if (result?.data?["code"] == 200) {
      final data = result.data?["data"] ?? {};
      productDetail = data;
    }
  }



  step1ViewSubmit() {
    if (formKey.currentState!.validate()) {
      getCharacterList();
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

  step2ViewSubmit() {
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

  step3ViewSubmit(PurchaseDetails purchaseDetails) async {
    final validated = step3FormKey.currentState!.validate();
    if (!validated) return;
    Loading.show();
    NetUtils.diorequst("/role/addcustomization", 'post', params: {
      "roleName": nameController.value,
      "gender": genderController.value,
      "age": ageController.value,
      "roleCharacter": checkedCharacterIdList.join(","),
      "roleIntroduction": introductionController.value,
      "replenish": replenishController.value,
      "gptModel": 3.5,
      "roleStar": star,
      "email": emailController.value ?? Application.userInfo?["email"],
      "sendEmail": sendEmail,
    }).then((value) {}).whenComplete(() {
      Loading.dismiss();
    });
  }

  ///购买商品
  payNow() async {
    IOSAppPurchase.payProductNow(appleProductsDetail);
  }
}
