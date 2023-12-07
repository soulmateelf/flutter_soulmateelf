import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';

import '../../../utils/core/constants.dart';
import '../../../widgets/library/projectLibrary.dart';

class Step2Controller extends GetxController {
  final nameController = TextEditingController();
  String genderType = "male";

  void setGender(String s) {
    genderType = s;
    update();
  }

  double age = 1.00;
  final hobbyController = TextEditingController();
  final introductionController = TextEditingController();
  final remarkController = TextEditingController();
  XFile? avatar;

  void uploadAvatar() {
    Utils.pickerImage(Get.context!).then((files) {
      APPPlugin.logger.d(files);
      if (files.length > 0) {
        avatar = files[0];
        update();
      }
    }).catchError((err) {
      APPPlugin.logger.e(err);
    });
  }

  void submit() {
    if (nameController.text.isEmpty ||
        hobbyController.text.isEmpty ||
        introductionController.text.isEmpty) {
      return;
    }

    FormData fd = FormData.fromMap({
      "orderId": "",
      "receipt": "",
      "purchaseID": "",
      "appleProductID": "",
      "transactionDate": "",
      "verificationData": "",
      "age": age,
      "gender": genderType,
      "name": nameController.text,
      "Hobby": hobbyController.text,
      "characterIntroduction": introductionController.text,
    });

    if (!remarkController.text.isEmpty) {
      fd.fields.add(MapEntry("remark", remarkController.text));
    }

    if (avatar != null) {
      fd.files.add(MapEntry("file", MultipartFile.fromFileSync(avatar!.path)));
    }
    showDialog(
        context: Get.context!,
        builder: (_) {
          return MakeDialog(
              iconWidget: Image.asset("assets/images/image/successfully.png"),
              content: Container(
                child: Column(
                  children: [
                    Text(
                      "Are you sure you want to pay \$199 to customize your ELF? And don't worry, after paying you will have three chances to amend or get a half price refund.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 22.sp,
                          fontFamily: FontFamily.SFProRoundedMedium),
                    ),
                    SizedBox(
                      height: 32.w,
                    ),
                    Container(
                      height: 64.w,
                      width: double.infinity,
                      child: MaterialButton(
                        color: primaryColor,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Text(
                          "Pay now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontFamily: FontFamily.SFProRoundedBlod,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 64.w,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.32),
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
        });
  }
}
