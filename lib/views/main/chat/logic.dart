import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';

class ChatLogic extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: false);//刷新控制器
  FocusNode focusNode = FocusNode();//输入框焦点
  String iconType = 'normal';///右侧图标类型   normal 正常  input 文本输入状态
  int roleId = -1;///角色id
  var roleInfo = {};///角色信息
  List messageList = [];///消息列表
  int page = 0; ///页码
  bool canRefresh = true;///可以下拉刷新
  String currentMessage = '';///当前消息
  @override
  void onInit() {
    super.onInit();
    roleId = Get.arguments['roleId'];
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        iconType = 'input';
      }else{
        iconType = 'normal';
      }
      update();
    });
    getRoleInfo();
    getMessageList();
  }
  ///获取角色信息
  getRoleInfo(){
    Map<String, dynamic> params = {
      'roleId': roleId
    };
    void successFn(res) {
      roleInfo = res['data'];
      update();
    }

    void errorFn(error) {
      exSnackBar(error['message'], type: 'error');
    }

    return NetUtils.diorequst(
      '/role/roleById',
      'get',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }
  ///获取消息列表
  void getMessageList({bool newMessage = false}) {
    Map<String, dynamic> params = {
      'pageNum': newMessage ? 1:(page + 1),
      'pageSize': newMessage ? 2:10,
      'roleId': roleId
    };

    void successFn(res) {
      page++;
      refreshController.refreshCompleted();
      APPPlugin.logger.d(res);
      if(newMessage){
        ///新消息，往下加
        messageList.addAll(res['data']['data']);
      }else{
        ///历史消息,往上插入
        messageList.insertAll(0, res['data']['data']);
      }

      if (res['data']['data']== null || res['data']['data'].length == 0) {
        ///没有更多数据了
        canRefresh = false;
      }else{
        canRefresh = true;
      }
      update();
    }

    void errorFn(error) {
      refreshController.refreshFailed();
      exSnackBar(error['message'], type: 'error');
    }

    NetUtils.diorequst(
      '/message/list',
      'get',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }
  ///发送消息
  void sendMessage() {
    if(Utils.isEmpty(currentMessage)){
      return;
    }
    focusNode.unfocus();
    showLoadingMask();
    Map<String, dynamic> params = {
      'message': currentMessage,
      'roleId': roleId.toString()
    };

    void successFn(res) {
      EasyLoading.dismiss();
      //清空当前消息
      currentMessage = '';
      focusNode.unfocus();
      update();
      //获取最新消息列表
      getMessageList(newMessage: true);
    }

    void errorFn(error) {
      EasyLoading.dismiss();
      exSnackBar(error['message'], type: 'error');
    }

    NetUtils.diorequst(
      '/message/chat',
      'post',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }
}
