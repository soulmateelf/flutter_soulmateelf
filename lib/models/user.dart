/*class User{
  int id;
  String userId;
  String email;
  String password;
  /// 昵称
  String nickName;
  /// 头像
  String avatar;
  /// 注册类型,0自主注册,1google,2facebook
  String registerType;
  /// 聊天模式,0简单,1普通,2高级
  String model;
  /// 用户设定
  String setting;
  /// 用户当前能量
  int energy;
  /// 用户是否开启紧急联系人选项,0未开启, 1已开启
  int emergencyContact;
  /// 紧急联系人邮箱
  String emergencyEmail;
  /// 0 正常状态，1删除状态
  int status;
  /// 备注
  String remark;
  int createTime;
  int updateTime;

  User();

  ///将Map转成User对象
  User.fromJson(Map<String,dynamic> map)
      :id=map['id'],
      name=map['name'],
      age=map['age'],
      role=Role.fromJson(map['role']);
  //将User对象转化成Map
  Map<String,dynamic> toJson()=>{
    'id':id,
    'name':name,
    'age':age,
    'role':role.toJson()
  };


}*/
import 'dart:convert';
Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));
String welcomeToJson(Welcome data) => json.encode(data.toJson());
class Welcome {
  String userId;
  int sdss;

  Welcome({
    required this.userId,
    required this.sdss,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    userId: json["userId"],
    sdss: json["sdss"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "sdss": sdss,
  };
}

class Role{
  String id;
  String roleName;
  int roleAge;

  Role(this.id,this.roleName,this.roleAge);
  ///重点来了
  ///将Map转成User对象
  Role.fromJson(Map<String,dynamic> map)
      :id=map['id'],
        roleName=map['roleName'],
        roleAge=map['roleAge'];
  //将User对象转化成Map
  Map<String,dynamic> toJson()=>{
    'id':id,
    'roleName':roleName,
    'roleAge':roleAge,
  };
}