// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  int id;
  String messageId;
  String title;
  int messageType;
  int readStatus;
  dynamic remark;
  dynamic updateTime;
  String userId;
  String content;
  int subType;
  int status;
  int createTime;

  Message({
    required this.id,
    required this.messageId,
    required this.title,
    required this.messageType,
    required this.readStatus,
    required this.remark,
    required this.updateTime,
    required this.userId,
    required this.content,
    required this.subType,
    required this.status,
    required this.createTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    messageId: json["messageId"],
    title: json["title"],
    messageType: json["messageType"],
    readStatus: json["readStatus"],
    remark: json["remark"],
    updateTime: json["updateTime"],
    userId: json["userId"],
    content: json["content"],
    subType: json["subType"],
    status: json["status"],
    createTime: json["createTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "messageId": messageId,
    "title": title,
    "messageType": messageType,
    "readStatus": readStatus,
    "remark": remark,
    "updateTime": updateTime,
    "userId": userId,
    "content": content,
    "subType": subType,
    "status": status,
    "createTime": createTime,
  };
}
