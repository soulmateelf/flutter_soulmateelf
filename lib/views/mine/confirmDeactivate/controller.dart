import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import '../../../utils/core/constants.dart';

class MineConfirmDeactivateController extends GetxController {
  final controller = TextEditingController();

  void deactivate() {
    final isPassword = checkPassword(controller.text);
    if (!isPassword) {
      exSnackBar(
          "The password consists of a 8-16 character string, which must contain at least two elements of numbers, letters and symbols.",
          type: ExSnackBarType.error);
      return;
    }
    HttpUtils.diorequst(
      '/verifyPassword',
      query: {
        "password": controller.text,
      },
    ).then((res) {
      Get.toNamed('/authCode', arguments: {
        "codeType": VerifyState.deactivate,
        "email": Application?.userInfo?.email,
      });
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
    });
  }
}
