import 'package:get/get.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

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
    validateNext();
    update();
  }

  void validateNickname(String nickname) {
    final isNickname = GetUtils.isUsername(nickname);
    final prevErrorText = nicknameErrorText;
    if (isNickname) {
      nicknameErrorText = null;
    } else {
      nicknameErrorText = "Please enter a valid nickname.";
    }
    validateNext();
    update();
  }

  /// 判断是否可以进行下一步 对按钮控制的状态做禁用
  validateNext({
    bool refresh = false,
  }) {
    if (email.length > 0 &&
        nickname.length > 0 &&
        emailErrorText == null &&
        nicknameErrorText == null) {
      nextBtnDisabled = false;
    } else {
      nextBtnDisabled = true;
    }
    if (refresh) {
      update();
    }
  }

  void next() {
    HttpUtils.diorequst("/emailExist", query: {"email": email}).then((value) {
      if (value?['code'] == 200 && value?['data'] != true) {
        Get.toNamed('/authCode', arguments: {
          "codeType": VerifyState.signUp,
          "email": email,
          "nickName": nickname,
          "pushId": Application.pushId,
          "platform": GetPlatform.isAndroid ? 'android' : 'ios',
          "buildNumber": APPPlugin.appInfo?.buildNumber,
          "sdkVersion": APPPlugin.appInfo?.version
        });
      } else {
        exSnackBar(value?['message'], type: ExSnackBarType.error);
      }
    }, onError: (err) {
      exSnackBar(err.toString(), type: ExSnackBarType.error);
    });
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  bool nextBtnDisabled = true;
}
