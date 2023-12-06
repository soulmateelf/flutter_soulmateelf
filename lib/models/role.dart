/// 角色
class Role {
  /// 角色id
  String roleId;

  /// 名称
  String? name;

  /// 年龄
  int? age;

  /// 性别
  String? gender;

  /// 头像
  String? avatar;

  /// 爱好
  String? hobby;

  /// 角色介绍
  String? description;

  /// 角色设定
  String? setting;

  /// 来源,0系统创建,1客户定制
  int? origin;

  /// 备注
  String? remark;
  String? roleUser;
  int? intimacy;

  /// 最后一次聊天时间
  int? endSendTime;

  /// 最后一次聊天内容
  String? content;
  String? backgroundImageUrl;

  Role({
    required this.roleId,
    this.name,
    this.age,
    this.gender,
    this.avatar,
    this.hobby,
    this.description,
    this.setting,
    this.origin,
    this.remark,
    this.roleUser,
    this.intimacy,
    this.endSendTime,
    this.content,
    this.backgroundImageUrl,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        avatar: json["avatar"],
        hobby: json["hobby"],
        description: json["description"],
        setting: json["setting"],
        origin: json["origin"],
        remark: json["remark"],
        roleUser: json["roleUser"],
        intimacy: json["intimacy"],
        endSendTime: json["endSendTime"],
        content: json["content"],
        backgroundImageUrl: json['backgroundImageUrl'],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "name": name,
        "age": age,
        "gender": gender,
        "avatar": avatar,
        "hobby": hobby,
        "description": description,
        "setting": setting,
        "origin": origin,
        "remark": remark,
        "roleUser": roleUser,
        "intimacy": intimacy,
        "endSendTime": endSendTime,
        "content": content,
        "backgroundImageUrl": backgroundImageUrl,
      };
}
