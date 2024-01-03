import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:soulmate/models/activety.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/role/roleEvent/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/cupertino.dart';

class RoleEventPage extends StatelessWidget {
  RoleEventPage({super.key});

  final logic = Get.put(RoleEventController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoleEventController>(
      builder: (controller) {
        final roleEvent = controller.roleEvent;
        return basePage(
            "${roleEvent?.publishTime != null ? DateTime.fromMillisecondsSinceEpoch(roleEvent!.publishTime).format(payload: "DD MMM") : ""}",
            backGroundImage: null,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            width: double.infinity,
                            height: 328.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: roleEvent?.image != null
                                ? CachedNetworkImage(
                                    width: double.infinity,
                                    height: 328.w,
                                    fit: BoxFit.cover,
                                    imageUrl: roleEvent!.image!,
                                    placeholder: (context, url) =>
                                        const CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Container(),
                                  )
                                : null,
                          ),
                          SizedBox(
                            height: 12.w,
                          ),
                          Text(
                            "${roleEvent?.content ?? ""}",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.64),
                              fontSize: 16.sp,
                              height: 1.6,
                            ),
                          ),
                          SizedBox(
                            height: 24.w,
                          ),
                          Row(
                            children: [
                              // Icon(
                              //   Icons.thumb_up_off_alt_outlined,
                              //   size: 20.sp,
                              //   color: primaryColor,
                              // ),
                              LikeButton(
                                size: 20.sp,
                                isLiked: controller.isLiked,
                                circleColor: CircleColor(
                                    start: Colors.grey, end: primaryColor),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: primaryColor,
                                  dotSecondaryColor: primaryColor,
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.thumb_up_off_alt_outlined,
                                    color: isLiked ? primaryColor : Colors.grey,
                                    size: 20.sp,
                                  );
                                },
                                onTap: (liked) async {
                                  controller.sendLike(liked);
                                },
                              ),
                              ...renderLikes(controller.likes),
                            ],
                          ),
                          SizedBox(
                            height: 12.w,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(borderRadius),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                ...renderComments(controller.comments),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BorderDirectional(
                      top: BorderSide(
                        width: 1.w,
                        color: Color.fromRGBO(225, 230, 234, 1),
                      ),
                    ),
                  ),
                  child: Container(
                    height: 56.w,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: TextField(
                      controller: controller.controller,
                      cursorColor: primaryColor,
                      textInputAction: TextInputAction.send,
                      onEditingComplete: () {
                        controller.sendComment();
                      },
                      focusNode: controller.focusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Comment",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.48),
                          fontSize: 18.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  List<Widget> renderLikes(List<Activity> activities) {
    List<Widget> list = [];

    activities.forEach((element) {
      list.add(Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: CachedNetworkImage(
            width: 30.w,
            height: 30.w,
            imageUrl: element.avatar,
            fit: BoxFit.cover,
            placeholder: (_, __) => CupertinoActivityIndicator(),
            errorWidget: (_, __, ___) => Image.asset(
              "assets/images/icons/avatar.png",
              width: 30.w,
              height: 30.w,
              fit: BoxFit.cover,
            ),
          )));
    });

    return list;
  }

  List<Widget> renderComments(List<Activity> activities) {
    List<Widget> list = [];

    activities.forEach((element) {
      list.add(Container(
        padding: EdgeInsets.all(16.w),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              clipBehavior: Clip.hardEdge,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: CachedNetworkImage(
                width: 40.w,
                height: 40.w,
                fit: BoxFit.cover,
                imageUrl: element.avatar,
                placeholder: (_, __) => const CupertinoActivityIndicator(),
                errorWidget: (_, __, ___) => Image.asset(
                  "assets/images/icons/avatar.png",
                  width: 40.w,
                  height: 40.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${element.userName}",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.sp,
                    fontFamily: FontFamily.SFProRoundedBlod,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${element.content}",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.64),
                    fontSize: 16.sp,
                  ),
                ),
              ],
            )),
            SizedBox(
              width: 12.w,
            ),
            Text(
              "${Utils.messageTimeFormat(element.createTime)}",
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.24), fontSize: 12.w),
            )
          ],
        ),
      ));
    });

    return list;
  }
}
