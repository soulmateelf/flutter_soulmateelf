import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class MineDownloadDataPage extends StatelessWidget {
  MineDownloadDataPage({super.key});

  final logic = Get.put(MineDownloadDataController());

  @override
  Widget build(BuildContext context) {
    return basePage("Download data",
        backGroundImage: null,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    borderRadius,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    """You can request an xlsx file with an archive of your account information, apps and devices, order record. You'll get an in-app notification when the archive of your data is ready to download.
                    
                     Once your file is ready, it will be available to download in a zipped format for up to 4 days.It will expire if you reguest data again. After downloading, select the file to unzip it and view your data. 
                    """,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: textColor,
                    ),
                  ),
                ),
              )),
              SizedBox(
                height: 12.w,
              ),
              Container(
                width: double.infinity,
                height: 64.w,
                child: MaterialButton(
                  onPressed: () {
                    logic.showDownloadDialog();
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Text(
                    "Download",
                    style: TextStyle(
                      color: errorTextColor,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
