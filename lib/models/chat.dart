class ChatHistory {
  int? id;
  String chatId;

  /// 对话角色,这个角色是api层面的,这里只有两种user和assistant
  String role;

  /// 对话来源,0是默认值正常对话,1是角色主动打招呼发送的
  int origin;

  /// 打招呼id
  String? roleGreetId;

  /// 默认是已读状态,角色主动打招呼是未读,其他类型的默认已读,0未读,1已读
  int? readStatus;

  /// 聊天内容
  String content;

  /// 角色id
  String roleId;

  /// 用户聊天输入的类型,0是文本,1是语音
  int inputType;

  /// gpt原始记录id
  String? gptLogId;

  /// 0正常状态, 1删除状态
  int status;

  /// 备注
  String? remark;
  int createTime;
  int? updateTime;

  /// 音频 url
  String? voiceUrl;

  /// 音频大小
  double? voiceSize;

  ChatHistory({
    this.id,
    required this.chatId,
    required this.role,
    required this.origin,
    this.roleGreetId,
    this.readStatus,
    this.remark,
    required this.content,
    required this.roleId,
    required this.inputType,
    this.gptLogId,
    required this.status,
    required this.createTime,
    this.updateTime,
    this.voiceUrl,
    this.voiceSize,
  });

  factory ChatHistory.fromJson(Map<String, dynamic> json) => ChatHistory(
        id: json["id"],
        chatId: json["chatId"],
        role: json["role"],
        origin: json["origin"],
        roleGreetId: json["roleGreetId"],
        readStatus: json["readStatus"],
        remark: json["remark"],
        content: json["content"],
        roleId: json["roleId"],
        inputType: json["inputType"],
        gptLogId: json["gptLogId"],
        status: json["status"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
        voiceUrl: json["voiceUrl"],
        voiceSize: json["voiceSize"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatId": chatId,
        "role": role,
        "origin": origin,
        "roleGreetId": roleGreetId,
        "readStatus": readStatus,
        "remark": remark,
        "content": content,
        "roleId": roleId,
        "inputType": inputType,
        "gptLogId": gptLogId,
        "status": status,
        "createTime": createTime,
        "updateTime": updateTime,
        "voiceUrl": voiceUrl,
        "voiceSize": voiceSize,
      };
}
