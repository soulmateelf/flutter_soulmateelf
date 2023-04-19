/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-19 15:29:14
 * @FilePath: \soulmate\lib\views\main\home\logic.dart
 */
import 'package:get/get.dart';

class HomeLogic extends GetxController {
  var _selectedRole = null;

  get selectedRole => _selectedRole;

  set selectedRole(dynamic role) {
    _selectedRole = role;
  }

  @override
  void onInit() {
    super.onInit();
    return;
  }

  @override
  void onReady() {
    print("ready");
    super.onReady();
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }
}
