import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/chat/settings/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ChatSettingsPage extends StatelessWidget {
  ChatSettingsPage({super.key});

  final logic = Get.put(ChatSettingsController());

  List<dynamic> modelList = [
    {
      "title": "Simple",
      "description":
          "Can communicate with you normally, but may not remember the content of the communication"
    },
    {
      "title": "Ordinary",
      "description":
          "Can communicate with you normally, may remember a little communication content"
    },
    {
      "title": "Advanced",
      "description":
          "Can communicate with you normally, probably remember everything，Please look forward to…"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return basePage("Chat Settings",
        backGroundImage: null,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: GetBuilder<ChatSettingsController>(
            builder: (controller) {
              return Column(
                children: [
                  ...renderModelList(),
                ],
              );
            },
          ),
        ));
  }

  List<Widget> renderModelList() {
    List<Widget> list = [];

    for (int i = 0; i < modelList.length; i++) {
      final modelItme = modelList[i];
      list.add(GestureDetector(
        onTap: () {
          if (i < 2) {
            logic.currentModal = i;
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: logic.currentModal == i
                  ? Color.fromRGBO(255, 245, 235, 0.48)
                  : Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                width: borderWidth,
                color: logic.currentModal == i ? primaryColor : Colors.white,
              )),
          margin: EdgeInsets.only(bottom: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                modelItme['title'],
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
                modelItme['description'],
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Color.fromRGBO(0, 0, 0, 0.48),
                ),
              )
            ],
          ),
        ),
      ));
    }

    return list;
  }
}
