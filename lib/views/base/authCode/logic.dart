import 'package:get/get.dart';

import '../../../widgets/library/projectLibrary.dart';

class AuthCodeLogic extends GetxController {

  var passwordVisible = false.obs;

  void togglePasswordVisible (){
    passwordVisible.value = !passwordVisible.value;
  }


  bool nextBtnDisabled = true;


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