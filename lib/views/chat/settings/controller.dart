import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import '../../../models/user.dart';

class ChatSettingsController extends GetxController {
  /// 当前选择的聊天模式
  int _currentModal = 0;
  User? user;

  int get currentModal => _currentModal;

  set currentModal(int value) {
    _currentModal = value;
    if (user != null) {
      user!.model = value;
      HttpUtils.diorequst("/settingModel",method: "post", params: {"model": currentModal})
          .then((res) {
            APPPlugin.logger.d(res);
      })
          .catchError((err) {
        exSnackBar(err.toString(), type: ExSnackBarType.error);
      });
    }
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    user = Application.userInfo;
    currentModal = user?.model ?? 1;
    super.onReady();
  }
}
