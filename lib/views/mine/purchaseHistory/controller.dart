import 'package:get/get.dart';
import 'package:soulmate/models/order.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';

class MinePurchaseHistoryController extends GetxController {
  final RefreshController refreshController = RefreshController();

  List<Order> orderList = [];
  int page = 0;
  int size = 10;

  void getOrderList(String type) {
    if(type == "refresh") {
      page = 0;
    }
    HttpUtils.diorequst('/order/orderList', query: {
      "page": page + 1,
      "size": 10,
    }).then((res) {
      List<dynamic> data = res['data'] ?? [];
      final list = data.map((e) => Order.fromJson(e)).toList();
      if (type == "refresh") {
        orderList = list;
        refreshController.refreshCompleted();
        refreshController.resetNoData();
      } else if (type == "loadMore") {
        orderList.addAll(list);
        refreshController.loadComplete();
      }
      if (data.isEmpty) {
        refreshController.loadNoData();
      }
      page++;
      update();
    }).catchError((err) {
      if (type == "refresh") {
        refreshController.refreshFailed();
      } else if (type == "loadMore") {
        refreshController.loadFailed();
      }
      update();
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
