/*
 * @Date: 2023-04-12 17:35:24
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-13 19:25:41
 * @FilePath: \soulmate\lib\widgets\settingsCard\settingsCard.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsCard extends StatelessWidget {
  Icon icon = const Icon(Icons.arrow_back_ios_new);
  String text = "";
  Function onTab = () {};
  SettingsCard(
      {super.key, required this.icon, required this.text, required this.onTab});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      child: Ink(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            onTab();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            height: 84.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.w),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 28.sp),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 28.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
