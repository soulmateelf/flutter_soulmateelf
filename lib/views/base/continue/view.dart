/*
 * @Date: 2023-04-11 15:10:40
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:15:09
 * @FilePath: \soulmate\lib\views\base\continue\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class ContinuePage extends StatelessWidget {
  const ContinuePage({super.key});

  _continue() async {
    // print(Get.arguments);
    APPPlugin.logger.d(Get.arguments);
    final type = Get.arguments["type"];
    final email = Get.arguments["email"];
    final password = Get.arguments["password"];
    if (type == "register" || type == "forget") {
      final result = await NetUtils.diorequst("/base/login", 'post', params: {
        "email": email,
        "password": password,
      });

      if (result?.data?["code"] == 200) {
        Application.userInfo = result?.data?["data"];
        Application.token = result?.data["token"];
        APPPlugin.logger.d(result);
        Get.offAllNamed('/home');
      }else{
        exSnackBar("登录失败");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    final title = Get.arguments?["continuePageTitle"] ??
        "Your’ve successfully Created your password.";
    return Scaffold(
      appBar: backBar(),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 48.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 284.w),
              width: double.infinity,
              height: 94.h,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(78, 162, 79, 1))),
                  onPressed: () {
                    _continue();
                  },
                  child: Text(
                    "Continue to ELF",
                    style: TextStyle(fontSize: 36.sp),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
