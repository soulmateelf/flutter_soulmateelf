/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 18:28:30
 * @FilePath: \soulmate\lib\views\base\login\view.dart
 */
/// Author: kele
/// Date: 2022-01-13 15:18:59
/// LastEditors: kele
/// LastEditTime: 2022-03-08 15:39:16
/// Description: 登录


import 'package:flutter/material.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final logic = Get.put(LoginLogic());
  @override
  Widget build(BuildContext context) {
    return basePage('',
        showBgImage: true,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('login'),
              TextButton(onPressed: ()=>Get.toNamed('/menu'), child: const Text('menu')),
            ],
          ),
        )
    );
  }
}
