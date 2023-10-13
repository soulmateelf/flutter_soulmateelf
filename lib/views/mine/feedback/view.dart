/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class FeedbackPage extends StatelessWidget {
  final logic = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return basePage('Feedback',
      child:Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Feedback'),
          ],
        ),
      ));
  }
}
