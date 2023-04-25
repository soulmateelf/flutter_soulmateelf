/*
 * @Date: 2023-04-24 13:54:29
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 18:19:47
 * @FilePath: \soulmate\lib\views\main\customRole\logic.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
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

  // 性格列表
  var _characterList = [];
  List<dynamic> get characterList {
    return _characterList;
  }

  set characterList(value) {
    _characterList = value;
    update();
  }

  /// 选中的性格id列表
  var _checkedCharacterIdList = [];
  List<dynamic> get checkedCharacterIdList {
    return _checkedCharacterIdList;
  }

  set checkedCharacterIdList(value) {
    _checkedCharacterIdList = value;
    update();
  }

  changeCharacterStatus(id) {
    final checked = checkedCharacterIdList.any((_id) => id == _id);
    if (checked) {
      checkedCharacterIdList.removeWhere(
        (_id) => id == _id,
      );
    } else {
      checkedCharacterIdList.add(id);
    }
    update();
  }

  getCharacterList() async {
    final result = await NetUtils.diorequst("/role/getCharacter", "get");
    APPPlugin.logger.d(result?.data);
    if (result?.data?["code"] == 200) {
      final data = result.data?["data"] ?? [];
      characterList = data;
    }
  }

  step2ViewSubmit() {
    Get.toNamed("/customRoleStep3");
  }

  final step3FormKey = GlobalKey<FormState>();
  final introductionController = TextEditingController();
  final replenishController = TextEditingController();
  final emailController = TextEditingController();
  var _sendEmail = false;

  get sendEmail {
    return _sendEmail;
  }

  set sendEmail(value) {
    _sendEmail = value;
    update();
  }

  step3ViewSubmit() async {
    final validated = step3FormKey.currentState!.validate();
    if (!validated) return;
    Loading.show();
    NetUtils.diorequst("/role/addcustomization", 'post', params: {
      "roleName": nameController.value,
      "gender": genderController.value,
      "age": ageController.value,
      "roleCharacter": checkedCharacterIdList.join(","),
      "roleIntroduction": introductionController.value,
      "replenish": replenishController.value,
      "gptModel": 3.5,
      "roleStar": star,
      "email": emailController.value ?? Application.userInfo?["email"],
      "sendEmail": sendEmail,
    }).then((value) {
      APPPlugin.logger.d(value);
    }).whenComplete(() {
      Loading.dismiss();
    });
  }
}
