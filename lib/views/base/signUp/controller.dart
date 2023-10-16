import 'package:get/get.dart';

import '../../../widgets/library/projectLibrary.dart';

class SignUpController extends GetxController {
  var email = "";
  var nickname = "";
  var emailErrorText = null;
  var nicknameErrorText = null;

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

  void validateNickname(String nickname) {
    final isNickname = GetUtils.isUsername(nickname);
    final prevErrorText = nicknameErrorText;
    if (isNickname) {
      nicknameErrorText = null;
    } else {
      nicknameErrorText = "Please enter a valid nickname.";
    }
    if (prevErrorText != nicknameErrorText) {
      validateNext();
      update();
    }
  }

  /// 判断是否可以进行下一步 对按钮控制的状态做禁用
  validateNext() {
    if (email.length > 0 &&
        nickname.length > 0 &&
        emailErrorText == null &&
        nicknameErrorText == null) {
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
