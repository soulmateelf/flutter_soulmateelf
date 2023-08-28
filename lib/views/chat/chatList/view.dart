/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'logic.dart';

class ChatListPage extends StatelessWidget {
  final logic = Get.put(ChatListLogic());

  @override
  Widget build(BuildContext context) {
    /// 在三个主模块入口ScreenUtil初始化，真机调试刷新就没问题了
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));
    return basePage('Chat',
        showBgImage: true,
        leading: IconButton(
            onPressed: () {
              Get.toNamed('/message');
            },
            icon: Image.asset(
              "assets/images/icons/message.png",
              height: 44.w,
              width: 44.w,
            )
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/feedback');
              },
              icon: Image.asset(
                "assets/images/icons/email.png",
                height: 44.w,
                width: 44.w,
              )
          )
        ],
        child:Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('chatList'),
                    Text(logic.num.toString()),
                    TextButton(onPressed: logic.add, child: const Text('+5')),
                    TextButton(onPressed: ()=>Get.toNamed('/chat'), child: const Text('CHAT')),
                  ],
                ),
            )
        );
  }
}
