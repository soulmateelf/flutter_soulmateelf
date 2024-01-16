/// Author: kele
/// Date: 2023-04-25 20:04:35
/// LastEditors: kele
/// LastEditTime: 2023-05-04 18:54:38
/// Description:

class ProjectConfig {
  /// debug or not
  bool isDebug = true;
  ///基本配置
  Map baseConfig = {
    'packageName': 'cn.soulmate.elf', // 包名
  };
  /// 测试环境
  Map debugConfig = {
    'BaseUrl': 'http://54.177.205.15/api',
    'SQLiteDBVersion': 1,
    'mqttHost': '139.224.60.241',
    'mqttPort': 1883,
    'mqttUserName': 'admin',
    'mqttPassword': 'public',
  };
  /// 生产环境
  Map releaseConfig = {
    'BaseUrl': 'http://soulmate.health/api',
    'SQLiteDBVersion': 1,
    'mqttHost': '139.224.60.241',
    'mqttPort': 1883,
    'mqttUserName': 'admin',
    'mqttPassword': 'public',
  };

  /// 静态变量_instance，存储唯一对象
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
