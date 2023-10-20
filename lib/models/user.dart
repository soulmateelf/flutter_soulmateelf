
/// 序列化最好的两个工具是json_serializable和freezed，都需要安装好几个依赖包，又繁琐，实在太烦人了
/// 还是自己写吧，冗余是有点，而且费事，但是有 Copilot 就没关系，没有助手的话，下面有个在线生成的工具，nice
/// 生成实体类的工具
/// https://app.quicktype.io/

/// 用户
class User {
  int id;
  /// 用户id
  String userId;
  /// 邮箱
  String email;
  /// 密码
  String? password;
  /// 昵称
  String? nickName;
  /// 头像
  String? avatar;
  /// 注册类型,0自主注册,1google,2facebook
  int? registerType;
  /// 聊天模式,0简单,1普通,2高级
  int model;
  /// 用户设定
  String? setting;
  /// 用户当前能量
  int? energy;
  /// 是否评价过
  int? evaluate;
  /// 用户是否开启紧急联系人选项,0未开启, 1已开启
  int? emergencyContact;
  /// 紧急联系人邮箱
  String? emergencyEmail;
  /// 0 正常状态，1删除状态
  int? status;
  /// 备注
  String? remark;
  int createTime;
  int? updateTime;

  User({
    required this.id,
    required this.userId,
    required this.email,
    this.password,
    this.nickName,
    this.avatar,
    this.registerType,
    required this.model,
    this.setting,
    this.energy,
    this.evaluate,
    this.emergencyContact,
    this.emergencyEmail,
    this.status,
    this.remark,
    required this.createTime,
    this.updateTime
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userId: json["userId"],
        email: json["email"],
        password: json["password"],
        nickName: json["nickName"],
        avatar: json["avatar"],
        registerType: json["registerType"],
        model: json["model"],
        setting: json["setting"],
        energy: json["energy"],
        evaluate: json["evaluate"],
        emergencyContact: json["emergencyContact"],
        emergencyEmail: json["emergencyEmail"],
        status: json["status"],
        remark: json["remark"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "email": email,
        "password": password,
        "nickName": nickName,
        "avatar": avatar,
        "registerType": registerType,
        "model": model,
        "setting": setting,
        "energy": energy,
        "evaluate": evaluate,
        "emergencyContact": emergencyContact,
        "emergencyEmail": emergencyEmail,
        "status": status,
        "remark": remark,
        "createTime": createTime,
        "updateTime": updateTime,
      };
}
