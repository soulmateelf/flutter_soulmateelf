import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:get/get.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatLogic extends GetxController {
  ///刷新控制器
  RefreshController refreshController = RefreshController(initialRefresh: false);
  ///滚动控制器
  ScrollController scrollController = ScrollController();
  ///输入框焦点
  FocusNode focusNode = FocusNode();
  ///右侧图标类型   normal 正常  input 文本输入状态
  String iconType = 'normal';
  ///角色id
  int roleId = -1;
  ///角色信息
  var roleInfo = {};
  ///消息列表
  List messageList = [];
  ///页码
  int page = 0;
  ///可以下拉刷新
  bool canRefresh = true;
  ///消息输入框内容
  String inputContent = '';
  ///语音转文字
  SpeechToText speechToText = SpeechToText();
  ///语音转文字是否可用
  bool speechEnabled = false;
  ///语音转文字是否正在录音
  bool isRecording = false;
  ///语音转文字的结果
  String speechResult = '';
  ///开始录音的屏幕位置
  double startPosition = 0.0;
  ///是否是取消录音状态
  bool cancelStatus = false;

  @override
  void onInit() {
    super.onInit();
    roleId = Get.arguments['roleId'];

    ///初始化语音转文字
    initSpeechToText();

    ///初始化消息输入框监听
    initMessageInputListener();

    ///获取角色信息
    getRoleInfo();

    ///获取消息列表
    getMessageList('init');
  }

  @override
  void onClose() {
    speechToText.stop();
    refreshController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  ///初始化语音转文字
  initSpeechToText() async {
    speechEnabled = await speechToText.initialize();
  }

  ///初始化消息输入框监听
  initMessageInputListener() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        iconType = 'input';
      } else {
        iconType = 'normal';
      }
      update();
    });
  }

  ///获取角色信息
  getRoleInfo() {
    Map<String, dynamic> params = {'roleId': roleId};
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
  void getMessageList(from) {
    Map<String, dynamic> params = {
      'pageNum': from == 'newMessage' ? 1 : (page + 1),
      'pageSize': from == 'newMessage' ? 2 : 10,
      'roleId': roleId
    };
    void successFn(res) {
      page++;
      refreshController.refreshCompleted();
      if (from == 'newMessage') {
        ///新消息，往下加
        messageList.addAll(res['data']['data']);
      } else {
        ///历史消息,往上插入
        messageList.insertAll(0, res['data']['data']);
      }

      if (res['data']['data'] == null || res['data']['data'].length == 0) {
        ///没有更多数据了
        canRefresh = false;
      } else {
        canRefresh = true;
      }
      update();
      if (from != 'refresh') {
        ///新消息或者第一页，滚动到底部
        Future.delayed(Duration(milliseconds: 300), () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
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
  void sendMessage(String message) {
    if (Utils.isEmpty(message)) {
      return;
    }
    focusNode.unfocus();
    showLoadingMask();
    Map<String, dynamic> params = {
      'message': message,
      'roleId': roleId.toString()
    };

    void successFn(res) {
      EasyLoading.dismiss();
      //清空当前消息
      message = '';
      speechResult = '';
      focusNode.unfocus();
      update();
      //获取最新消息列表
      getMessageList('newMessage');
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

  ///时间显示逻辑
  showTime(dynamic itemData, int index) {
    var date = DateTime.fromMillisecondsSinceEpoch(itemData['createTime'].toInt());
    var computeDate = DateTime(date.year, date.month, date.day);
    var now = new DateTime.now();
    var diffDays = now.difference(computeDate).inDays;
    var result = date.format(payload: 'LL HH:mm');
    if (diffDays == 0) {
      result = date.format(payload: 'HH:mm');
    } else if (diffDays == 1) {
      result = 'yesterday ${date.format(payload: 'HH:mm')}';
    } else if ([2, 3, 4, 5, 6, 7].contains(diffDays)) {
      result = date.format(payload: 'dddd HH:mm');
    }
    return result;
  }

  ///开始录音
  void startListening(event) async {
    if (!speechEnabled) {
      EasyLoading.showToast('please open the microphone permission!');
      return;
    }
    if (!isRecording) {
      ///开始录音,不能重复启动
      ///震动反馈
      HapticFeedback.vibrate();
      ///开始录音状态
      isRecording = true;
      ///记录开始录音的屏幕位置
      startPosition = event.globalPosition.dy;
      update();
      await speechToText.listen(onResult: onSpeechResult);
    }
  }
  ///手指滑动事件
  moveListening(event) {
    if (!isRecording) {
      return;
    }
    ///滑动的距离
    var moveDistance = startPosition - event.globalPosition.dy;
    if (moveDistance > 100.w) {
      ///滑动超过100，提示取消录音
      cancelStatus = true;
    } else {
      cancelStatus = false;
    }
    update();
  }
  ///停止录音
  void stopListening() async {
    if (!speechEnabled || !isRecording) {
      return;
    }
    await speechToText.stop();
    isRecording = false;
    startPosition = 0;
    update();
    ///如果手指移动位置大，是取消录音状态，那么停止的时候就不要去发送消息了
    if(cancelStatus){
      cancelStatus = false;
      return;
    }
    if (Utils.isEmpty(speechResult)) {
      EasyLoading.showToast('please say it again!');
      return;
    }
    sendMessage(speechResult);
  }

  ///录音监听转化结果
  void onSpeechResult(SpeechRecognitionResult result) {
    speechResult = result.recognizedWords;
  }
}
