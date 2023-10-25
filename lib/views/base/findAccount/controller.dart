import 'package:get/get.dart';

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
    if (email.length > 0 &&
        emailErrorText == null ) {
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


}
