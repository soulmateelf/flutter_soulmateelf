import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/customRole/step1/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class Step1Page extends StatelessWidget {
  Step1Page({super.key});

  final logic = Get.put(Step1Controller());

  @override
  Widget build(BuildContext context) {
    return basePage("Add your ELF",
        titleStyle: TextStyle(
          color: Colors.white,
          fontFamily: FontFamily.SFProRoundedBlod,
          fontWeight: FontWeight.bold,
          fontSize: 22.sp,
        ),
        leading: Container(),
        backGroundImage: null,
        backgroundColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              Image.asset(
                "assets/images/image/customRole.png",
                width: 428.w,
                height: 413.w,
              ),
              Text(
                "Welcome to Personal Customization,\n where you can customize according to\n your own preferences",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: FontFamily.SFProRoundedMedium,
                ),
              ),
              SizedBox(
                height: 62.w,
              ),
              Text(
                "For \$${logic.customRoleProduct?.amount ?? '--'}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.SFProRoundedBlod,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
              Text(
                "You can have your own ELF",
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.white,
                  fontFamily: FontFamily.SFProRoundedMedium,
                ),
              ),
              SizedBox(
                height: 24.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  height: 64.w,
                  width: double.infinity,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    color: primaryColor,
                    onPressed: () {
                      logic.goCustomRole();
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  height: 64.w,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.32),
                        fontSize: 20.sp,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
