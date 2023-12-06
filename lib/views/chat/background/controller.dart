import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/chat/chat/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ChatBackgroundController extends GetxController {
  final chatLogic = Get.find<ChatController>();
  List<dynamic> backgroundList = [];

  String? checkedImageId = null;

  void changeImage(String s) {
    checkedImageId = s;
    HttpUtils.diorequst("/role/setRoleChatBackground",
        method: "post",
        params: {"roleId": chatLogic.roleId, "imagesId": s}).then((res) {
      update();
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
    });
  }

  void getBackground() {
    HttpUtils.diorequst('/role/selectRoleBackgroundImage', query: {
      "roleId": chatLogic.roleId,
    }).then((res) {
      APPPlugin.logger.d(res);
      backgroundList = res['data'];
      update();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getBackground();
    super.onReady();
  }
}
