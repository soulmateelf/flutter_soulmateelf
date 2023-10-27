import 'dart:async';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/focus_manager.dart';

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

  void recursionTime (){
    Future.delayed(const Duration(seconds: 1),(){
      if(intervalTime > 0){
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
    if (code.length == 6) {
      var arguments = Get.arguments;

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
}
