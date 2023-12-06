import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/mine/nickName/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class MineNickNamePage extends StatelessWidget {
  MineNickNamePage({super.key});

  final logic = Get.put(MineNickNameController());

  @override
  Widget build(BuildContext context) {
    return basePage("Nick name",
        backGroundImage: null,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
                      child: TextField(
                        cursorColor: primaryColor,
                        controller: logic.controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nick name",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.32),
                              fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.w,
              ),
              Container(
                height: 64.w,
                width: double.infinity,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  color: primaryColor,
                  onPressed: () {
                    logic.updateNickname();
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamily.SFProRoundedBlod,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.w),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
