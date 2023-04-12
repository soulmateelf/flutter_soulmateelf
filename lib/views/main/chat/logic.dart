import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';

class ChatLogic extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  List messageList = [
    {'id':1,'role':'user','content':'上课时间是框架'},
    {'id':2,'role':'assistant','content':'到今年的考虑的考虑'},
    {'id':3,'role':'user','content':'wwhwjwjwkkwwnjwwkwkw'},
    {'id':4,'role':'assistant','content':'上课时间是框架'},

  ];///数据
  int page = 0; ///页码
  bool canRefresh = true;///可以下拉刷新
  @override
  void onInit() {
    super.onInit();
    // getDataList();
  }

  /// Author: kele
  /// Date: 2022-03-11 16:36:25
  /// Params:
  /// Return:
  /// Description: 获取数据
  /// UpdateUser: kele
  /// UpdateDate:
  /// UpdateRemark:
  Future getDataList() {
    Map<String, dynamic> params = {
      'currentPage': page + 1,
      'pageSize': 10,
    };

    void successFn(res) {
      page++;
      refreshController.refreshCompleted();
      messageList.addAll(res['data']['list']);
      if (res['data']['list']== null ||
          res['data']['list'].length == 0) {
        ///没有更多数据了
        canRefresh = false;
      }
      update();
    }

    void errorFn(error) {
      refreshController.refreshFailed();
      exSnackBar(error['message'], type: 'error');
    }

    return NetUtils.diorequst(
      '/iot4-crpm-api/message/list',
      'get',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }
}
