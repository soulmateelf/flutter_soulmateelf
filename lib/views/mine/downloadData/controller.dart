import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../utils/core/application.dart';
import '../../../utils/core/constants.dart';
import '../../../utils/core/httputil.dart';
import '../../../widgets/library/projectLibrary.dart';

class MineDownloadDataController extends GetxController {
  User? user;
  MakeDialogController makeDialogController = MakeDialogController();

  bool downloadLoading = false;

  void downloadData() {
    if (downloadLoading) {
      return;
    }
    downloadLoading = true;
    HttpUtils.diorequst("/user/downloadUserData", query: {
      "email": user?.email,
    }).then((res) {
      if (res?['data'] == true) {
        makeDialogController.close();
        Future.delayed(Duration(milliseconds: 300), () {
          Get.back();
          exSnackBar(res?['message']);
        });
      }
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
    }).whenComplete(() {
      downloadLoading = false;
    });
  }

  void showDownloadDialog() {
    makeDialogController.show(
        iconWidget: Image.asset("assets/images/icons/downloadIcon.png"),
        content: Column(
          children: [
            Text(
              "Donwload",
              style: TextStyle(
                color: textColor,
                fontSize: 32.sp,
                fontFamily: FontFamily.SFProRoundedSemibold,
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              "Are you sure you want to download?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.48),
                fontFamily: FontFamily.SFProRoundedMedium,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(
              height: 30.w,
            ),
            Container(
              height: 64.w,
              width: double.maxFinite,
              child: TextButton(
                  onPressed: () {
                    downloadData();
                  },
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.w)))),
                  child: Text(
                    "yes，download",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.w,
                      fontFamily: FontFamily.SFProRoundedBlod,
                    ),
                  )),
            ),
            SizedBox(
              height: 10.w,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                makeDialogController.close();
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.32),
                    fontSize: 20.sp,
                    fontFamily: FontFamily.SFProRoundedMedium,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.w,
            ),
          ],
        ),
        controller: makeDialogController,
        context: Get.context!);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = Application.userInfo;
    update();
  }
}
