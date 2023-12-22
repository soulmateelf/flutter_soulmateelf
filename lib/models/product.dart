class Product {
  double amount;
  double? rawAmount;
  String productName;
  String productId;
  int id;
  int status;
  String iosId;
  int? createTime;
  int energy;
  int type;
  String? remark;
  String androidId;
  int? updateTime;

  Product({
    required this.amount,
    this.rawAmount,
    required this.productName,
    required this.productId,
    required this.id,
    required this.status,
    required this.iosId,
    this.createTime,
    required this.energy,
    required this.type,
    this.remark,
    required this.androidId,
    this.updateTime,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    amount: json["amount"]?.toDouble(),
    rawAmount: json["rawAmount"]?.toDouble(),
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
    "rawAmount": rawAmount,
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
