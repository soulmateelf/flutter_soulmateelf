import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return basePage("About",
        backGroundImage: null,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.w)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed("/privacyPolicy");
                      },child: Container(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 18.sp,
                              ),
                            ),
                            Image.asset(
                              "assets/images/icons/right_arrow.png",
                              width: 20.w,
                              height: 20.w,
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed("/termsOfService");
                      },child: Container(
                      padding: EdgeInsets.all(20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Terms of Service",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18.sp,
                            ),
                          ),
                          Image.asset(
                            "assets/images/icons/right_arrow.png",
                            width: 20.w,
                            height: 20.w,
                          )
                        ],
                      ),
                    ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
