/// Author: kele
/// Date: 2022-01-13 15:16:49
/// LastEditors: kele
/// LastEditTime: 2022-03-07 16:27:08
/// Description:

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:soulmate/models/message.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'controller.dart';

class MessagePage extends StatelessWidget {
  final logic = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return basePage('Messages',
        backGroundImage: null,
        backgroundColor: Color.fromARGB(1, 242, 242, 242),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: GetBuilder<MessageController>(
                  builder: (controller) {
                    return CupertinoSlidingSegmentedControl<MessageTabKey>(
                        groupValue: controller.tabKey,
                        padding: EdgeInsets.all(4.w),
                        children: {
                          MessageTabKey.normal: Container(
                            height: 44.w,
                            alignment: Alignment.center,
                            child: Text(
                              "Normal",
                              style: TextStyle(
                                fontFamily: FontFamily.SFProRoundedBlod,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: controller.tabKey != MessageTabKey.normal
                                    ? Colors.black45
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          MessageTabKey.system: Container(
                            height: 44.w,
                            alignment: Alignment.center,
                            child: Text(
                              "System",
                              style: TextStyle(
                                fontFamily: FontFamily.SFProRoundedBlod,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: controller.tabKey != MessageTabKey.system
                                    ? Colors.black45
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        },
                        onValueChanged: (value) {
                          controller.tabKey = value!;
                        });
                  },
                ),
              ),
              SizedBox(
                height: 16.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SmartRefresher(
                    controller: logic.controller,
                    onRefresh: () {
                      logic.getMessages(
                          logic.tabKey == MessageTabKey.normal ? 0 : 1);
                    },
                    onLoading: () {
                      logic.getMessages(
                          logic.tabKey == MessageTabKey.normal ? 0 : 1,
                          action: "add");
                    },
                    enablePullUp: true,
                    child: GetBuilder<MessageController>(
                      builder: (controller) {
                        final messages =
                            controller.tabKey == MessageTabKey.normal
                                ? controller.normalMessages
                                : controller.systemMessages;

                        return messages.isEmpty
                            ? listViewNoDataPage(
                                isShowNoData: messages.isEmpty,
                                omit: 'No data',
                                child: Container())
                            : SingleChildScrollView(
                                child: Column(
                                  children: renderCardList(messages),
                                ),
                              );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> renderCardList(List<Message> messages) {
    List<Widget> list = [];
    messages.forEach((element) {
      list.add(Stack(
        children: [
          Container(
            height: 149.w,
            margin: EdgeInsets.only(bottom: 8.w),
            padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${element.title}",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: textColor,
                    fontFamily: FontFamily.SFProRoundedBlod,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.w,
                ),
                Text(
                  "${element.content}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color.fromRGBO(0, 0, 0, 0.48),
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${DateTime.fromMillisecondsSinceEpoch(element.createTime).format(payload: "YYYY-MM-DD HH:mm")}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Color.fromRGBO(0, 0, 0, 0.48),
                    ),
                  ),
                ),
              ],
            ),
          ),
          element.readStatus == 0
              ? Positioned(
                  top: 23.w,
                  right: 15.w,
                  child: Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 90, 90, 1),
                        borderRadius: BorderRadius.circular(6.w)),
                  ),
                )
              : Container(),
        ],
      ));
    });
    return list;
  }
}
