/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class FeedbackPage extends StatelessWidget {
  final logic = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackController>(
      builder: (controller) {
        return basePage('Feedback',
            backGroundImage: null,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 320.w,
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          child: TextField(
                            maxLines: 10,
                            controller: controller.contentController,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "Have feedback? We'd love to hear it.",
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, .32),
                                  fontSize: 18.sp,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            "Upload relevant pictures or information",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.48),
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Container(
                          height: 144.w,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...renderFiles(),
                                  Offstage(
                                    offstage: controller.files.length >= 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        logic.pickerFile();
                                      },
                                      child: Container(
                                        width: 112.w,
                                        height: 112.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: borderWidth,
                                            color: borderColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.w,
                                          ),
                                        ),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 4.w),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: controller.checkSend,
                                    checkColor: Colors.white,
                                    activeColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.w),
                                    ),
                                    onChanged: (v) {
                                      controller.checkSend = v!;
                                      controller.update();
                                    }),
                                Text(
                                  "We may email you for more information or updates",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 14.sp,
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 8.w,
                        ),
                        Offstage(
                          offstage: !controller.checkSend,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 4.w),
                            child: TextField(
                              cursorColor: primaryColor,
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email for contact",
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.32),
                                    fontSize: 18.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 33.w,
                  ),
                  Container(
                    width: double.infinity,
                    height: 64.w,
                    child: MaterialButton(
                      onPressed: () {
                        controller.sendFeedback();
                      },
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Text(
                        "Send",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.SFProRoundedBlod,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  List<Widget> renderFiles() {
    List<Widget> list = [];
    logic.files.forEach((file) {
      list.add(
        Container(
          width: 112.w,
          height: 112.w,
          margin: EdgeInsets.only(right: 8.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(
                File(file.path),
              ),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              width: borderWidth,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -13,
                right: -13,
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      logic.removeFile(file);
                    },
                    child: Image.asset(
                      "assets/images/icons/delete.png",
                      width: 26.w,
                      height: 26.w,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
    return list;
  }
}
