import 'dart:math';

import 'package:get/get.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

import '../../../utils/core/constants.dart';
import '../../../widgets/library/projectLibrary.dart';

class FindAccountController extends GetxController {
  var email = "";
  var emailErrorText = null;

  void validateEmail(String email) {
    final isEmail = GetUtils.isEmail(email);
    if (isEmail) {
      emailErrorText = null;
    } else {
      emailErrorText = "Please enter a valid email.";
    }
    validateNext();
    update();
  }

  /// 判断是否可以进行下一步 对按钮控制的状态做禁用
  validateNext() {
    if (email.length > 0 && emailErrorText == null) {
      nextBtnDisabled = false;
    } else {
      nextBtnDisabled = true;
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  bool nextBtnDisabled = true;

  void next() {
    if (email.length > 0 && emailErrorText == null) {
      HttpUtils.diorequst("/emailExist", query: {"email": email}).then((value) {
        APPPlugin.logger.d("success ${value}");
        if (value['code'] == 200) {
          Get.toNamed('/authCode', arguments: {
            "codeType": VerifyState.forgot,
            "email": email,
          });
        }
      }, onError: (err) {
        Get.toNamed('/authCode', arguments: {
          "codeType": VerifyState.forgot,
          "email": email,
        });
        /// 账号存在说明可以继续下一步
        exSnackBar(err.toString(), type: ExSnackBarType.error);
      });
    }
  }
}
