import 'dart:convert';

import 'package:get/get.dart';
import 'package:card_swiper/src/swiper_controller.dart';

import 'package:flutter/services.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

class IntroRecommendController extends GetxController {
  final swiperController = SwiperController();
  int _index = 0;

  int get index => _index;

  set index(int value) {
    _index = value;
    update();
  }

  List<dynamic> data = [];

  Future<void> getRoleList() async {
    Map<String, dynamic> json =
        jsonDecode(await rootBundle.loadString("assets/introList.json"));
    data = json['data'];
    update();
  }

  void chatNow(String roleId) {
    Get.toNamed('/chat', arguments: {"roleId": roleId, "intro": true});
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getRoleList();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
