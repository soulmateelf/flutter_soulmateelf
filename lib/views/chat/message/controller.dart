/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'package:get/get.dart';
import 'package:soulmate/models/message.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/views/base/menu/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';

enum MessageTabKey {
  system,
  normal,
}

class MessageController extends GetxController {
  MessageTabKey _tabKey = MessageTabKey.normal;

  MessageTabKey get tabKey => _tabKey;

  int normalPage = 0;
  int systemPage = 0;
  List<Message> normalMessages = [];
  List<Message> systemMessages = [];

  RefreshController normalController = RefreshController();

  RefreshController systemController = RefreshController();

  SoulMateMenuController menuController = Get.find<SoulMateMenuController>();

  set tabKey(MessageTabKey value) {
    _tabKey = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    return;
  }

  @override
  void onReady() {
    super.onReady();
    getMessages(0);
    getMessages(1);
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }

  void getMessages(int type, {String? action}) {
    bool isAdd = action == "add";
    late RefreshController controller;
    late int page;
    if (type == 0) {
      if(!isAdd) {
        normalPage = 0;
      }
      page = normalPage;
      controller = normalController;
    } else if (type == 1) {
      if(!isAdd) {
        systemPage = 0;
      }
      page = systemPage;
      controller = systemController;
    }

    HttpUtils.diorequst('/message/messageList',
        query: {"page": page+1, "size": 10, "messageType": type}).then((res) {
      List<dynamic> data = res?['data'] ?? [];
      List<Message> list = data.map((e) => Message.fromJson(e)).toList();
      if (type == 0) {
        if (isAdd) {
          normalMessages.addAll(list);
        } else {
          normalMessages = list;
        }
      } else if (type == 1) {
        if (isAdd) {
          systemMessages.addAll(list);
        } else {
          systemMessages = list;
        }
      }
      if (controller.isRefresh) {
        controller.refreshCompleted();
        controller.resetNoData();
      }
      if (controller.isLoading) {
        controller.loadComplete();
      }
      if (data.isEmpty) {
        controller.loadNoData();
      }
      if (type == 0) {
        normalPage++;
      } else {
        systemPage++;
      }
      update();
    }).catchError((err) {
      if (controller.isRefresh) {
        controller.refreshFailed();
      }
      if (controller.isLoading) {
        controller.loadFailed();
      }
      update();
      exSnackBar(err, type: ExSnackBarType.error);
    });
  }
}
