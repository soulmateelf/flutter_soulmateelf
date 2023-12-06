import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/chat/details/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ChatDetailsPage extends StatelessWidget {
  ChatDetailsPage({super.key});

  final logic = Get.put(ChatDetailsController());

  @override
  Widget build(BuildContext context) {
    return basePage("Details",
        backGroundImage: null,
        child: Container(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/chatBackground");
                        },
                        child: Container(
                          height: 64,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Background",
                                style: TextStyle(
                                    color: textColor, fontSize: 18.sp),
                              ),
                              Image.asset(
                                "assets/images/icons/right_arrow.png",
                                width: 24.w,
                                height: 24.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/chatBackground");
                        },
                        child: Container(
                          height: 64,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Search Chat History",
                                style: TextStyle(
                                    color: textColor, fontSize: 18.sp),
                              ),
                              Image.asset(
                                "assets/images/icons/right_arrow.png",
                                width: 24.w,
                                height: 24.w,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
