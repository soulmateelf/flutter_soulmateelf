part of projectLibrary;

Widget basePage(
  String title,

  /// 标题
  {
  required Widget child,

  /// body
  Widget? leading,
  double? leadingWidth,

  // 是否显示appBar
  bool showAppBar = true,

  /// 自定义左侧按钮
  List<Widget>? actions,

  /// 自定义右侧按钮
  Color? backgroundColor,

  /// 自定义头部背景色
  AppBar? appBar,

  /// 自定义整个appBar
  double elevation = 1,
  Color bodyColor = const Color.fromRGBO(242, 242, 242, 1),

  ///是否开启避免底部被键盘遮挡
  bool? resizeToAvoidBottomInset,

  // 自定义appbar 底部
  PreferredSizeWidget? bottom,

  /// 自定义头部背景色
}) {
  return Scaffold(
      backgroundColor: bodyColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: !showAppBar
          ? null
          : appBar ??
              AppBar(
                  leadingWidth: leadingWidth,
                  elevation: elevation,
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.12),
                  centerTitle: true,
                  title: Text(
                    title,
                    style: const TextStyle(color: Colors.black),
                  ),
                  leading: leading ??
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 44.w,
                            color: const Color.fromRGBO(151, 151, 151, 1),
                          )),
                  actions: actions ?? [],
                  actionsIconTheme: const IconThemeData(color: Colors.black),
                  bottom: bottom,
                  backgroundColor: backgroundColor ?? Colors.white),
      body: SafeArea(child: child));
}
