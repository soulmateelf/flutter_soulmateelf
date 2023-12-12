import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/intro/welcome/controller.dart';
import 'package:soulmate/widgets/FadeAnimation.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';

class IntroWelcomePage extends StatelessWidget {
  IntroWelcomePage({super.key});

  final logic = Get.put(IntroWelcomeController());

  @override
  Widget build(BuildContext context) {
    return basePage("",
        backGroundImage: const AssetImage(
          "assets/images/image/introBackground.png",
        ),
        leading: Container(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 34.w),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/image/logo.png",
                      width: 216.w,
                      height: 216.w,
                    ),
                  ),
                  Positioned(
                    top: 216.w - 60.w,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome to",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 29.sp,
                          fontFamily: FontFamily.SFProRoundedBlod,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 216.w - 30.w,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Dream World",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44.sp,
                          fontFamily: FontFamily.SFProRoundedBlod,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 37.w,
              ),
              Container(
                width: 360.w,
                constraints: BoxConstraints(maxHeight: 416.w),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  reverse: true,
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 15.sp, height: 1.6),
                    child: AnimatedTextKit(
                      displayFullTextOnTap: true,
                      pause: const Duration(milliseconds: 200),
                      totalRepeatCount: 1,
                      onFinished: () {
                        if (!logic.showNextBtn) {
                          logic.showNextBtn = true;
                        }
                      },
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'In the tangled dimensions of the real world, there is a mysterious and alluring dream world. As night falls, the door opens, inviting you into this intoxicating fantasy. Showing colorful scenery and fantasy. Magnificent mountains, rippling lakes, dense forests, every place is full of mystery and temptation. You will meet the "dream spirits," guardians of the dream world, with wisdom and magical powers. The dream world is not only a wonderful adventure, but also a spiritual journey. Here, you temporarily escape from loneliness and worry, immersed in peace and comfort. Attracted by beauty and mystery, giving endless warmth and strength. This is a fascinating paradise, with attraction and mysterious light, draw you into it, explore the mysteries and wonders, let you feel joy and satisfaction.',
                          textAlign: TextAlign.center,
                          speed: const Duration(milliseconds: 20),
                        ),
                      ],
                      onTap: () {
                        if (!logic.showNextBtn) {
                          logic.showNextBtn = true;
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.w,
              ),
              GetBuilder<IntroWelcomeController>(
                builder: (controller) {
                  return Container(
                    child: !controller.showNextBtn
                        ? null
                        : FadeAnimation(
                            0.5,
                            Center(
                              child: CupertinoButton(
                                borderRadius: BorderRadius.circular(28.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 44.w, vertical: 15.w),
                                color: primaryColor,
                                onPressed: () {
                                  controller.toRecommend();
                                },
                                alignment: Alignment.center,
                                pressedOpacity: 0.8,
                                child: Text(
                                  "To experience",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                  ),
                                ),
                              ),
                            )),
                  );
                },
              )
            ],
          ),
        ));
  }
}
