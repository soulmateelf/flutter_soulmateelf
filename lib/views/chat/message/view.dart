/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class MessagePage extends StatelessWidget {
  final logic = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return basePage('Messages',
        backGroundImage: null,
        backgroundColor: Color.fromARGB(1, 242, 242, 242),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: GetBuilder<MessageController>(
                  builder: (controller) {
                    return CupertinoSlidingSegmentedControl<MessageTabKey>(
                        groupValue: controller.tabKey,
                        padding: EdgeInsets.all(4.w),
                        children: {
                          MessageTabKey.normal: Container(
                            height: 44.w,
                            alignment: Alignment.center,
                            child: Text(
                              "Normal",
                              style: TextStyle(
                                fontFamily: FontFamily.SFProRoundedBlod,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: controller.tabKey != MessageTabKey.normal
                                    ? Colors.black45
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          MessageTabKey.system: Container(
                            height: 44.w,
                            alignment: Alignment.center,
                            child: Text(
                              "System",
                              style: TextStyle(
                                fontFamily: FontFamily.SFProRoundedBlod,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: controller.tabKey != MessageTabKey.system
                                    ? Colors.black45
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        },
                        onValueChanged: (value) {
                          controller.tabKey = value!;
                        });
                  },
                ),
              ),
              SizedBox(
                height: 16.w,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: GetBuilder<MessageController>(
                      builder: (controller) {
                        return Column(
                          children: renderCardList(controller.tabKey),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> renderCardList(MessageTabKey tabKey) {
    List<Widget> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(Container(
        height: 149.w,
        margin: EdgeInsets.only(bottom: 8.w),
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top up successful ${tabKey == MessageTabKey.system ? "System" : "Normal"}",
              style: TextStyle(
                fontSize: 20.sp,
                color: textColor,
                fontFamily: FontFamily.SFProRoundedBlod,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              "Your account was successfully topped up with 20 USD on August 10, 2023.",
              style: TextStyle(
                fontSize: 16.sp,
                color: Color.fromRGBO(0, 0, 0, 0.48),
              ),
            ),
            SizedBox(
              height: 16.w,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '2023-08-10 23:59 ',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Color.fromRGBO(0, 0, 0, 0.48),
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return list;
  }
}
