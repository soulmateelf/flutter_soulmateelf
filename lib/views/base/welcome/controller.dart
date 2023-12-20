/*
 * @Date: 2023-04-10 14:14:57
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:56
 * @FilePath: \soulmate\lib\views\base\welcome\controller.dart
 */

import 'package:get/get.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class WelcomeController extends GetxController {
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
      Loading.toast('再按一次退出应用');
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
