
/// 本地数据库同步记录类
class SyncRecord {

  /// 自增id
  int? id;

  /// 更新记录id
  String recordId;

  /// 用户id
  String userId;

  /// 角色id
  String roleId;

  /// 最后一条聊天记录id
  String lastChatId;

  /// 最后一条聊天记录时间
  int lastChatTime;

  /// 创建时间
  int createTime;

  /// 更新时间
  int? updateTime;

  /// 备注
  String? remark;

  SyncRecord({
    this.id,
    required this.recordId,
    required this.userId,
    required this.roleId,
    required this.lastChatId,
    required this.lastChatTime,
    required this.createTime,
    this.updateTime,
    this.remark,
  });

  factory SyncRecord.fromJson(Map<String, dynamic> json) => SyncRecord(
        id: json["id"],
        recordId: json["recordId"],
        userId: json["userId"],
        roleId: json["roleId"],
        lastChatId: json["lastChatId"],
        lastChatTime: json["lastChatTime"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recordId": recordId,
        "userId": userId,
        "roleId": roleId,
        "lastChatId": lastChatId,
        "lastChatTime": lastChatTime,
        "createTime": createTime,
        "updateTime": updateTime,
        "remark": remark,
      };
}
