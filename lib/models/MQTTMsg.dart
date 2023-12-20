// To parse this JSON data, do
//
//     final mqttMessageData = mqttMessageDataFromJson(jsonString);

import 'dart:convert';

MqttMessageData mqttMessageDataFromJson(String str) => MqttMessageData.fromJson(json.decode(str));

String mqttMessageDataToJson(MqttMessageData data) => json.encode(data.toJson());

class MqttMessageData {
  bool clear;
  String content;
  /// 0是日常消息与系统消息刷新，1是聊天未读数刷新
  int messageType;

  MqttMessageData({
    required this.clear,
    required this.content,
    required this.messageType,
  });

  factory MqttMessageData.fromJson(Map<String, dynamic> json) => MqttMessageData(
    clear: json["clear"],
    content: json["content"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "clear": clear,
    "content": content,
    "messageType": messageType,
  };
}
