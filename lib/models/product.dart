// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  double amount;
  String productName;
  String productId;
  int id;
  int status;
  String iosId;
  int createTime;
  int energy;
  int type;
  dynamic remark;
  String androidId;
  dynamic updateTime;

  Product({
    required this.amount,
    required this.productName,
    required this.productId,
    required this.id,
    required this.status,
    required this.iosId,
    required this.createTime,
    required this.energy,
    required this.type,
    required this.remark,
    required this.androidId,
    required this.updateTime,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    amount: json["amount"]?.toDouble(),
    productName: json["productName"],
    productId: json["productId"],
    id: json["id"],
    status: json["status"],
    iosId: json["iosId"],
    createTime: json["createTime"],
    energy: json["energy"],
    type: json["type"],
    remark: json["remark"],
    androidId: json["androidId"],
    updateTime: json["updateTime"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "productName": productName,
    "productId": productId,
    "id": id,
    "status": status,
    "iosId": iosId,
    "createTime": createTime,
    "energy": energy,
    "type": type,
    "remark": remark,
    "androidId": androidId,
    "updateTime": updateTime,
  };
}
