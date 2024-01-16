import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:soulmate/models/activety.dart';
import 'package:soulmate/models/roleEvent.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/role/role/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/src/widgets/focus_manager.dart';

class RoleEventController extends GetxController {
  final roleLogic = Get.find<RoleController>();
  late final arguments;
  RoleEvent? roleEvent;
  bool isLiked = false;
  bool sendLikeLoding = false;
  /// 发布时间
  int? publishTime;
  /// 事件图片
  String? eventImage;
  /// 事件内容
  String? eventContent;

  void setRoleEvent(RoleEvent value,{bool updateDetail = false}){
    roleEvent = value;
    publishTime = value.publishTime;
    eventImage = value.image;
    eventContent = value.content;
    likes.clear();
    comments.clear();
    isLiked = false;
    value?.activities.forEach((element) {
      if (element.type == 0) {
        likes.add(element);
        if (element.userId == Application.userInfo?.userId) {
          isLiked = true;
        }
      } else if (element.type == 1) {
        comments.add(element);
      }
    });
    if(updateDetail){
      roleLogic.updateOneEvent(value);
    }
    update();
  }

  List<Activity> likes = [];
  List<Activity> comments = [];

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    // TODO: implement onReady
    publishTime = Get.arguments['publishTime'];
    eventImage = Get.arguments['eventImage'];
    eventContent = Get.arguments['eventContent'];
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    arguments = Get.arguments;
    getEventDetail();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    controller.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void getEventDetail({bool updateDetail = false}) {
    final memoryId = arguments['memoryId'];
    if (memoryId == null) {
      return;
    }
    HttpUtils.diorequst('/role/roleEventById', query: {"memoryId": memoryId})
        .then((res) {
      RoleEvent roleEvent = RoleEvent.fromJson(res['data']);
      setRoleEvent(roleEvent,updateDetail: updateDetail);
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
    }).whenComplete(() {
      sendLikeLoding = false;
    });
  }

  void sendComment() {
    if (roleLogic.roleDetail == null ||
        roleEvent == null ||
        controller.text.isEmpty) {
      return;
    }

    HttpUtils.diorequst('/role/sendComment', method: 'post', params: {
      "roleId": roleLogic.roleDetail?.roleId,
      "comment": controller.text,
      "memoryId": roleEvent?.memoryId,
      "isAdd": true,
      "activityId": ""
    }).then((res) {
      controller.clear();
      focusNode.unfocus();
      getEventDetail(updateDetail: true);
    }).catchError((err) {
      exSnackBar(err.toString(), type: ExSnackBarType.error);
    });
  }

  void sendLike(bool liked) async {
    if (sendLikeLoding) {
      return;
    }
    sendLikeLoding = true;
    try {
      if (roleLogic.roleDetail != null && roleEvent != null) {
        final activity = likes.firstWhereOrNull(
          (element) =>
              element.type == 0 &&
              element.userId == Application.userInfo?.userId,
        );
        final res = await HttpUtils.diorequst("/role/sendLike",
            method: "post",
            params: {
              "roleId": roleEvent!.roleId!,
              "memoryId": roleEvent!.memoryId,
              "activityId": activity != null ? activity.activityId : "",
              "isAdd": activity == null,
            });
        if (res?['code'] == 200) {
          getEventDetail(updateDetail: true);
        }
      }
    } catch (err) {
      exSnackBar(err.toString(), type: ExSnackBarType.error);
    }
  }
}
