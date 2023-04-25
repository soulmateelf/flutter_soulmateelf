/*
 * @Date: 2023-04-24 14:41:38
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 17:31:19
 * @FilePath: \soulmate\lib\views\main\customRole\step2view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CustomRoleStep2Page extends StatelessWidget {
  final logic = Get.put(CustomRoleLogic());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Custom role", actions: [
      TextButton(
          onPressed: () {
            logic.step2ViewSubmit();
          },
          child: Text("Next"))
    ], child: GetBuilder<CustomRoleLogic>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(24.w),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24.w),
                child: Text(
                  "Some question(2/3)",
                  style: TextStyle(fontSize: 36.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.w),
                child: Text(
                  "Character introduction(${logic.checkedCharacterIdList.length})",
                  style: TextStyle(fontSize: 28.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.w),
                child: Wrap(
                  spacing: 20.w,
                  runSpacing: 20.w,
                  children: renderCharterList(),
                ),
              )
            ],
          )),
        );
      },
    ));
  }

  List<Widget> renderCharterList() {
    var widgets = <Widget>[];
    logic.characterList.forEach((character) {
      final checked =
          logic.checkedCharacterIdList.any((id) => id == character["id"]);
      widgets.add(InkWell(
        onTap: () {
          logic.changeCharacterStatus(character["id"]);
        },
        child: Container(
          height: 60.w,
          padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.w)),
              color: checked ? Colors.green : Color.fromRGBO(244, 244, 244, 1)),
          child: Text(
            "${character?["roleCharacter"]}",
            style: TextStyle(
                color: checked ? Colors.white : null, fontSize: 28.sp),
          ),
        ),
      ));
    });
    return widgets;
  }
}
