import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/mine/nickName/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class MineContactEmailPage extends StatelessWidget {
  MineContactEmailPage({super.key});

  final logic = Get.put(MineContactEmailController());

  @override
  Widget build(BuildContext context) {
    return basePage("Emergency contact email",
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
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            cursorColor: primaryColor,
                            controller: logic.controller,
                            onChanged: (v) {
                              logic.email = v;
                            },
                            focusNode: logic.focusNode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contact email",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.32),
                                  fontSize: 18.sp),
                            ),
                          ),
                          GetBuilder<MineContactEmailController>(
                            builder: (logic) {
                              return logic.errorText != null
                                  ? Text("${logic.errorText!}",
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 90, 90, 1),
                                        fontSize: 14.sp,
                                      ))
                                  : Container();
                            },
                          )
                        ],
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
                    logic.done();
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
