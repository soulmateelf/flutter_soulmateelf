/*
 * @Date: 2023-04-26 09:36:22
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-26 15:45:14
 * @FilePath: \soulmate\lib\views\main\purchaseHistory\logic.dart
 */

import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';

class PurchaseHistoryLogic extends GetxController {
  ///刷新控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
  void getOrderList({bool loadMore = false}) {
    Map<String, dynamic> params = {'pageNum': page + 1, 'pageSize': 10};
    void successFn(res) {
      /// 重置允许上拉加载更多变量
      refreshController.resetNoData();
      page++;
      List resList = res?['data']?['data'] ?? [];
      if (loadMore) {
        //加载更多
        orderList.addAll(resList);
        refreshController.loadComplete();
      } else {
        //刷新
        orderList = resList;
        refreshController.refreshCompleted();
      }
      if (resList.length == 0) {
        //没有更多数据了
        refreshController.loadNoData();
        // 不允许上拉加载更多
        refreshController.footerMode?.value = LoadStatus.noMore;
      }
      update();
    }

    void errorFn(error) {
      if (refreshController.isLoading) {
        refreshController.loadFailed();
      } else if (refreshController.isRefresh) {
        refreshController.refreshFailed();
      }
      Loading.error(error['message']);
    }

    NetUtils.diorequst(
      '/base/orderHistory',
      'post',
      params: params,
      successCallBack: successFn,
      errorCallBack: errorFn,
    );
  }

  void onRefresh() {
    //下拉刷新
    page = 0;
    getOrderList();
  }

  void onLoading() {
    //上拉加载更多
    getOrderList(loadMore: true);
  }
}
