/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 17:15:44
 * @FilePath: \soulmate\lib\views\base\welcome\view.dart
 */

/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2023-10-20 17:18:50
/// Description: 登录

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/base/signUp/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<SignUpPage> {
  final logic = Get.put(SignUpController());

  final _emialController = TextEditingController();

  final _nicknameController = TextEditingController();

  FocusNode _emailFocusNode = FocusNode();

  FocusNode _nicknameFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        logic.validateEmail(_emialController.text);
      }
    });
    _nicknameFocusNode.addListener(() {
      if (!_nicknameFocusNode.hasFocus) {
        logic.validateNickname(_nicknameController.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emialController.dispose();
    _emailFocusNode.dispose();
    _nicknameController.dispose();
    _nicknameFocusNode.dispose();
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
                  'Create your account',
                  style: TextStyle(
                    fontSize: 27.sp,
                    fontFamily: FontFamily.SFProRoundedBlod,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 186.w,
                ),
                GetBuilder<SignUpController>(
                  builder: (controller) {
                    return MakeInput(
                      controller: _emialController,
                      onChanged: (v) {
                        controller.email = v;
                      },
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        controller.validateNext(refresh: true);
                        _nicknameFocusNode.requestFocus();
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
                  height: 12.w,
                ),
                GetBuilder<SignUpController>(
                  builder: (controller) {
                    return MakeInput(
                      controller: _nicknameController,
                      onChanged: (v) {
                        controller.nickname = v;
                      },
                      focusNode: _nicknameFocusNode,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        _nicknameFocusNode.unfocus();
                      },
                      error: controller.nicknameErrorText != null,
                      errorText: controller.nicknameErrorText,
                      textAlign: TextAlign.center,
                      hintText: "Nickname",
                      allowClear: true,
                      keyboardType: TextInputType.name,
                      onClear: () {
                        _nicknameController.text = "";
                        controller.nickname = "";
                        controller.validateNickname("");
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 161.w,
                ),
                GetBuilder<SignUpController>(
                  builder: (controller) {
                    return MaterialButton(
                      minWidth: double.infinity,
                      height: 64.w,
                      enableFeedback: true,
                      disabledColor: disableColor,
                      textColor: controller.nextBtnDisabled
                          ? const Color.fromRGBO(0, 0, 0, 0.24)
                          : Colors.white,
                      onPressed: controller.nextBtnDisabled
                          ? null
                          : () {
                              Get.toNamed('/authCode', arguments: {
                                "codeType": VerifyState.signUp,
                                "email": controller.email,
                                "nickName": controller.nickname,
                              });
                            },
                      color: const Color.fromRGBO(255, 128, 0, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: FontFamily.SFProRoundedBlod,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 40.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'By signing up, you agree to our ',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/termsOfService");
                      },
                      child: Text(
                        'Terms,',
                        style: TextStyle(fontSize: 14.sp, color: primaryColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/privacyPolicy");
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 14.sp, color: primaryColor),
                      ),
                    ),
                    Text(
                      '.',
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
