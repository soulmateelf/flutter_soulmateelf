/*
 * @Date: 2023-04-24 15:27:55
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-26 14:35:05
 * @FilePath: \soulmate\lib\views\main\customRole\step3view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CustomRoleStep3Page extends StatelessWidget {
  final logic = Get.put(CustomRoleLogic());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Custom role", child: GetBuilder<CustomRoleLogic>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Form(
              key: logic.step3FormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(24.w),
                    width: double.infinity,
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 24.w),
                          child: Text(
                            "Some question(3/3)",
                            style: TextStyle(fontSize: 36.sp),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.w),
                          child: Text(
                            "Character introduction",
                            style: TextStyle(fontSize: 28.sp),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 18.w),
                          child: TextFormField(
                            controller: logic.introductionController,
                            maxLines: 7,
                            validator: (v) {
                              return v!.trim().isNotEmpty
                                  ? null
                                  : "This field is required";
                            },
                            decoration: InputDecoration(
                                hintText: "Enter",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  width: 1.w,
                                ))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.w),
                          child: Text(
                            "Anything else to add",
                            style: TextStyle(fontSize: 28.sp),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 18.w),
                          child: TextFormField(
                            maxLines: 7,
                            controller: logic.replenishController,
                            decoration: InputDecoration(
                                hintText: "Enter",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  width: 1.w,
                                ))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.w),
                          child: TextFormField(
                            controller: logic.emailController,
                            decoration: InputDecoration(
                                labelText: "Email for contact",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  width: 1.w,
                                ))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 18.w),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    logic.sendEmail = !logic.sendEmail;
                                  },
                                  child: logic.sendEmail
                                      ? Icon(
                                          Icons.check_box,
                                          color: Colors.green,
                                        )
                                      : Icon(Icons.check_box_outline_blank),
                                ),
                                Text(
                                  "We may email you for more information or updates.",
                                  style: TextStyle(fontSize: 22.sp),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  )),
                  Container(
                    height: 140.w,
                    width: double.infinity,
                    padding: EdgeInsets.all(30.w),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.w, color: Colors.grey))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\$ ${logic.price}"),
                        ElevatedButton(
                            onPressed: () {
                              logic.payNow();
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(33.w)))),
                            child: Text("Pay now"))
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    ));
  }
}
