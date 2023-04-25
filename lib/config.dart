/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:53:06
 * @FilePath: \soulmate\lib\config.dart
 */
/// Author: kele
/// Date: 2022-03-07 13:31:49
/// LastEditors: kele
/// LastEditTime: 2022-03-13 16:01:04
/// Description:

///在这里设置jpush的key，通过极光插件初始化并不会覆盖android项目的key，
///所以正式打包的时候还是需要手动修改android/app/build.gradle   中的    JPUSH_APPKEY
class ProjectConfig {
  /// debug or not
  bool isDebug = true;

  Map baseConfig = {
    'PrivacyPolicyUrl': 'https://icyberelf.com/PrivacyPolicy.html', //隐私协议
    'TermsofServiceUrl': 'https://icyberelf.com/TermsofService.html', //服务条款
    'packageName': 'com.donganyun.elf', // 包名
  };

  Map debugConfig = {
    // 'BaseUrl': 'http://192.168.244.161:8787', //测试环境,
     'BaseUrl': 'http://192.168.156.111:8787', //测试环境,
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
