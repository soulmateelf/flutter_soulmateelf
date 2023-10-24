import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class SuccessfullyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("",
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 93.w,
              ),
              Image.asset(
                "assets/images/image/successfully.png",
                width: 162.w,
                height: 162.w,
              ),
              SizedBox(
                height: 44.w,
              ),
              Text(
                """Your’ve successfully\nchanged your password.""",
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: 27.sp),
              ),
              SizedBox(
                height: 259.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                height: 64.w,
                child: MaterialButton(
                  minWidth: double.infinity,
                  enableFeedback: true,
                  textColor: const Color.fromRGBO(0, 0, 0, 0.24),
                  onPressed: () {
                    Get.offAllNamed('/login');
                  },
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Text('Continue to ELF',
                      style: TextStyle(fontSize: 18.sp, color: Colors.white)),
                ),
              )
            ],
          ),
        ));
  }
}
