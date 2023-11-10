/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'package:get/get.dart';

enum GiftTabKey {
  energy,
  rechargeable,
}

class GiftBackpackController extends GetxController {
  GiftTabKey _tabKey = GiftTabKey.energy;

  GiftTabKey get tabKey => _tabKey;

  set tabKey(GiftTabKey value) {
    _tabKey = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    return;
  }

  @override
  void onReady() {
    super.onReady();
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }
}
