/*
 * @Date: 2023-04-12 18:45:02
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-13 09:55:37
 * @FilePath: \soulmate\lib\views\main\account\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Your account",
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.w),
                  padding: EdgeInsets.all(24.w),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text("Email")),
                      Text("Lee023@gmail.com")
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.w),
                  child: Ink(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("Nickname")),
                            Text("lee012356485"),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.w),
                  child: Ink(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/updatePassword');
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("Password")),
                            Text("********"),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.w),
                  child: Ink(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child:
                                    Text("Download an archive of your date")),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.w),
                  child: Ink(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/deactivate');
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("Deactivate vour account")),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 144.w),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Log out",
                        style: TextStyle(color: Colors.red, fontSize: 28.sp),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
