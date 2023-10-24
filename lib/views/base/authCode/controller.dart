import 'dart:async';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

import '../../../widgets/library/projectLibrary.dart';

class AuthCodeController extends GetxController {
  bool loading = false;

  void setLoading(bool l) {
    loading = l;
    update();
  }

  bool hasError = false;

  void setHasError(bool e) {
    hasError = e;
    update();
  }

  StreamController<ErrorAnimationType>? errorAnimationController =
      StreamController();

  var code = "";

  @override
  void onInit() {
    // TODO: implement onInit
    sendCode();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    errorAnimationController?.close();
    super.onClose();
  }

  void sendCode() {
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
        APPPlugin.logger.d(value);

        Get.toNamed("/password", arguments: {
          ...arguments as Map,
          "code": code,
        });
        setHasError(false);
      }, onError: (err) {
        errorAnimationController?.add(ErrorAnimationType.shake);
        setHasError(true);
        APPPlugin.logger.d(err);
      });
    } else {
      setHasError(false);
    }
  }

  bool nextBtnDisabled = true;

  // 上次点击返回键时间
  int lastClickTime = 0;

  /// Author: kele
  /// Date: 2022-03-08 15:12:36
  /// Params:
  /// Return:
  /// Description: 处理安卓返回键
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:
  Future<bool> dealBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClickTime > 1000) {
      lastClickTime = DateTime.now().millisecondsSinceEpoch;
      Loading.toast('再按一次退出应用');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
