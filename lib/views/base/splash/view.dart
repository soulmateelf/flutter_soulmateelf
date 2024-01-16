/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class SplashPage extends StatelessWidget {
  final logic = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return basePage('',
        showAppbar: false,
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: 570.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/image/logo.png',
                    width: 216.w,
                    height: 216.w,
                  ),
                  Positioned(
                      bottom: 25.w,
                      left: 0,
                      right: 0,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Never Alone Again',
                            style: TextStyle(
                                color: const Color.fromRGBO(21, 10, 0, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 22.sp),
                          )))
                ],
              )
            ],
          ),
        ));
  }
}
