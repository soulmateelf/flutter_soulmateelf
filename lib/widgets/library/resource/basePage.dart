part of projectLibrary;

Widget basePage(
  /// 标题
  String title,
  {
    /// 显示背景图
    bool showBgImage = false,

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
          // color: showBgImage?Colors.transparent:mainColor,
          color: Colors.transparent,
          image: showBgImage?const DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/image/background.png'), // 替换为你的图片路径
            fit: BoxFit.fitWidth,
          ):null,
        ),
        child:Scaffold(
          backgroundColor: showBgImage?Colors.transparent:mainColor,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: !showAppbar ? null : appBar ??
                    AppBar(
                        leadingWidth: leadingWidth??64.w,
                        elevation: 0,
                        shadowColor: showBgImage?Colors.transparent:mainColor,
                        centerTitle: true,
                        title: Text(
                          title,
                          style: TextStyle(color: const Color.fromRGBO(0, 0, 0, 0.8),fontSize: 22.sp,fontWeight: FontWeight.bold),
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
                                )
                            ),
                        actions: actions ?? [],
                        actionsIconTheme: const IconThemeData(color: Colors.black),
                        bottom: bottom,
                        backgroundColor: showBgImage?Colors.transparent:backgroundColor ?? mainColor
                    ),
            body: SafeArea(child: child),
        ));
}
