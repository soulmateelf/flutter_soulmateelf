import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/chat/settings/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ChatSettingsPage extends StatelessWidget {
  ChatSettingsPage({super.key});

  final logic = Get.put(ChatSettingsController());

  @override
  Widget build(BuildContext context) {
    return basePage("Chat Settings",
        backGroundImage: null,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius)),
                margin: EdgeInsets.only(bottom: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Simple",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22.sp,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Text(
                      "Can communicate with you normally, but may not remember the content of the communication",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color.fromRGBO(0, 0, 0, 0.48),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 245, 235, 0.48),
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      width: borderWidth,
                      color: primaryColor,
                    )),
                margin: EdgeInsets.only(bottom: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ordinary",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22.sp,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Text(
                      "Can communicate with you normally, may remember a little communication content",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color.fromRGBO(0, 0, 0, 0.48),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius)),
                margin: EdgeInsets.only(bottom: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Advanced",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22.sp,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Text(
                      "Can communicate with you normally, probably remember everything，Please look forward to…",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color.fromRGBO(0, 0, 0, 0.48),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
