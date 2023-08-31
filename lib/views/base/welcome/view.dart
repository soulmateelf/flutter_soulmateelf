/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:15:44
 * @FilePath: \soulmate\lib\views\base\welcome\view.dart
 */
/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/views/base/welcome/logic.dart';
import 'package:get/get.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class WelcomePage extends StatelessWidget {
  final logic = Get.put(WelcomeLogic());
  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return WillPopScope(
        onWillPop: logic.dealBack,
        child: basePage('',
        showAppbar: false,
        showBgImage: true,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('welcome'),
              TextButton(onPressed: ()=>Get.toNamed('/login'), child: const Text('login')),
              TextButton(onPressed: ()=>Get.toNamed('/login'), child: const Text('sign up')),
            ],
          ),
        )
    ));
  }
}
