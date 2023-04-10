/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-10 10:48:01
 * @FilePath: \soulmate\lib\views\main\home\view.dart
 */
////////////////////////
///Author: guohl
///Date: 2022-02-08 09:30:30
///LastEditors: guohl
///LastEditTime: 2022-02-09 15:40:33
///Description:
////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return GetBuilder<HomeLogic>(builder: (logic) {
      return basePage(
        "homer",
          backgroundColor:Colors.transparent,
          leading: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [Icon(Icons.arrow_back_ios), Text("Back")],
            ),
          ),
          child: const Text('home'));
    });
  }
}
