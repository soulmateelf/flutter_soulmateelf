part of projectLibrary;

/// Author trevor
/// Date 2/14/22 2:00 PM
/// Description 列表搜索无数据缺省页

Widget listViewNoDataPage(
    {@required bool? isShowNoData,

    ///是否展示缺省页
    @required Widget? child,

    ///子视图
    String? omit

    ///提示语
    }) {
  return isShowNoData == true
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icons/no_data.png',
                width: 41.w, height: 53.w),
            Text(omit ?? '没有找到结果',
                style:
                    TextStyle(fontSize: 16.sp, color: const Color(0x3D000000)))
          ],
        )
      : child!;
}
