import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';

class PurchaseHistoryLogic extends GetxController {
  ///刷新控制器
  RefreshController refreshController = RefreshController(initialRefresh: false);
  ///订单列表
  List orderList = [];
  ///页码
  int page = 0;

  @override
  void onInit() {
    super.onInit();
    ///获取订单列表
    getOrderList();
  }

  ///获取消息列表
  void getOrderList() {
    Map<String, dynamic> params = {
      'pageNum': page + 1,
      'pageSize': 10,
    };
    void successFn(res) {
      page++;
      refreshController.refreshCompleted();
      if (page == 1) {
        orderList = res['data']['list'];
      } else {
        orderList.addAll(res['data']['list']);
      }
      update();

    }

    void errorFn(error) {
      refreshController.refreshFailed();
      exSnackBar(error['message'], type: 'error');
    }

    NetUtils.diorequst(
      '/base/orderHistory',
      'get',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }

}
