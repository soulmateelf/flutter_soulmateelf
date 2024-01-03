
/// 本地数据库聊天记录类
class LocalChatMessage {

  /// 自增id
  int? id;

  /// 本地聊天记录id
  String localChatId;

  /// 服务端聊天记录id
  String? serverChatId;

  /// 对话角色,这个角色是api层面的,这里只有两种user和assistant
  String role;

  /// 对话来源,0是默认值正常对话,1是角色主动打招呼发送的
  int origin;

  /// 聊天内容
  String content;

  /// 音频 url
  String? voiceUrl;

  /// 用户聊天输入的类型,0是文本,1是语音
  int inputType;

  /// 0正常状态, 1删除状态
  int status;

  /// 0发送中, 1已发送, 2发送失败，3已删除
  int localStatus;

  /// 创建时间
  int createTime;

  /// 更新时间
  int? updateTime;

  /// 备注
  String? remark;

  LocalChatMessage({
    this.id,
    required this.localChatId,
    this.serverChatId,
    required this.role,
    required this.origin,
    required this.content,
    this.voiceUrl,
    required this.inputType,
    required this.status,
    required this.localStatus,
    required this.createTime,
    this.updateTime,
    this.remark,
  });

  factory LocalChatMessage.fromJson(Map<String, dynamic> json) => LocalChatMessage(
        id: json["id"],
        localChatId: json["localChatId"],
        serverChatId: json["serverChatId"],
        role: json["role"],
        origin: json["origin"],
        content: json["content"],
        voiceUrl: json["voiceUrl"],
        inputType: json["inputType"],
        status: json["status"],
        localStatus: json["localStatus"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "localChatId": localChatId,
        "serverChatId": serverChatId,
        "role": role,
        "origin": origin,
        "content": content,
        "voiceUrl": voiceUrl,
        "inputType": inputType,
        "status": status,
        "localStatus": localStatus,
        "createTime": createTime,
        "updateTime": updateTime,
        "remark": remark,
      };
}
