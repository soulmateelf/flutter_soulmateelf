import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/intro/recommend/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';

class IntroRecommendPage extends StatelessWidget {
  IntroRecommendPage({super.key});

  final logic = Get.put(IntroRecommendController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroRecommendController>(
      builder: (controller) {
        final role = controller.data[controller.index];
        return basePage(
          "Recommend",
          backGroundImage: const AssetImage(
            "assets/images/image/introBackground.png",
          ),
          titleStyle: TextStyle(
            color: Colors.white,
            fontFamily: FontFamily.SFProRoundedBlod,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
          leading: Container(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 443.w,
                child: Swiper(
                  viewportFraction: 0.8,
                  index: logic.index,
                  onIndexChanged: (index) {
                    logic.index = index;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final role = controller.data[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Container(
                        width: 307.w,
                        height: 443.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 36.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          image: DecorationImage(
                            image: AssetImage(role?['background']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${role?['name']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontFamily:
                                          FontFamily.SFProRoundedSemibold),
                                ),
                                Container(
                                  width: 39.w,
                                  height: 20.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/icons/heart.png",
                                        width: 16.w,
                                        height: 16.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontFamily:
                                              FontFamily.SFProRoundedMedium,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                            Container(
                              width: 65.w,
                              height: 22.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.w),
                                color: Colors.white.withOpacity(0.56),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${role['age']}",
                                    style: TextStyle(
                                      color: Color.fromRGBO(55, 61, 67, 1),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  role["gender"] == "male"
                                      ? Icon(
                                          Icons.male_outlined,
                                          color: Colors.blue,
                                          size: 20.sp,
                                        )
                                      : Icon(
                                          Icons.female_outlined,
                                          color: Colors.pinkAccent,
                                          size: 20.sp,
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.w,
                            ),
                            Text(
                              "${role['hobby']}",
                              style: TextStyle(
                                color: Color.fromRGBO(242, 242, 242, 0.64),
                                fontSize: 14.sp,
                                fontFamily: FontFamily.SFProRoundedMedium,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: controller.data.length,
                  controller: logic.swiperController,
                ),
              ),
              SizedBox(
                height: 24.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  width: 388.w,
                  height: 183.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/image/recommendBg.png")),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${role['description']}",
                        style: TextStyle(
                          color: Color.fromRGBO(242, 242, 242, 1),
                          height: 1.2,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 12.w,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                            child: Container(
                              width: 275.w,
                              height: 34.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/image/introButtonBg.png"))),
                              child: Text(
                                "${role['skills']}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -9.w,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 17.w,
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(2.w),
                                ),
                                child: Text(
                                  "SKILLS",
                                  style: TextStyle(
                                    color: Color.fromRGBO(242, 242, 242, 1),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 18.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.data.map((e) {
                  return Container(
                    width: 8.w,
                    height: 8.w,
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      color: controller.data[controller.index] == e
                          ? primaryColor
                          : Colors.white,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 18.w,
              ),
              Container(
                width: 230.w,
                child: CupertinoButton(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(28.w),
                  padding: EdgeInsets.symmetric(vertical: 15.w),
                  pressedOpacity: 0.8,
                  onPressed: () {
                    controller.chatNow(role['roleId']);
                  },
                  child: Text(
                    "Chat now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
