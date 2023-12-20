import 'dart:io';

import 'package:dio/src/multipart_file.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:dio/src/form_data.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
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
      getUser();
    }).catchError((err) {
      APPPlugin.logger.e(err);
    });
  }

  void downloadData() {
    HttpUtils.diorequst("/user/downloadUserData", query: {
      "email": user?.email,
    }).then((res) {
      APPPlugin.logger.d(res);
      if (res?['data'] == "true") {
        exSnackBar(res?['message']);
      }
    }).catchError((err) {
      APPPlugin.logger.d(err);
    });
  }

  void getUser() async {
    await Application.regainUserInfo();
    user = Application.userInfo;
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getUser();
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
