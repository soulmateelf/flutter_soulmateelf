// To parse this JSON data, do
//
//     final energyCard = energyCardFromJson(jsonString);

import 'dart:convert';

EnergyCard energyCardFromJson(String str) => EnergyCard.fromJson(json.decode(str));

String energyCardToJson(EnergyCard data) => json.encode(data.toJson());

class EnergyCard {
  int id;
  int value;
  String orderId;
  String? roleId;
  String? remark;
  int? updateTime;
  String energyLogId;
  String userId;
  int origin;
  String? advertLogId;
  int status;
  int createTime;

  EnergyCard({
    required this.id,
    required this.value,
    required this.orderId,
    this.roleId,
    this.remark,
    required this.updateTime,
    required this.energyLogId,
    required this.userId,
    required this.origin,
    this.advertLogId,
    required this.status,
    required this.createTime,
  });

  factory EnergyCard.fromJson(Map<String, dynamic> json) => EnergyCard(
    id: json["id"],
    value: json["value"],
    orderId: json["orderId"],
    roleId: json["roleId"],
    remark: json["remark"],
    updateTime: json["updateTime"],
    energyLogId: json["energyLogId"],
    userId: json["userId"],
    origin: json["origin"],
    advertLogId: json["advertLogId"],
    status: json["status"],
    createTime: json["createTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "orderId": orderId,
    "roleId": roleId,
    "remark": remark,
    "updateTime": updateTime,
    "energyLogId": energyLogId,
    "userId": userId,
    "origin": origin,
    "advertLogId": advertLogId,
    "status": status,
    "createTime": createTime,
  };
}
