import 'dart:io';

import 'package:dio/src/multipart_file.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:dio/src/form_data.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/mine/mine/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class MineAccountController extends GetxController {
  User? user;

  void uploadHeadImg(XFile? file) async {
    if (file == null || user == null) {
      return;
    }
    FormData formData = FormData.fromMap({});

    formData.files
        .add(MapEntry("file", await MultipartFile.fromFileSync(file!.path)));
    HttpUtils.diorequst('/uploadHeadImg',
            method: "post",
            query: {
              "userId": user?.userId,
            },
            params: formData)
        .then((res) async {
      MineController mineController = Get.find<MineController>();
      await mineController.getUser();
      user = Application.userInfo;
      update();
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
    });
  }



  void getUser() async {
    user = Application.userInfo;
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = Application.userInfo;
    update();
  }
}
