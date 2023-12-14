import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';
import 'controller.dart';

class Step2Page extends StatelessWidget {
  Step2Page({super.key});

  final logic = Get.put(Step2Controller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Step2Controller>(
      builder: (controller) {
        return basePage(
          "Custom role",
          backGroundImage: null,
          backgroundColor: Colors.white,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(
                      24.w,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 112.w,
                                  height: 112.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(112.w),
                                    border: Border.all(
                                      width: 3.w,
                                      color: borderColor,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: controller.avatar != null
                                        ? Image.file(
                                            File(controller.avatar!.path),
                                            width: 112.w,
                                            height: 112.w,
                                          ).image
                                        : null,
                                    child: controller.avatar == null?Image.asset(
                                      "assets/images/icons/customRoleUserIcon.png",
                                      width: 38.w,
                                      height: 42.w,
                                    ):null,
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.uploadAvatar();
                                      },
                                      child: Container(
                                        width: 32.w,
                                        height: 32.w,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(32.w),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.white,
                                          size: 20.w,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.w,
                          ),
                          makeTitle("Name"),
                          Container(
                            height: 64.w,
                            child: TextField(
                              cursorColor: primaryColor,
                              controller: controller.nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: borderColor,
                                    width: borderWidth,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    borderRadius,
                                  ),
                                ),
                                hintText: "Enter",
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.32),
                                  fontSize: 18.sp,
                                  fontFamily: FontFamily.SFProRoundedMedium,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: borderWidth,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    borderRadius,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: borderColor,
                                    width: borderWidth,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    borderRadius,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32.w,
                          ),
                          makeTitle("Gender"),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setGender("male");
                                  },
                                  child: Container(
                                    height: 64.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(borderRadius),
                                        border: Border.all(
                                          color: controller.genderType == "male"
                                              ? primaryColor
                                              : borderColor,
                                          width: borderWidth,
                                        )),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.male_outlined,
                                      color: controller.genderType == "male"
                                          ? primaryColor
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 13.w,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setGender("female");
                                  },
                                  child: Container(
                                    height: 64.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(borderRadius),
                                        border: Border.all(
                                          color:
                                              controller.genderType == "female"
                                                  ? primaryColor
                                                  : borderColor,
                                          width: borderWidth,
                                        )),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.female_outlined,
                                      color: controller.genderType == "female"
                                          ? primaryColor
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 13.w,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.setGender("other");
                                  },
                                  child: Container(
                                    height: 64.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(borderRadius),
                                        border: Border.all(
                                          color:
                                              controller.genderType == "other"
                                                  ? primaryColor
                                                  : borderColor,
                                          width: borderWidth,
                                        )),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/images/icons/otherGender.png",
                                      width: 24.w,
                                      height: 24.w,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 32.w,
                          ),
                          makeTitle("Age"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 292.w,
                                child: SliderTheme(
                                  data: SliderThemeData(
                                      thumbColor: Colors.white,
                                      activeTickMarkColor: primaryColor,
                                      activeTrackColor: primaryColor,
                                      inactiveTrackColor: borderColor,
                                      trackHeight: 3.w,
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 0)),
                                  child: CupertinoSlider(
                                    activeColor: primaryColor,
                                    value: controller.age,
                                    min: 1,
                                    max: 99,
                                    onChanged: (v) {
                                      controller.age = v;
                                      controller.update();
                                    },
                                  ),
                                ),
                              ),
                              Text("${controller.age.toInt()}"),
                            ],
                          ),
                          SizedBox(
                            height: 50.w,
                          ),
                          makeTitle("Hobby"),
                          TextField(
                            maxLines: 3,
                            cursorColor: primaryColor,
                            controller: controller.hobbyController,
                            decoration: InputDecoration(
                              hintText: "Enter",
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.32),
                                fontSize: 18.sp,
                                fontFamily: FontFamily.SFProRoundedMedium,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: borderColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: borderColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32.w,
                          ),
                          makeTitle("Character introduction"),
                          TextField(
                            maxLines: 5,
                            cursorColor: primaryColor,
                            controller: controller.introductionController,
                            decoration: InputDecoration(
                              hintText: "Enter",
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.32),
                                fontSize: 18.sp,
                                fontFamily: FontFamily.SFProRoundedMedium,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: borderColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: borderColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32.w,
                          ),
                          makeTitle("Anything else to add"),
                          TextField(
                            maxLines: 3,
                            cursorColor: primaryColor,
                            controller: controller.remarkController,
                            decoration: InputDecoration(
                              hintText: "Enter",
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.32),
                                fontSize: 18.sp,
                                fontFamily: FontFamily.SFProRoundedMedium,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: borderColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: borderColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: borderWidth,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Container(
                  height: 126.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${logic.customRoleProduct?.amount??'--'}",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 24.sp,
                          fontFamily: FontFamily.SFProRoundedMedium,
                        ),
                      ),
                      Container(
                        width: 200.w,
                        height: 64.w,
                        child: MaterialButton(
                          onPressed: () {
                            controller.submit();
                          },
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              borderRadius,
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamily.SFProRoundedBlod,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget makeTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.64),
          fontFamily: FontFamily.SFProRoundedMedium,
        ),
      ),
    );
  }
}
