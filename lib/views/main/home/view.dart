/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-12 10:58:43
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
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
                    color: Color.fromRGBO(232, 232, 223, 1),
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
                                          const Icon(Icons.edit),
                                          const Icon(Icons.share)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.w),
                                      child: Text("Age：unknown"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.w),
                                      child: const Text("Gender：unknown"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.w),
                                      child: const Text(
                                          "Basic communication skills, poor memory, good to use occasionally"),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(Icons.thunderstorm),
                                  Text(
                                    "22",
                                    style: TextStyle(
                                        fontSize: 36.sp,
                                        color: Color.fromRGBO(78, 162, 79, 1)),
                                  ),
                                  Text(
                                    '/100',
                                    style: TextStyle(
                                        fontSize: 26.sp,
                                        color:
                                            Color.fromRGBO(102, 102, 102, 100)),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.add,
                                color: Color.fromRGBO(78, 162, 79, 1),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.w),
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.w),
                              color: const Color.fromRGBO(78, 162, 79, 1)),
                          child: LinearPercentIndicator(
                            percent: 0.5,
                            padding: EdgeInsets.zero,
                            progressColor: const Color.fromRGBO(78, 162, 79, 1),
                            lineHeight: 16.w,
                            barRadius: Radius.circular(15.w),
                            backgroundColor:
                                const Color.fromRGBO(230, 239, 226, 1),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 34.w),
                            padding: EdgeInsets.only(bottom: 20.w),
                            height: 185.w,
                            child: const SingleChildScrollView(
                              child: Text(
                                  "Basic communication skills, poor memory, gBasic communication skills, poor memory, good to use occasionallyBasic communication skills, poor memory, good to uBasic communication skills, poor memory, good to use occasionallyBasic communication skills, poor memory, good to uBasic communication skills, poor memory, good to use occasionallyBasic communication skills, poor memory, good to uood to use occasionallyBasic communication skills, poor memory, good to use occasionallyBasic communication skills, poor memory, good to use occasionally"),
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Stack(
                    children: [
                      Container(
                        child: Text("123123"),
                        width: double.infinity,
                        color: Colors.black,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 84.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                             
                            ),
                            child: Text(
                              'Chat now',
                              style: TextStyle(fontSize: 36.sp),
                            ),
                            onPressed: () {
                              Get.toNamed('/textToSpeech');
                            },
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              )));
    });
  }
}
