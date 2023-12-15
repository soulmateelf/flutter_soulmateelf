import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/mine/account/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class MineAccountPage extends StatelessWidget {
  MineAccountPage({super.key});

  final logic = Get.put(MineAccountController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineAccountController>(
      builder: (controller) {
        return basePage("Your account",
            backgroundColor: null,
            backGroundImage: null,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  Container(
                    height: 176.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          width: 112.w,
                          height: 112.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56.w),
                            border: Border.all(
                              width: 3.w,
                              color: borderColor,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(56.w),
                            child: controller.user?.avatar != null
                                ? CachedNetworkImage(
                                    imageUrl: controller.user!.avatar!,
                                    fit: BoxFit.cover,
                                    errorWidget: (_, __, ___) {
                                      return Image.asset(
                                          "assets/images/icons/avatar.png");
                                    },
                                  )
                                : Container(),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                showModalActionSheet(
                                    context: context,
                                    actions: [
                                      SheetAction(label: "photo album", key: 1)
                                    ]).then((key) async {
                                  if (key == 1) {
                                    final hasPermission =
                                        await Utils.checkPremission(
                                            Permission.photos);
                                    if (!hasPermission) return;
                                    final ImagePicker picker = ImagePicker();
                                    picker
                                        .pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 50)
                                        .then((file) async {
                                      logic.uploadHeadImg(file);
                                    }).catchError((err) {
                                      APPPlugin.logger.e(err);
                                    });
                                  }
                                }).catchError((err) {});
                              },
                              child: Container(
                                width: 35.w,
                                height: 35.w,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(18.w),
                                    border: Border.all(
                                      width: 3.w,
                                      color: Colors.white,
                                    )),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 17,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                "${controller.user?.email}",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.48),
                                  fontSize: 18.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              final back = await Get.toNamed('/mineNickname');
                              controller.getUser();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Nickname",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "${logic.user?.nickName}",
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.48),
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      WidgetSpan(
                                          child: Padding(
                                        padding: EdgeInsets.only(left: 14.w),
                                        child: Image.asset(
                                          "assets/images/icons/right_arrow.png",
                                          width: 20.w,
                                          height: 20.w,
                                        ),
                                      ))
                                    ]),
                                  )
                                ],
                              ),
                            )),
                        Divider(
                          height: 1,
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.toNamed('/mineUpdatePassword');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/icons/right_arrow.png",
                                    width: 20.w,
                                    height: 20.w,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Download an archive of your date",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Image.asset(
                                "assets/images/icons/right_arrow.png",
                                width: 20.w,
                                height: 20.w,
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Get.toNamed('/mineDeactivate');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Deactivate vour account",
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/icons/right_arrow.png",
                                    width: 20.w,
                                    height: 20.w,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
