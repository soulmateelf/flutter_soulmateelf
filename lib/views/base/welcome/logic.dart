/*
 * @Date: 2023-04-10 14:14:57
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-10 14:23:22
 * @FilePath: \soulmate\lib\views\base\welcome\logic.dart
 */

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class WelcomeLogic extends GetxController {
  // 上次点击返回键时间
  int lastClickTime = 0;

  /// Author: kele
  /// Date: 2022-03-08 15:12:36
  /// Params:
  /// Return:
  /// Description: 处理安卓返回键
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:
  Future<bool> dealBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClickTime > 1000) {
      lastClickTime = DateTime.now().millisecondsSinceEpoch;
      EasyLoading.showToast('再按一次退出应用');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
