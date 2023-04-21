import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PreviewPhotoLogic extends GetxController {
  List? images;

  ///图片列表
  var index = 0.obs;

  ///选中的index
  String type = "network";
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    Map arguments = Get.arguments;
    images = arguments['images'] ?? [];
    index.value = arguments['index'] ?? 0;
    type = arguments["type"] ?? "network";
    pageController = PageController(initialPage: index.value);
  }
}
