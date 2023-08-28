/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SplashPage extends StatelessWidget {
  final logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icons/elfLogo.png',
              width: 110.w,
              height: 160.w,
            )
          ],
        ),
      ),
    );
  }
}
