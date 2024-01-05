import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/chat/chat/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ChatBackgroundController extends GetxController {
  final chatLogic = Get.find<ChatController>();
  List<String> backgroundList = [
    "98c07c0640084a468e7f56c1dc4419d7",
    "6946deddd0514309965994d849dd5193",
    "7b3bdb20730c405b97a3e77cb2e92652",
    "cccef26bc09f4fa08aea297ec3e53432",
    "271d9d3a09d9489d89f4a8e1854f6218",
    "fd1c36b9fe8b4d189fbd6477d6740004",
    "68f06845c01a499a9052120826914e27",
    "39a46cece1014f1195d57f5104f12ba2",
    "ebe30c4b3521499cb4e22a9678135afe",
    "06bbbb905bf94cfd85bd682cb095a022",
    "2a6062bed2c34a8b885fdcea3d1ab413",
    "23687baa48f945c58c541cbdfbb31a2a",
    "25dfcc8c672d461d9a22e3ee4d61a2be",
    "5838159545fc4a42803f3009a2140a49",
    "c12383339606442a9dff37429f600d72",
    "4a8b4b8975cb46569497eae2a28aafc2",
    "60f2d5bc222540f5a201bd8494e27691",
  ];

  String? checkedImageId = null;

  void changeImage(String s) {
    checkedImageId = s;
    HttpUtils.diorequst("/role/setRoleChatBackground",
        method: "post",
        params: {"roleId": chatLogic.roleId, "imagesId": s}).then((res) {
      update();
      if (chatLogic.roleDetail != null) {
        chatLogic.roleDetail!.imageId = s;
        chatLogic.update();
      }
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    checkedImageId = chatLogic.roleDetail?.imageId;
    update();
    super.onReady();
  }
}
