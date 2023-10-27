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
    final prevErrorText = emailErrorText;
    if (isEmail) {
      emailErrorText = null;
    } else {
      emailErrorText = "Please enter a valid email.";
    }
    if (prevErrorText != emailErrorText) {
      validateNext();
      update();
    }
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
        if (value['code'] == 200) {
          Get.toNamed('/authCode', arguments: {
            "codeType": VerifyState.forgot,
            "email": email,
          });
        }
      }, onError: (err) {
        exSnackBar(err.toString(), type: ExSnackBarType.error);
      });
    }
  }
}
