import 'dart:convert';

import 'package:get/get.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

class IntroWelcomeController extends GetxController {
  bool _showNextBtn = false;

  bool get showNextBtn => _showNextBtn;

  set showNextBtn(bool value) {
    _showNextBtn = value;
    update();
  }


  void toRecommend() async{



    Get.toNamed('/introRecommend');
  }
}