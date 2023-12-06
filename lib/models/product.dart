//商品
class Product {
  int id;
  String productId;
  double amount;
  int energy;
  int type;
  String androidId;
  String iosId;
  int status;
  String? remark;
  int? createTime;
  int? updateTime;

  Product({
    required this.id,
    required this.productId,
    required this.amount,
    required this.energy,
    required this.type,
    required this.androidId,
    required this.iosId,
    required this.status,
    this.remark,
    this.createTime,
    this.updateTime,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productId: json["productId"],
    amount: json["amount"]?.toDouble(),
    energy: json["energy"],
    type: json["type"],
    androidId: json["androidId"],
    iosId: json["iosId"],
    status: json["status"],
    remark: json["remark"],
    createTime: json["createTime"],
    updateTime: json["updateTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "amount": amount,
    "energy": energy,
    "type": type,
    "androidId": androidId,
    "iosId": iosId,
    "status": status,
    "remark": remark,
    "createTime": createTime,
    "updateTime": updateTime,
  };
}