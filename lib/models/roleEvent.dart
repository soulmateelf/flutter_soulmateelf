// To parse this JSON data, do
//
//     final roleEvent = roleEventFromJson(jsonString);

import 'dart:convert';

import 'package:soulmate/models/activety.dart';

RoleEvent roleEventFromJson(String str) => RoleEvent.fromJson(json.decode(str));

String roleEventToJson(RoleEvent data) => json.encode(data.toJson());

class RoleEvent {
  String memoryId;
  String roleId;
  String? image;
  int? endTime;
  int? public;
  String? gptLogId;
  String? remark;
  int? updateTime;
  String content;
  int id;
  int? startTime;
  int publishTime;
  dynamic? userId;
  int status;
  int createTime;
  List<Activity> activities;

  RoleEvent({
    required this.memoryId,
    required this.roleId,
    this.image,
    this.endTime,
    this.public,
    this.gptLogId,
    this.remark,
    this.updateTime,
    required this.content,
    required this.id,
    required this.startTime,
    required this.publishTime,
    this.userId,
    required this.status,
    required this.createTime,
    required this.activities,
  });

  factory RoleEvent.fromJson(Map<String, dynamic> json) => RoleEvent(
        memoryId: json["memoryId"],
        roleId: json["roleId"],
        image: json["image"],
        endTime: json["endTime"],
        public: json["public"],
        gptLogId: json["gptLogId"],
        remark: json["remark"],
        updateTime: json["updateTime"],
        content: json["content"],
        id: json["id"],
        startTime: json["startTime"],
        publishTime: json["publishTime"],
        userId: json["userId"],
        status: json["status"],
        createTime: json["createTime"],
        activities: List<Activity>.from(
            json["activities"].map((x) => Activity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "memoryId": memoryId,
        "roleId": roleId,
        "image": image,
        "endTime": endTime,
        "public": public,
        "gptLogId": gptLogId,
        "remark": remark,
        "updateTime": updateTime,
        "content": content,
        "id": id,
        "startTime": startTime,
        "publishTime": publishTime,
        "userId": userId,
        "status": status,
        "createTime": createTime,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
      };
}
