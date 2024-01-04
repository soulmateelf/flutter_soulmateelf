import 'package:get/get.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/mine/account/controller.dart';
import 'package:soulmate/views/mine/mine/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

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
      MineController mineController = Get.find<MineController>();
      await mineController.getUser();
      MineAccountController mineAccountController = Get.find<MineAccountController>();
      mineAccountController.getUser();
      Get.back();
      exSnackBar('success');
    }).catchError((err) {
      exSnackBar(err,type: ExSnackBarType.error);
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
