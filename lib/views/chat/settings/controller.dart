import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:soulmate/models/user.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ChatSettingsController extends GetxController {
  /// 当前选择的聊天模式
  int currentModal = 1;
  User? user;

  setCurrentModal(int value) {
    HttpUtils.diorequst("/settingModel",
        method: "post",
        params: {"model": currentModal}).then((res) {
      user!.model = value;
      Application.userInfo = user;
    }).catchError((err) {
      exSnackBar(err.toString(), type: ExSnackBarType.error);
    });
    update();
  }

  @override
  void onInit() {
    // TODO: implement onReady
    user = Application.userInfo;
    currentModal = user?.model ?? 1;
  }
}
