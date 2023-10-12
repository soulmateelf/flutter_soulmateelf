/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:18:17
 * @FilePath: \soulmate\lib\views\base\login\logic.dart
 */
import 'package:get/get.dart';

class LoginLogic extends GetxController {
    var passwordVisible = false.obs;

    void togglePasswordVisible (){
        passwordVisible.value = !passwordVisible.value;
    }
}
