import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart' hide Topic;
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:soulmate/models/MQTTMsg.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

class Topic {
  String topic;
  Function(MqttMessageData message) callback;
  Topic(
    this.topic,
    this.callback,
  );
}

class XMqttClient {
  static final XMqttClient _instance = XMqttClient._();

  static XMqttClient get instance => _instance;

  static const host = '139.224.60.241'; //主机ip

  static const port = 1883; //端口号

  static const user = 'admin'; //用户

  static const pwd = 'public'; //密码

  static Map<String, Topic> topicMap = {};

  List<String> topics = [];

  MqttClient? client;

  XMqttClient._() {
    _initMqtt();
  }

  _initMqtt() async {
    //clientld 确保唯一性，否则如果两台机器的clientld 相同 则会连上立刻断开连接！！！
    String clientId = '${DateTime.now().millisecondsSinceEpoch}asc';
    client = await connect(clientId);
  }

  Future<MqttServerClient> connect(String cid) async {
    APPPlugin.logger.d('mqtt connect host = $host cid = $cid ');
    MqttServerClient client = MqttServerClient.withPort(host, cid, port);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs(user, pwd)
        .keepAliveFor(60) // 保持连接时间，单位为秒
        .withWillTopic('12345')
        .withWillMessage('Will message')
        .startClean() // 清理会话
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      APPPlugin.logger.d('Exception: $e');
      client.disconnect();
    }

    //用于监听已订阅主题的消息到达。
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      // 解码包含中文字符的字符串
      final String decodedString = utf8.decode(pt.codeUnits);
      if (topicMap.containsKey("${c[0].topic}")) {
        final topic = topicMap["${c[0].topic}"];
        if (topic is Topic) {
          topic.callback!(MqttMessageData.fromJson(jsonDecode(decodedString)));
        }
      }

      APPPlugin.logger
          .d('12345Received message: $decodedString from topic: ${c[0].topic}');
    });

    return client;
  }

  ///订阅一个主题
  _subscribe(Topic topic) {
    client?.subscribe(topic.topic, MqttQos.atLeastOnce);
    topicMap.addAll({
      "${topic.topic}": topic,
    });
  }

  ///订阅多个主题
  topicSubscribe(List<Topic> topics) async {
    this.topics.addAll(topics.map((e) => e.topic));
    if (client?.connectionStatus?.state == MqttConnectionState.connected) {
      topics.forEach((topic) {
        _subscribe(topic);
      });
    } else {
      //未连接成功 每隔3s重新订阅
      Future.delayed(const Duration(seconds: 3), () {
        topicSubscribe(topics);
      });
    }
  }

  ///取消订阅
  _unsubscribe() {
    client?.unsubscribe('topic/test');
  }

  ///断开连接
  _disconnect() {
    client?.disconnect();
  }

  // 连接成功
  void onConnected() {
    APPPlugin.logger.d('连接成功');
  }

// 连接断开
  void onDisconnected() {
    APPPlugin.logger.d('连接断开');
  }

// 订阅主题成功
  void onSubscribed(String topic) {
    APPPlugin.logger.d('订阅主题成功: $topic');
  }

// 订阅主题失败
  void onSubscribeFail(String topic) {
    APPPlugin.logger.d('订阅主题失败 $topic');
  }

// 成功取消订阅
  void onUnsubscribed(String? topic) {
    APPPlugin.logger.d('成功取消订阅: $topic');
  }

// 收到 PING 响应
  void pong() {
    APPPlugin.logger.d('收到 PING 响应 Ping response client callback invoked');
  }
}
