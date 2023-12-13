// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  String memoryId;
  String activityId;

  /// 0点赞,1评论
  int type;
  int status;
  int createTime;
  String avatar;
  String userId;
  String userName;
  int id;
  dynamic content;
  dynamic remark;
  dynamic updateTime;

  Activity({
    required this.memoryId,
    required this.activityId,
    required this.type,
    required this.status,
    required this.createTime,
    required this.avatar,
    required this.userId,
    required this.id,
    required this.content,
    required this.remark,
    required this.updateTime,
    required this.userName,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        memoryId: json["memoryId"],
        activityId: json["activityId"],
        type: json["type"],
        status: json["status"],
        createTime: json["createTime"],
        avatar: json["avatar"],
        userId: json["userId"],
        id: json["id"],
        content: json["content"],
        remark: json["remark"],
        updateTime: json["updateTime"],
        userName: json['userName'],
      );

  Map<String, dynamic> toJson() => {
        "memoryId": memoryId,
        "activityId": activityId,
        "type": type,
        "status": status,
        "createTime": createTime,
        "avatar": avatar,
        "userId": userId,
        "id": id,
        "content": content,
        "remark": remark,
        "updateTime": updateTime,
        "userName": userName,
      };
}
