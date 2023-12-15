// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String productName;
  int status;
  int productType;
  dynamic remark;
  String orderId;
  String productIosId;
  int paymentMethodType;
  int id;
  String productAndroidId;
  String moneyType;
  String userId;
  int type;
  int productNum;
  double orderAmount;
  String productId;
  int createTime;
  double productAmount;
  String couponId;
  dynamic updateTime;
  int productEnergy;
  String result;

  Order({
    required this.productName,
    required this.status,
    required this.productType,
    required this.remark,
    required this.orderId,
    required this.productIosId,
    required this.paymentMethodType,
    required this.id,
    required this.productAndroidId,
    required this.moneyType,
    required this.userId,
    required this.type,
    required this.productNum,
    required this.orderAmount,
    required this.productId,
    required this.createTime,
    required this.productAmount,
    required this.couponId,
    required this.updateTime,
    required this.productEnergy,
    required this.result,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    productName: json["productName"],
    status: json["status"],
    productType: json["productType"],
    remark: json["remark"],
    orderId: json["orderId"],
    productIosId: json["productIosId"],
    paymentMethodType: json["paymentMethodType"],
    id: json["id"],
    productAndroidId: json["productAndroidId"],
    moneyType: json["moneyType"],
    userId: json["userId"],
    type: json["type"],
    productNum: json["productNum"],
    orderAmount: json["orderAmount"],
    productId: json["productId"],
    createTime: json["createTime"],
    productAmount: json["productAmount"]?.toDouble(),
    couponId: json["couponId"],
    updateTime: json["updateTime"],
    productEnergy: json["productEnergy"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "productName": productName,
    "status": status,
    "productType": productType,
    "remark": remark,
    "orderId": orderId,
    "productIosId": productIosId,
    "paymentMethodType": paymentMethodType,
    "id": id,
    "productAndroidId": productAndroidId,
    "moneyType": moneyType,
    "userId": userId,
    "type": type,
    "productNum": productNum,
    "orderAmount": orderAmount,
    "productId": productId,
    "createTime": createTime,
    "productAmount": productAmount,
    "couponId": couponId,
    "updateTime": updateTime,
    "productEnergy": productEnergy,
    "result": result,
  };
}
