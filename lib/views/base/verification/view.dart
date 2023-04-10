/*
 * @Date: 2023-04-10 18:59:42
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-10 19:46:42
 * @FilePath: \soulmate\lib\views\base\verification\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Row(children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            },
            color: Color.fromRGBO(153, 153, 153, 1),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: const Text(
              "Back",
              style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          )
        ]),
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        leadingWidth: 1.sw,
      ),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "Create your account",
              style: TextStyle(
                fontSize: 48.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.w),
            child: Text(
              "Enter it below to verify your account.",
              style: TextStyle(
                fontSize: 22.sp,
                color: Color.fromRGBO(102, 102, 102, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.w),
            child: PinCodeTextField(
                appContext: context,
                length: 6,
                pinTheme: PinTheme(
                  inactiveColor: Color.fromRGBO(230, 230, 230, 1),
                ),
                onCompleted: (value) {
                  print(value);
                  Get.toNamed('/setPassword');
                },
               
                onChanged: (value) {
                  print(value);
                }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.w),
            child: TextButton(
              onPressed: () {
                print('resend code');
              },
              child: Text(
                'Resend code.',
                style: TextStyle(color: Color.fromRGBO(78, 162, 79, 1)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
