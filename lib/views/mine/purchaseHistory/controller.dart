import 'package:get/get.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

import 'package:pull_to_refresh/src/smart_refresher.dart';
import '../../../models/order.dart';

class MinePurchaseHistoryController extends GetxController {
  final RefreshController refreshController = RefreshController();

  List<Order> orderList = [];
  int page = 1;
  int size = 10;

  void getOrderList(String type) {
    if (type == "refresh") {
      page = 1;
    } else if (type == "loadMore") {
      page++;
    }
    HttpUtils.diorequst('/order/orderList', query: {
      "page": page,
      "size": 10,
    }).then((res) {
      List<dynamic> data = res['data'] ?? [];
      final list = data.map((e) => Order.fromJson(e)).toList();
      if (type == "refresh") {
        orderList = list;
        refreshController.refreshCompleted();
      } else if (type == "loadMore") {
        orderList.addAll(list);
        refreshController.loadComplete();
      }
      update();
    }).catchError((err) {
      exSnackBar(err, type: ExSnackBarType.error);
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getOrderList("refresh");
    super.onReady();
  }
}
