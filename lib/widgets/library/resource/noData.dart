import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataBox extends StatelessWidget {
  const NoDataBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Text(
        '暂无数据',
        style: TextStyle(
          color: const Color.fromRGBO(0, 0, 0, 0.72),
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
