/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:15:44
 * @FilePath: \soulmate\lib\views\base\welcome\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2023-10-20 17:18:32
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';

import 'controller.dart';

class FindAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FindAccountState();
  }
}

class FindAccountState extends State<FindAccountPage> {
  final logic = Get.put(FindAccountController());

  final _emialController = TextEditingController();

  FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        logic.validateEmail(_emialController.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _emialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return basePage('',
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 72.w,
                ),
                Text(
                  "Find your account",
                  style: TextStyle(
                    fontSize: 27.sp,
                    fontFamily: FontFamily.SFProRoundedBlod,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 186.w,
                ),
                GetBuilder<FindAccountController>(
                  builder: (controller) {
                    return MakeInput(
                      controller: _emialController,
                      onChanged: (v) {
                        controller.email = v;
                      },
                      autofocus: true,
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        _emailFocusNode.unfocus();
                      },
                      error: controller.emailErrorText != null,
                      errorText: controller.emailErrorText,
                      textAlign: TextAlign.center,
                      hintText: "Email",
                      allowClear: true,
                      keyboardType: TextInputType.emailAddress,
                      onClear: () {
                        _emialController.text = "";
                        controller.email = "";
                        controller.validateEmail("");
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 237.w,
                ),
                GetBuilder<FindAccountController>(
                  builder: (controller) {
                    return MaterialButton(
                      minWidth: double.infinity,
                      height: 64.w,
                      enableFeedback: true,
                      disabledColor: disableColor,
                      textColor: controller.nextBtnDisabled
                          ? const Color.fromRGBO(0, 0, 0, 0.24)
                          : Colors.white,
                      onPressed:
                          controller.nextBtnDisabled ? null : controller.next,
                      color: const Color.fromRGBO(255, 128, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.SFProRoundedBlod,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
