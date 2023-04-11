/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-11 19:58:57
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    final logic = Get.put(HomeLogic());
    return GetBuilder<HomeLogic>(builder: (logic) {
      return basePage("homer",
          backgroundColor: Colors.transparent,
          showAppBar: false,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromARGB(255, 145, 73, 68),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.w),
                    color:Color.fromRGBO(232, 232, 223, 1) ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 448.w,
                                  width: 280.w,
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(20.w),
                                height: 448.w,
                                color: Colors.white60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Icon(Icons.star_border_outlined),
                                        Icon(Icons.star_border_outlined)
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Soulmate ELF",
                                            style: TextStyle(
                                              fontSize: 36.sp,
                                            ),
                                          ),
                                          Icon(Icons.edit),
                                          Icon(Icons.share)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.w),
                                      child: Text("Age：unknown"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.w),
                                      child: Text("Gender：unknown"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.w),
                                      child: Text(
                                          "Basic communication skills, poor memory, good to use occasionally"),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thunderstorm),
                                Text("22"),
                                Text('/100'),
                              ],
                            ),
                            Icon(Icons.add)
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 31.w),
                          child: Text(
                              "Basic communication skills, poor memory, good to use occasionallyBasic communication skills, poor memory, good to use occasionallyBasic communication skills, poor memory, good to use occasionally"),
                        )
                      ],
                    ),
                  ),
                  Text("123")
                ],
              )));
    });
  }
}
