import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/mine/confirmDeactivate/controller.dart';
import 'package:soulmate/views/mine/deactivate/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class MineConfirmDeactivatePage extends StatelessWidget {
  MineConfirmDeactivatePage({super.key});

  final logic = Get.put(MineConfirmDeactivateController());

  @override
  Widget build(BuildContext context) {
    return basePage("Confirm your password",
        backGroundImage: null,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Center(
                    child: Text(
                      "Complete your deactivation request by entering\n the password associated with your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.48),
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.w,
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
                      controller: logic.controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.32),
                            fontSize: 18.sp),
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                width: double.infinity,
                height: 64.w,
                child: MaterialButton(
                  onPressed: () {
                    logic.deactivate();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  color: errorTextColor,
                  child: Text(
                    "Deactivate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.SFProRoundedBlod,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
