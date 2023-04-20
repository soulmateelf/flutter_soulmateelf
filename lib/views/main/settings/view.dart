/*
 * @Date: 2023-04-12 15:49:59
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-20 13:45:04
 * @FilePath: \soulmate\lib\views\main\settings\view.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/config.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/widgets/settingsCard/settingsCard.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final userInfo = Application.userInfo;
    APPPlugin.logger.d(userInfo);

    return basePage(
      "",
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            margin: EdgeInsets.only(top: 10.w),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.w),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(children: [
                    Image.asset(
                      'assets/images/icons/avatar.png',
                      width: 160.w,
                      height: 160.w,
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                            constraints: BoxConstraints(
                                maxHeight: 160.w, minHeight: 160.w),
                            alignment: Alignment.center,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.camera_enhance,
                                    color: Colors.white,
                                  )),
                            )))
                  ]),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userInfo?["nickName"] ?? "Soulmate ELF",
                        style: TextStyle(
                          fontSize: 36.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.w),
                        child: Text(
                          userInfo?["email"] ?? "Lee012@gmail.com",
                          style: TextStyle(
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontSize: 28.sp,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Get.toNamed('/account');
                  },
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 120.w,
            margin: EdgeInsets.only(top: 10.w),
            color: Colors.green,
            child: Text('advance'),
          ),
          // SettingsCard(
          //     icon: Icon(Icons.money),
          //     text: "Discount voucher",
          //     onTab: () {
          //       Get.toNamed("/discount");
          //     }),
          SettingsCard(
              icon: Icon(Icons.money),
              text: "Purchase history",
              onTab: () {
                Get.toNamed('/purchaseHistory');
              }),
          SettingsCard(
              icon: Icon(Icons.money),
              text: "Send feedback",
              onTab: () {
                Get.toNamed('/sendFeedback');
              }),
          SettingsCard(
              icon: Icon(Icons.money),
              text: "Privacy Policy",
              onTab: () {
                Get.toNamed('/webview', arguments: {
                  'title': 'Privacy Policy',
                  'url': ProjectConfig.getInstance()
                      ?.baseConfig['PrivacyPolicyUrl']
                });
              }),
          SettingsCard(
              icon: Icon(Icons.money),
              text: "Terms of Service",
              onTab: () {
                Get.toNamed('/webview', arguments: {
                  'title': 'Terms of Service',
                  'url': ProjectConfig.getInstance()
                      ?.baseConfig['TermsofServiceUrl']
                });
              }),
        ],
      )),
    );
  }
}
