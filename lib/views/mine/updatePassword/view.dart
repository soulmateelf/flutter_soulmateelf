import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';
import 'controller.dart';

class MineUpdatePasswordPage extends StatelessWidget {
  MineUpdatePasswordPage({super.key});

  final logic = Get.put(MineUpdatePasswordController());

  @override
  Widget build(BuildContext context) {
    return basePage("Update password",
        backGroundImage: null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
                    child: GetBuilder<MineUpdatePasswordController>(
                        builder: (logic) {
                      return TextField(
                        controller: logic.currentPasswordController,
                        focusNode: logic.currentPasswordFocusNode,
                        cursorColor: primaryColor,
                        obscureText: !logic.showCurrentPassword,
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              logic.showCurrentPassword =
                                  !logic.showCurrentPassword;
                            },
                            child: Icon(logic.showCurrentPassword
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash),
                          ),
                          border: InputBorder.none,
                          hintText: "Current password",
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.32),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/findAccount");
                      },
                      child: Text(
                        "Forgot password",
                        style: TextStyle(color: primaryColor, fontSize: 18.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 4.w),
                          child: GetBuilder<MineUpdatePasswordController>(
                              builder: (logic) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: logic.passwordController,
                                  focusNode: logic.passwordFocusNode,
                                  obscureText: !logic.showPassword,
                                  decoration: InputDecoration(
                                    suffix: GestureDetector(
                                      onTap: () {
                                        logic.showPassword =
                                            !logic.showPassword;
                                      },
                                      child: Icon(logic.showPassword
                                          ? CupertinoIcons.eye
                                          : CupertinoIcons.eye_slash),
                                    ),
                                    border: InputBorder.none,
                                    hintText: "New password",
                                    hintStyle: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.32),
                                    ),
                                  ),
                                  cursorColor: primaryColor,
                                  style: const TextStyle(color: textColor),
                                  onEditingComplete: () {
                                    logic.validatePassword();
                                  },
                                ),
                                Offstage(
                                  offstage: logic.passwordErrorText.length == 0,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 8.w),
                                    child: Text(
                                      "${logic.passwordErrorText}",
                                      style: TextStyle(
                                        color: errorTextColor,
                                        fontSize: 14.sp,
                                        fontFamily:
                                            FontFamily.SFProRoundedLight,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                        ),
                        Divider(
                          height: 1.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 4.w),
                          child: GetBuilder<MineUpdatePasswordController>(
                              builder: (logic) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: logic.confirmPasswordController,
                                  focusNode: logic.confirmPasswordFocusNode,
                                  obscureText: !logic.showConfirmPassword,
                                  decoration: InputDecoration(
                                    suffix: GestureDetector(
                                      onTap: () {
                                        logic.showConfirmPassword =
                                            !logic.showConfirmPassword;
                                      },
                                      child: Icon(logic.showConfirmPassword
                                          ? CupertinoIcons.eye
                                          : CupertinoIcons.eye_slash),
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Confirm password",
                                    hintStyle: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.32),
                                    ),
                                  ),
                                  cursorColor: primaryColor,
                                  style: const TextStyle(color: textColor),
                                  onEditingComplete: () {
                                    logic.validateConfirmPassword();
                                  },
                                ),
                                Offstage(
                                  offstage:
                                      logic.confirmPasswordErrorText.length ==
                                          0,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 8.w),
                                    child: Text(
                                      "${logic.confirmPasswordErrorText}",
                                      style: TextStyle(
                                        color: errorTextColor,
                                        fontSize: 14.sp,
                                        fontFamily:
                                            FontFamily.SFProRoundedLight,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.w,
                  ),
                ],
              )),
              Container(
                width: double.infinity,
                height: 64.w,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  color: primaryColor,
                  onPressed: () {
                    logic.updatePassword();
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
