// To parse this JSON data, do
//
//     final rechargeableCard = rechargeableCardFromJson(jsonString);

import 'dart:convert';

RechargeableCard rechargeableCardFromJson(String str) => RechargeableCard.fromJson(json.decode(str));

String rechargeableCardToJson(RechargeableCard data) => json.encode(data.toJson());

class RechargeableCard {
  String title;
  int id;
  int origin;
  ///卡券状态,0未使用,1已使用,2已过期
  int couponStatus;
  dynamic remark;
  int updateTime;
  int ratio;
  String couponId;
  String userId;
  int expiredTime;
  int status;
  int createTime;

  RechargeableCard({
    required this.title,
    required this.id,
    required this.origin,
    required this.couponStatus,
    required this.remark,
    required this.updateTime,
    required this.ratio,
    required this.couponId,
    required this.userId,
    required this.expiredTime,
    required this.status,
    required this.createTime,
  });

  factory RechargeableCard.fromJson(Map<String, dynamic> json) => RechargeableCard(
    title: json["title"],
    id: json["id"],
    origin: json["origin"],
    couponStatus: json["couponStatus"],
    remark: json["remark"],
    updateTime: json["updateTime"],
    ratio: json["ratio"],
    couponId: json["couponId"],
    userId: json["userId"],
    expiredTime: json["expiredTime"],
    status: json["status"],
    createTime: json["createTime"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "origin": origin,
    "couponStatus": couponStatus,
    "remark": remark,
    "updateTime": updateTime,
    "ratio": ratio,
    "couponId": couponId,
    "userId": userId,
    "expiredTime": expiredTime,
    "status": status,
    "createTime": createTime,
  };
}
