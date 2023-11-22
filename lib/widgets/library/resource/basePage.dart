part of projectLibrary;

class BackGroundImageType {
  static const AssetImage white =
      AssetImage('assets/images/image/backgroundWhite.png');
  static const AssetImage gray =
      AssetImage('assets/images/image/backgroundGray.png');
}

Widget basePage(
  /// 标题
  String title, {
  /// 标题样式
  TextStyle? titleStyle,

  /// 显示背景图
  AssetImage? backGroundImage = BackGroundImageType.white,

  /// body
  required Widget child,

  /// 是否显示appbar
  bool showAppbar = true,

  /// 自定义左侧按钮
  Widget? leading,
  double? leadingWidth,

  /// 自定义右侧按钮
  List<Widget>? actions,

  /// 自定义头部背景色
  Color? backgroundColor,

  /// 自定义整个appBar
  AppBar? appBar,

  /// 默认灰色
  Color mainColor = const Color.fromRGBO(242, 242, 242, 1),

  ///是否开启避免底部被键盘遮挡
  bool? resizeToAvoidBottomInset,

  /// 自定义appbar 底部
  PreferredSizeWidget? bottom,
}) {
  return Container(
      decoration: BoxDecoration(
        color: backGroundImage != null ? Colors.transparent : mainColor,
        image: backGroundImage != null
            ? DecorationImage(
                alignment: Alignment.topCenter,
                image: backGroundImage, // 替换为你的图片路径
                fit: BoxFit.fitWidth,
              )
            : null,
      ),
      child: Scaffold(
        backgroundColor:
            backGroundImage != null ? Colors.transparent : mainColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: !showAppbar
            ? null
            : appBar ??
                AppBar(
                    leadingWidth: leadingWidth ?? 64.w,
                    elevation: 0,
                    toolbarHeight: 72.w,
                    shadowColor: backGroundImage != null
                        ? Colors.transparent
                        : mainColor,
                    centerTitle: true,
                    title: Text(
                      title,
                      style: titleStyle ?? TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 0.8),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.SFProRoundedBlod),
                    ),
                    leading: leading ??
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Image.asset(
                              "assets/images/icons/backIcon.png",
                              height: 44.w,
                              width: 44.w,
                            )),
                    actions: actions ?? [],
                    actionsIconTheme: const IconThemeData(color: Colors.black),
                    bottom: bottom,
                    backgroundColor: backGroundImage != null
                        ? Colors.transparent
                        : backgroundColor ?? mainColor),
        body: SafeArea(
          child: child,
        ),
      ));
}
