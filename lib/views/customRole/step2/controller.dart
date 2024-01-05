import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:soulmate/models/product.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/AppPurchase.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class Step2Controller extends GetxController {
  final nameController = TextEditingController();
  String genderType = "male";

  void setGender(String s) {
    genderType = s;
    update();
  }

  double age = 1.00;
  final hobbyController = TextEditingController();
  final introductionController = TextEditingController();
  final remarkController = TextEditingController();
  XFile? avatar;

  ///定制角色商品
  Product? customRoleProduct;

  ///商店配置的商品列表
  ProductDetails? storeProduct;

  ///当前订单id
  String? currentOrderId;

  ///表单数据
  FormData? formData;

  @override
  void onInit() {
    super.onInit();

    ///设置回调
    AppPurchase.orderCallback = notifyServerPurchaseResult;
  }

  @override
  void onReady() {
    super.onReady();
    customRoleProduct = Get.arguments['customRoleProduct'];
    getStoreProducts();
    update();
  }

  ///获取商店配置的商品列表
  getStoreProducts() async {
    ///取出服务端商品列表中的商品id
    String pId = GetPlatform.isAndroid
        ? customRoleProduct?.androidId ?? ''
        : customRoleProduct?.iosId ?? '';
    Set<String> pIds = <String>{pId};

    ///根据商品id获取商店的商品列表
    List<ProductDetails> storeProductList =
        await AppPurchase.getServerProducts(pIds);
    storeProduct = storeProductList.firstWhereOrNull(
        (ProductDetails productDetails) => productDetails.id == pId);

    ///服务端的商品如果在ios云端没有找到，就不能购买，所以需要过滤掉
    if (storeProduct == null) {
      exSnackBar("No custom role product", type: ExSnackBarType.warning);
      return;
    }
  }

  // 创建订单
  createOrder(ProductDetails storeProductDetails, int type) async {
    Map<String, dynamic> params = {
      "orderAmount": storeProductDetails.rawPrice,
      "orderType": type, //0:购买商品 1:月度订阅 2:定制角色
      "productId": customRoleProduct?.productId,
      "paymentMethodType": GetPlatform.isIOS ? 0 : 1,
      "moneyType": storeProductDetails.currencyCode,
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
    /// 创建订单
    currentOrderId = await createOrder(storeProduct!, 0);
    if (Utils.isEmpty(currentOrderId)) {
      exSnackBar("create order fail!", type: ExSnackBarType.error);
      return;
    }

    ///购买商品
    AppPurchase.payProductNow(storeProduct!, 1, currentOrderId!);
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
    final Map<String, dynamic> params = {
      "orderId": currentOrderId, //订单id
      "productId": customRoleProduct?.productId, //服务端商品id
      "receipt": storeProduct?.rawPrice, //商品实际价格
      "currencyCode": storeProduct?.currencyCode, //商品价格单位
      "status": purchaseDetails.status.toString(), //购买状态
      "purchaseID": purchaseDetails?.purchaseID ?? '', //购买id
      "appleProductID": purchaseDetails.productID ?? '', //apple商品id
      "verificationData": json.encode({
        "localVerificationData":
            purchaseDetails?.verificationData?.localVerificationData ??
                '', //local验证数据
        "serverVerificationData":
            purchaseDetails?.verificationData?.serverVerificationData ??
                '', //server验证数据
      }),
      "transactionDate": purchaseDetails?.transactionDate ?? '', //apple交易时间
    };
    formData?.fields.addAll(params.entries
        .map((entry) => MapEntry(entry.key, entry.value.toString())));

    Loading.show();
    HttpUtils.diorequst("/order/addCustomization",
        method: 'post',
        params: formData,
        extra: {'formData': true}).then((response) {
      Loading.dismiss();

      ///清空当前订单id
      currentOrderId = '';
      if (response['code'] == 200) {
        exSnackBar("purchase success", type: ExSnackBarType.success);

        ///返回到菜单页面
        Get.until((route) => Get.currentRoute == "/menu");
      } else {
        exSnackBar("purchase failed", type: ExSnackBarType.error);
      }
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
      }

      ///清空当前订单id
      currentOrderId = '';
    }).catchError((error) {
      Loading.dismiss();
      exSnackBar(error, type: ExSnackBarType.error);

      ///清空当前订单id
      currentOrderId = '';
    });
  }

  void uploadAvatar() {
    Utils.pickerImage(Get.context!).then((files) {
      if (files.isNotEmpty) {
        avatar = files[0];
        update();
      }
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
    });
  }

  void submit() {
    if (nameController.text.isEmpty) {
      exSnackBar("Please enter the name", type: ExSnackBarType.warning);
      return;
    }
    if (hobbyController.text.isEmpty) {
      exSnackBar("Please enter the hobby", type: ExSnackBarType.warning);
      return;
    }
    if (introductionController.text.isEmpty) {
      exSnackBar("Please enter the introduction", type: ExSnackBarType.warning);
      return;
    }

    formData = FormData.fromMap({
      "name": nameController.text,
      "age": age,
      "gender": genderType,
      "Hobby": hobbyController.text,
      "characterIntroduction": introductionController.text,
      "remark": remarkController.text
    });

    if (avatar != null) {
      formData?.files
          .add(MapEntry("file", MultipartFile.fromFileSync(avatar!.path)));
    }

    final makeDialogController = MakeDialogController();
    makeDialogController.show(
        context: Get.context!,
        controller: makeDialogController,
        iconWidget: Image.asset("assets/images/image/successfully.png"),
        content: Container(
          child: Column(
            children: [
              Text(
                "Are you sure you want to pay \$${customRoleProduct?.amount ?? '--'} to customize your ELF? And don't worry, after paying you will have three chances to amend or get a half price refund.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 22.sp,
                    fontFamily: FontFamily.SFProRoundedMedium),
              ),
              SizedBox(
                height: 32.w,
              ),
              Container(
                height: 64.w,
                width: double.infinity,
                child: MaterialButton(
                  color: primaryColor,
                  onPressed: () {
                    payNow();
                    makeDialogController.close();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Text(
                    "Pay now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 64.w,
                child: TextButton(
                  onPressed: () {
                    makeDialogController.close();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.32),
                      fontSize: 20.sp,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
