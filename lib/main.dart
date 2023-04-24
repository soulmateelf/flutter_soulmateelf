import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/route.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  ///这句代码是确保使用ios/android原生代码的这些插件有与flutter层交互的能力；
  ///如果app功能全部是flutter的，不依赖于其他插件，是不是就不需要呢？？
  ///参考链接:https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-do
  WidgetsFlutterBinding.ensureInitialized();

  /// 全局变量初始化
  await Application.initGlobe();

  /// 插件初始化
  await APPPlugin.initPlugin();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return configWidget(
        childWidget: KeyboardDismissOnTap(
            dismissOnCapturedTaps: false,
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,

              /// 主题
              theme: ThemeData(

                  /// 设置默认ios风格主题
                  platform: TargetPlatform.iOS,
                  primarySwatch: Colors.green,
                  iconTheme: const IconThemeData(
                      color: Color.fromRGBO(151, 151, 151, 1))),

              /// 跟随系统语言
              locale: const Locale("en", "US"),

              /// 配置错误的情况下使用的语言列表
              fallbackLocale: const Locale("en", "US"),
              initialRoute: '/splash',
              getPages: AppRoute.getPages,
              builder: EasyLoading.init(),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate, // This is required
              ],
            )));
  }

  /// Author kele
  /// Date 2022/1/14 16:39
  /// Description 比如上下拉这种需要全局配置的组件，放在上面的build方法里面太臃肿了，统一在这里配置
  /// param
  /// return
  /// UpdateUser kele
  /// UpdateDate 2022/1/14 16:39
  /// UpdateRemark
  Widget configWidget({required Widget childWidget}) {
    return RefreshConfiguration(
        headerBuilder: () => WaterDropHeader(
              complete: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.grey,
                      size: 15,
                    ),
                    Container(
                      width: 3.0,
                    ),
                    const Text('refresh success',
                        style: TextStyle(color: Colors.grey))
                  ]),
              failed: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 15,
                    ),
                    Container(
                      width: 3.0,
                    ),
                    const Text('something wrong', style: TextStyle(color: Colors.grey))
                  ]),
            ), // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个// 自定义底部指示器
        headerTriggerDistance: 60.0, // 头部触发刷新的越界距离
        maxOverScrollExtent: 80, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
        maxUnderScrollExtent: 0, // 底部最大可以拖动的范围
        enableScrollWhenRefreshCompleted:
            true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
        enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
        hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
        enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
        child: childWidget);
  }
}
