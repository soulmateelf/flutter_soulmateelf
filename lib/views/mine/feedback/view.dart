/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class FeedbackPage extends StatelessWidget {
  final logic = Get.put(FeedbackController());

  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    final List<XFile>? files = response.files;
    if (files != null) {
      // _handleLostFiles(files);
    } else {
      // _handleError(response.exception);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Have feedback? We'd love to hear it.",
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
                      padding: EdgeInsets.all(16.w),
                      child: SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                getLostData();
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
                            SizedBox(
                              width: 12.w,
                            ),
                            Container(
                              width: 112.w,
                              height: 112.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/image/chatBg.png"),
                                  fit: BoxFit.fill
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
                                    child: Image.asset(
                                      "assets/images/icons/delete.png",
                                      width: 26.w,
                                      height: 26.w,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
                      child: TextField(
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email for contact",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.32),
                              fontSize: 18.sp),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 4.w),
                        child: Row(
                          children: [
                            Checkbox(
                                value: true,
                                checkColor: Colors.white,
                                activeColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                onChanged: (v) {}),
                            Text(
                              "We may email you for more information or updates",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14.sp,
                              ),
                            )
                          ],
                        )),
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
                  onPressed: () {},
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
  }
}
