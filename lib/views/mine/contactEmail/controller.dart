import 'package:get/get.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class MineContactEmailController extends GetxController {
  String _email = '';
  String? errorText;

  late final User? user;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  String get email => _email;

  set email(String value) {
    _email = value;
    update();
  }

  void validateEmail(String email) {
    if (email.isEmpty) {
      errorText = null;
    } else {
      final isEmail = GetUtils.isEmail(email);
      if (isEmail) {
        errorText = null;
      } else {
        errorText = "Please enter a valid email.";
      }
    }
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    user = Application.userInfo;
    email = user?.emergencyEmail ?? '';
    controller.text = email;
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        validateEmail(email);
      }
    });
    super.onReady();
  }

  void done() {
    if (!email.isEmpty && errorText == null) {
      HttpUtils.diorequst("/settingEmergencyEmail", method: 'post', params: {
        "emergencyEmail": email,
      }).then((value) {
        Application.regainUserInfo();
      }).catchError((err) {
        exSnackBar(err.toString(), type: ExSnackBarType.error);
      });
    }
  }
}
