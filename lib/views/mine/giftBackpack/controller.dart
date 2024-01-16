/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'package:get/get.dart';
import 'package:soulmate/models/energyCard.dart';
import 'package:soulmate/models/recharge.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

enum GiftTabKey {
  energy,
  rechargeable,
}

enum LoadDataType {
  refresh,
  loadMore,
}

class GiftBackpackController extends GetxController {
  GiftTabKey _tabKey = GiftTabKey.energy;

  GiftTabKey get tabKey => _tabKey;

  set tabKey(GiftTabKey value) {
    _tabKey = value;
    update();
  }

  RefreshController rechargeRefreshController = RefreshController();
  List<RechargeableCard> rechargeableCardList = [];
  int rechargePage = 0;

  RefreshController energyRefreshController = RefreshController();
  List<EnergyCard> energyCardList = [];
  int energyPage = 0;

  void getCardList(LoadDataType type) {
    if (type == LoadDataType.refresh) {
      rechargePage = 0;
    }
    HttpUtils.diorequst('/coupon/couponList',
        query: {"page": rechargePage+1, "size": 10}).then((res) {
      List<dynamic> data = res['data'] ?? [];
      final list = data.map((e) => RechargeableCard.fromJson(e)).toList();
      if (type == LoadDataType.refresh) {
        rechargeableCardList = list;
        rechargeRefreshController.refreshCompleted();
        rechargeRefreshController.resetNoData();
      } else if (type == LoadDataType.loadMore) {
        rechargeableCardList.addAll(list);
        rechargeRefreshController.loadComplete();
      }
      if (data.isEmpty) {
        rechargeRefreshController.loadNoData();
      }
      rechargePage++;
      update();
    }).catchError((err) {
      if (type == LoadDataType.refresh) {
        rechargeRefreshController.refreshFailed();
      } else if (type == LoadDataType.loadMore) {
        rechargeRefreshController.loadFailed();
      }
      update();
      exSnackBar(err, type: ExSnackBarType.error);
    });
  }

  void getEnergyHistoryList(LoadDataType type) {
    if (type == LoadDataType.refresh) {
      energyPage = 0;
    }
    HttpUtils.diorequst('/energy/energyHistoryList',
        query: {"page": energyPage+1, "size": 10}).then((res) {
      List<dynamic> data = res['data'] ?? [];
      final list = data.map((e) => EnergyCard.fromJson(e)).toList();
      if (type == LoadDataType.refresh) {
        energyCardList = list;
        energyRefreshController.refreshCompleted();
        energyRefreshController.resetNoData();
      } else if (type == LoadDataType.loadMore) {
        energyCardList.addAll(list);
        energyRefreshController.loadComplete();
      }
      if (data.isEmpty) {
        energyRefreshController.loadNoData();
      }
      energyPage++;
      update();
    }).catchError((err) {
      if (type == LoadDataType.refresh) {
        energyRefreshController.refreshFailed();
      } else if (type == LoadDataType.loadMore) {
        energyRefreshController.loadFailed();
      }
      update();
      exSnackBar(err.toString(), type: ExSnackBarType.error);
    });
  }

  @override
  void onInit() {
    super.onInit();
    return;
  }

  @override
  void onReady() {
    getCardList(LoadDataType.refresh);
    getEnergyHistoryList(LoadDataType.refresh);
    super.onReady();
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }
}
