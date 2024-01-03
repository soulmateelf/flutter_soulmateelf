import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/chat/background/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ChatBackgroundPage extends StatelessWidget {
  ChatBackgroundPage({super.key});

  final logic = Get.put(ChatBackgroundController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatBackgroundController>(
      builder: (controller) {
        return basePage("Background",
            child: Container(
                padding: EdgeInsets.all(12.w),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.61,
                  ),
                  children: renderBackgroundList(),
                )));
      },
    );
  }

  List<Widget> renderBackgroundList() {
    List<Widget> list = [];
    logic.backgroundList.forEach((bg) {
      final checked = bg == logic.checkedImageId;
      list.add(GestureDetector(
        onTap: () {
          logic.changeImage(bg);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white30,
            image: DecorationImage(
              image: AssetImage(
                "assets/images/image/${bg}.png",
              ),
              fit: BoxFit.cover,
            ),
            border: checked
                ? Border.all(width: borderWidth, color: primaryColor)
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: checked
              ? Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: borderWidth, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(borderRadius),
                          color: Color.fromRGBO(255, 128, 0, 0.24),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/icons/right.png",
                          width: 34.w,
                          height: 34.w,
                        ),
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ));
    });
    return list;
  }
}
