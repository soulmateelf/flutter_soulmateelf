import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/material.dart';

class AuthCodeController extends GetxController {
  Duration animateDurantion = const Duration(milliseconds: 300);
  FocusNode focusNode = FocusNode();
  bool loading = false;

  TextEditingController controller = TextEditingController();

  void setLoading(bool l) {
    loading = l;
    update();
  }

  bool hasError = false;
  String? errorText = null;

  void setHasError(bool e) {
    hasError = e;
    update();
  }

  StreamController<ErrorAnimationType>? errorAnimationController;

  void setErrorController(StreamController<ErrorAnimationType> controller) {
    errorAnimationController = controller;
    update();
  }

  var code = "";
  int time = 180;
  int intervalTime = 0;

  void recursionTime() {
    Future.delayed(const Duration(seconds: 1), () {
      if (intervalTime > 0) {
        intervalTime--;
        update();
        recursionTime();
      }
    });
  }

  void sendCode() {
    if (intervalTime > 0) {
      return;
    }
    intervalTime = time;
    recursionTime();
    if (!loading) {
      var arguments = Get.arguments;
      setLoading(true);
      HttpUtils.diorequst("/sendEmail", method: "post", params: {
        "type": arguments['codeType'],
        "email": arguments['email']
      }).then((value) {}).whenComplete(() {
        setLoading(false);
      });
    }
  }

  void handleVerify() {
    var arguments = Get.arguments;
    if (code.length == 6 && arguments['codeType'] != VerifyState.deactivate) {
      HttpUtils.diorequst("/verify", method: "post", params: {
        "code": code,
        "codeType": arguments['codeType'],
        "email": arguments['email']
      }).then((value) {
        Get.toNamed("/password", arguments: {
          ...arguments as Map,
          "code": code,
        });

        errorText = null;
        code = "";
        controller.text = "";
        setHasError(false);
      }, onError: (err) {
        errorAnimationController?.add(ErrorAnimationType.shake);
        Future.delayed(const Duration(milliseconds: 1300), () {
          code = "";
          controller.clear();
          errorText = null;

          focusNode.requestFocus();
          setHasError(false);
        });
        errorText = err.toString();
        code = "";
        setHasError(true);
      });
    } else {
      setHasError(false);
    }
  }

  bool nextBtnDisabled = true;

  void deactivateAccount() {
    if (code.length != 6) {
      return;
    }
    final makeDialogController = MakeDialogController();

    var arguments = Get.arguments;
    makeDialogController.show(
      context: Get.context!,
      controller: makeDialogController,
      iconWidget: Image.asset("assets/images/icons/logOut.png"),
      content: Column(
        children: [
          Text(
            "Deactivate",
            style: TextStyle(
              color: textColor,
              fontSize: 32.sp,
              fontFamily: FontFamily.SFProRoundedSemibold,
            ),
          ),
          SizedBox(
            height: 8.w,
          ),
          Text(
            "Are you sure you want to deactivate?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.48),
              fontFamily: FontFamily.SFProRoundedMedium,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(
            height: 30.w,
          ),
          Container(
            height: 64.w,
            width: double.maxFinite,
            child: TextButton(
                onPressed: () {
                  HttpUtils.diorequst('/cancelAccount',
                      method: "post",
                      params: {
                        "email": arguments['email'],
                        "code": code,
                        "codeType": arguments["codeType"]
                      }).then((res) async {
                    await Application.logout();
                    exSnackBar(res['message']);
                  }).catchError((err) {
                    APPPlugin.logger.e(err);
                  });
                },
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white)),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w)))),
                child: Text(
                  "yes,log out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.w,
                    fontFamily: FontFamily.SFProRoundedBlod,
                  ),
                )),
          ),
          SizedBox(
            height: 10.w,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              makeDialogController.close();
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.32),
                  fontSize: 20.sp,
                  fontFamily: FontFamily.SFProRoundedMedium,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.w,
          ),
        ],
      ),
    );
  }
}
