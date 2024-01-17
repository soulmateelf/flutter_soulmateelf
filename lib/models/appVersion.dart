/// app版本更新
class AppVersion {
  int id;
  /// 版本id
  String appVersionId;

  /// 平台
  String platform;

  /// 版本名称
  String version;

  /// 版本号
  int buildId;

  /// 升级内容
  String content;

  /// 是否强制升级，0不是强制更新，1强制更新版本
  int isForce;

  /// 下载链接
  String downLoadUrl;

  /// 备注
  String? remark;
  /// 0 正常状态，1删除状态
  int status;
  int createTime;
  int? updateTime;

  AppVersion({
    required this.id,
    required this.appVersionId,
    required this.platform,
    required this.version,
    required this.buildId,
    required this.content,
    required this.isForce,
    required this.downLoadUrl,
    this.remark,
    required this.status,
    required this.createTime,
    this.updateTime
  });

  factory AppVersion.fromJson(Map<String, dynamic> json) => AppVersion(
        id: json["id"],
        appVersionId: json["appVersionId"],
        platform: json["platform"],
        version: json["version"],
        buildId: json["buildId"],
        content: json["content"],
        isForce: json["isForce"],
        downLoadUrl: json["downLoadUrl"],
        remark: json["remark"],
        status: json["status"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appVersionId": appVersionId,
        "platform": platform,
        "version": version,
        "buildId": buildId,
        "content": content,
        "isForce": isForce,
        "downLoadUrl": downLoadUrl,
        "remark": remark,
        "status": status,
        "createTime": createTime,
        "updateTime": updateTime,
      };
}
