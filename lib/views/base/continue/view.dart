import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class ContinuePage extends StatelessWidget {
  const ContinuePage({super.key});

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
                    Get.toNamed('/home');
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
