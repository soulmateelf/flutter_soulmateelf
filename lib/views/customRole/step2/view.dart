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
    return basePage(
      "Custom role",
      backGroundImage: null,
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
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
                                child: Image.asset(
                                  "assets/images/icons/customRoleUserIcon.png",
                                  width: 38.w,
                                  height: 42.w,
                                ),
                              ),
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(32.w)),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20.w,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.w,
                      ),
                      makeTitle("Personality"),
                      Container(
                        height: 64.w,
                        child: TextField(
                          cursorColor: primaryColor,
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
                            hintText: "Name",
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
                            child: Container(
                              height: 64.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  border: Border.all(
                                    color: primaryColor,
                                    width: borderWidth,
                                  )),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.male_outlined,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          Expanded(
                            child: Container(
                              height: 64.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  border: Border.all(
                                    color: borderColor,
                                    width: borderWidth,
                                  )),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.female_outlined,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          Expanded(
                            child: Container(
                              height: 64.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  border: Border.all(
                                    color: borderColor,
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
                        ],
                      ),
                      SizedBox(
                        height: 32.w,
                      ),
                      makeTitle("Age / Age range"),
                      GetBuilder<Step2Controller>(
                        builder: (controller) {
                          return Row(
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
                                    value: 50,
                                    min: 1,
                                    max: 99,
                                    onChanged: (v) {},
                                  ),
                                ),
                              ),
                              Text("${50}"),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 50.w,
                      ),
                      makeTitle("Hobby"),
                      TextField(
                        maxLines: 3,
                        cursorColor: primaryColor,
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
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: borderColor,
                              width: borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                              width: borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(borderRadius),
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
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: borderColor,
                              width: borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                              width: borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(borderRadius),
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
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: borderColor,
                              width: borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                              width: borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(borderRadius),
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
            Divider(
              height: 1,
            ),
            Container(
              height: 126.w,
              padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$0.00",
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
                        showDialog(
                            context: context,
                            builder: (_) {
                              return MakeDialog(
                                  iconWidget: Image.asset(
                                      "assets/images/image/successfully.png"),
                                  content: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Are you sure you want to pay \$199 to customize your ELF? And don't worry, after paying you will have three chances to amend or get a half price refund.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: textColor,
                                              fontSize: 22.sp,
                                              fontFamily: FontFamily
                                                  .SFProRoundedMedium),
                                        ),
                                        SizedBox(
                                          height: 32.w,
                                        ),
                                        Container(
                                          height: 64.w,
                                          width: double.infinity,
                                          child: MaterialButton(
                                            color: primaryColor,
                                            onPressed: () {},
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      borderRadius),
                                            ),
                                            child: Text(
                                              "Pay now",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.sp,
                                                fontFamily:
                                                    FontFamily.SFProRoundedBlod,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 64.w,
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.32),
                                                fontSize: 20.sp,
                                                fontFamily:
                                                    FontFamily.SFProRoundedBlod,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            });
                      },
                      color: Color.fromRGBO(245, 245, 245, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.24),
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
