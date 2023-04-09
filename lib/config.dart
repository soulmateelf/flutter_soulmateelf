/// Author: kele
/// Date: 2022-03-07 13:31:49
/// LastEditors: kele
/// LastEditTime: 2022-03-13 16:01:04
/// Description:

///在这里设置jpush的key，通过极光插件初始化并不会覆盖android项目的key，
///所以正式打包的时候还是需要手动修改android/app/build.gradle   中的    JPUSH_APPKEY
class ProjectConfig {
  /// debug or not
  bool isDebug = false;

  Map baseConfig = {
    'userAgreementUrl':
        'http://pm.timcloud.club/html/userAgreement.html', //用户协议
    'privacyClauseUrl':
        'http://pm.timcloud.club/html/privacyClause.html', //隐私条款
    'packageName': 'cn.rayeye.flucrpm', // 包名
  };

  Map debugConfig = {
    'BaseUrl': 'http://42.192.68.186:9001/api/', //测试环境,
  };
  Map releaseConfig = {
    'BaseUrl': 'http://api.timcloud.club/api', //生产环境
  };

  // 静态变量_instance，存储唯一对象
  static ProjectConfig? _instance;

  // 获取对象
  static ProjectConfig? getInstance() {
    _instance ??= ProjectConfig._internal();
    return _instance;
  }

  // 私有的命名式构造方法，通过它实现一个类 可以有多个构造函数，
  // 子类不能继承internal
  // 不是关键字，可定义其他名字
  ProjectConfig._internal() {
    baseConfig.addAll(isDebug ? debugConfig : releaseConfig);
  }
}
