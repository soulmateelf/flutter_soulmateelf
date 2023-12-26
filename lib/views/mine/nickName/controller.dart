import 'package:get/get.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

import '../../../models/user.dart';

class MineNickNameController extends GetxController {
  final controller = TextEditingController();
  User? user;

  void updateNickname() {
    if (controller.text.isEmpty) {
      return;
    }
    HttpUtils.diorequst("/user/updateName", query: {
      "newName": controller.text,
    }).then((res) async {
      Get.back();
    }).catchError((err) {
      APPPlugin.logger.e(err);
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    user = Application.userInfo;
    controller.text = user?.nickName ?? '';
    update();
    super.onReady();
  }
}
