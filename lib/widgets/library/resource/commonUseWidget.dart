part of projectLibrary;

///0.5像素高的横线通用组件
Widget commonSizedBox({
  double? height,
  Color? color,
}) {
  return SizedBox(
    width: double.infinity,
    height: height ?? 0.5.w,
    child: Container(
      color: color ?? const Color(0x1F000000),
    ),
  );
}

/// Author trevor
/// Date 2/16/22 2:12 PM
/// Description 通用页面底部的按钮
/// param
/// return
/// UpdateUser trevor
/// UpdateDate 2/16/22 2:12 PM
/// UpdateRemark
Widget commonBottomBtn(
    {String? title,

    ///标题
    Function? callBack

    ///点击回调事件
    }) {
  return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0x1F000000)))),
        child: GestureDetector(
          onTap: () {
            if (callBack != null) {
              callBack();
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 44.w,
            decoration: const BoxDecoration(
                color: Color(0xFF007BF5),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(title ?? '',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
        ),
      ));
}
