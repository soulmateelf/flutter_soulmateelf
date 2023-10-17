/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:simple_animations/simple_animations.dart';

import 'controller.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePage();
  }
}

class _MinePage extends State<MinePage> {
  final logic = Get.put(MineController());

  final _scrollController = ScrollController();

  double appBarMaxHeight = 117;

  double gap = 44;

  @override
  void initState() {
    // TODO: implement initState

    _scrollController.addListener(() {
      final offset = _scrollController.offset / 3;
      setState(() {
        if (offset > gap) {
          logic.setSize(appBarMaxHeight - gap);
        } else {
          logic.setSize(appBarMaxHeight - offset);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// 在三个主模块入口ScreenUtil初始化，真机调试刷新就没问题了
    ScreenUtil.init(Get.context!, designSize: const Size(428, 926));

    return basePage('Chat',
        showBgImage: true,
        showAppbar: false,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.w),
              height: logic.size,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3.w, color: Colors.white)),
                    child: Container(
                      height: 80.w,
                      width: 80.w,
                      child: Image.asset("assets/images/icons/avatar.png"),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sally",
                          style: TextStyle(color: textColor, fontSize: 24.sp),
                        ),
                        Offstage(
                          offstage: logic.size < appBarMaxHeight - gap / 2,
                          child: Container(
                            margin: EdgeInsets.only(top: 4.w),
                            child: Text(
                              "Sally@gmail.com",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.48),
                                  fontSize: 18.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/feedback');
                    },
                    child: Image.asset(
                      "assets/images/icons/email.png",
                      width: 44.w,
                      height: 44.w,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2000.w,
                      color: Colors.yellow,
                    ),
                    const Text('Mine'),
                    const Text('自定义角色和我的这几个页面不能用basePage，太个性化，需要自己写'),
                    TextButton(
                        onPressed: logic.logout, child: const Text('Log out')),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
