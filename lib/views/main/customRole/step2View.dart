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
                  "Character introduction(1)",
                  style: TextStyle(fontSize: 28.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.w),
                child: Wrap(
                  spacing: 20.w,
                  runSpacing: 20.w,
                  children: [
                    Container(
                      height: 60.w,
                      padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.w)),
                          color: Color.fromRGBO(244, 244, 244, 1)),
                      child: Text(
                        "Courage",
                        style: TextStyle(fontSize: 28.sp),
                      ),
                    ),
                    Container(
                      height: 60.w,
                      padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.w)),
                          color: Colors.green),
                      child: Text(
                        "Humility",
                        style: TextStyle(color: Colors.white, fontSize: 28.sp),
                      ),
                    ),
                    Container(
                      height: 60.w,
                      padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.w)),
                          color: Color.fromRGBO(244, 244, 244, 1)),
                      child: Text(
                        "Courage",
                        style: TextStyle(fontSize: 28.sp),
                      ),
                    ),
                    Container(
                      height: 60.w,
                      padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.w)),
                          color: Color.fromRGBO(244, 244, 244, 1)),
                      child: Text(
                        "Courage",
                        style: TextStyle(fontSize: 28.sp),
                      ),
                    ),
                    Container(
                      height: 60.w,
                      padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.w)),
                          color: Color.fromRGBO(244, 244, 244, 1)),
                      child: Text(
                        "Courage",
                        style: TextStyle(fontSize: 28.sp),
                      ),
                    ),
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
