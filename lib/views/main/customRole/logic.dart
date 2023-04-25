/*
 * @Date: 2023-04-24 13:54:29
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 17:02:02
 * @FilePath: \soulmate\lib\views\main\customRole\logic.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:get/get.dart';

class CustomRoleLogic extends GetxController {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var _star = 3;

  int get star {
    return _star;
  }

  set star(int num) {
    _star = num;
    update();
  }

  step1ViewSubmit() {
    if (formKey.currentState!.validate()) {
      getCharacterList();
      Get.toNamed("/customRoleStep2");
    }
  }

  getCharacterList() async {
    final result = await NetUtils.diorequst("/role/getCharacter", "get");
    APPPlugin.logger.d(result?.data);
  }

  step2ViewSubmit() {
    Get.toNamed("/customRoleStep3");
  }

  final step3FormKey = GlobalKey<FormState>();
  final characterController = TextEditingController();
  final anythingController = TextEditingController();
  var _sendEmail = false;

  get sendEmail {
    return _sendEmail;
  }

  set sendEmail(value) {
    _sendEmail = value;
    update();
  }

  step3ViewSubmit() {
    final validated = step3FormKey.currentState!.validate();
    if (!(validated && sendEmail)) return;
  }
}
