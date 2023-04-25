/*
 * @Date: 2023-04-23 19:37:53
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 16:52:03
 * @FilePath: \soulmate\lib\views\main\customRole\step1View.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/views/main/customRole/logic.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class CustomRolePage extends StatelessWidget {
  final logic = Get.put(CustomRoleLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Custom role", actions: [
      TextButton(
          onPressed: () {
            logic.step1ViewSubmit();
          },
          child: Text("Next"))
    ], child: GetBuilder<CustomRoleLogic>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
              child: Form(
                  key: logic.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24.w),
                        child: Text(
                          "Some question(1/3)",
                          style: TextStyle(fontSize: 36.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.w),
                        child: Text(
                          "Personality",
                          style: TextStyle(fontSize: 28.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.w),
                        child: TextFormField(
                          controller: logic.nameController,
                          validator: (v) {
                            return v!.trim().isNotEmpty
                                ? null
                                : "This field is required";
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              helperText: "",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: Color.fromRGBO(230, 230, 230, 1),
                                ),
                              ),
                              hintText: "Name"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.w),
                        child: Text(
                          "Gender",
                          style: TextStyle(fontSize: 28.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.w),
                        child: TextFormField(
                          controller: logic.genderController,
                          validator: (v) {
                            return v!.trim().isNotEmpty
                                ? null
                                : "This field is required";
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              helperText: "",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: Color.fromRGBO(230, 230, 230, 1),
                                ),
                              ),
                              hintText: "Enter"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.w),
                        child: Text(
                          "Age",
                          style: TextStyle(fontSize: 28.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 18.w),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: logic.ageController,
                          maxLength: 3,
                          validator: (v) {
                            return v!.trim().isNotEmpty
                                ? null
                                : "This field is required";
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              helperText: "",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: Color.fromRGBO(230, 230, 230, 1),
                                ),
                              ),
                              hintText: "Enter"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.w),
                        child: Text(
                          "Star level",
                          style: TextStyle(fontSize: 28.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 18.w),
                        child: Row(
                          children: renderStarList(),
                        ),
                      )
                    ],
                  ))),
        );
      },
    ));
  }

  List<Widget> renderStarList() {
    List<Widget> widgets = [];
    for (int i = 0; i < 5; i++) {
      onTap() async {
        Loading.toast("123");
        await Future.delayed(Duration(milliseconds: 2000));
        Loading.dismiss();
        if (i + 1 >= 3) {
          logic.star = i + 1;
        }
      }

      final icon = i < logic.star
          ? Icon(
              Icons.star,
              color: Colors.orange,
            )
          : Icon(Icons.star_border_outlined);
      widgets.add(GestureDetector(onTap: onTap, child: icon));
    }

    return widgets;
  }
}
