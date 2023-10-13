/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class RolePage extends StatelessWidget {
  final logic = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return basePage('Friend',
      showBgImage: true,
      child:Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Role'),
            TextButton(onPressed: ()=>Get.toNamed('/chat'), child: const Text('Chat Now ')),
          ],
        ),
      ));
  }
}
