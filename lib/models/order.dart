// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:soulmate/models/product.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String orderId;
  String userId;
  int type;
  String result;
  dynamic remark;
  String moneyType;
  int createTime;
  double orderAmount;
  int id;
  String productId;
  String couponId;
  int status;
  int paymentMethodType;
  int productNum;
  dynamic updateTime;

  Product productInfo;

  Order({
    required this.orderId,
    required this.userId,
    required this.type,
    required this.result,
    required this.remark,
    required this.moneyType,
    required this.createTime,
    required this.orderAmount,
    required this.id,
    required this.productId,
    required this.couponId,
    required this.status,
    required this.paymentMethodType,
    required this.productNum,
    required this.updateTime,
    required this.productInfo,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
        userId: json["userId"],
        type: json["type"],
        result: json["result"],
        remark: json["remark"],
        moneyType: json["moneyType"],
        createTime: json["createTime"],
        orderAmount: json["orderAmount"],
        id: json["id"],
        productId: json["productId"],
        couponId: json["couponId"],
        status: json["status"],
        paymentMethodType: json["paymentMethodType"],
        productNum: json["productNum"],
        updateTime: json["updateTime"],
        productInfo: Product.fromJson(json['productInfo']),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "userId": userId,
        "type": type,
        "result": result,
        "remark": remark,
        "moneyType": moneyType,
        "createTime": createTime,
        "orderAmount": orderAmount,
        "id": id,
        "productId": productId,
        "couponId": couponId,
        "status": status,
        "paymentMethodType": paymentMethodType,
        "productNum": productNum,
        "updateTime": updateTime,
        "productInfo": productInfo.toJson(),
      };
}
