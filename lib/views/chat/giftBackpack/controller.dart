/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 19:51:12
 * @FilePath: \soulmate\lib\views\main\home\controller.dart
 */
import 'package:get/get.dart';
import 'package:soulmate/models/recharge.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';

import '../../../models/energyCard.dart';

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
  int rechargePage = 1;

  RefreshController energyRefreshController = RefreshController();
  List<EnergyCard> energyCardList = [];
  int energyPage = 1;

  void getCardList(LoadDataType type) {
    if (type == LoadDataType.refresh) {
      rechargePage = 1;
    } else if (type == LoadDataType.loadMore) {
      rechargePage++;
    }

    HttpUtils.diorequst('/coupon/couponList',
        query: {"page": rechargePage, "size": 10}).then((res) {
      List<dynamic> data = res['data'] ?? [];
      final list = data.map((e) => RechargeableCard.fromJson(e)).toList();
      if (type == LoadDataType.refresh) {
        rechargeableCardList = list;
        rechargeRefreshController.refreshCompleted();
      } else if (type == LoadDataType.loadMore) {
        rechargeableCardList.addAll(list);
        rechargeRefreshController.loadComplete();
      }
      update();
    });
  }

  void getEnergyHistoryList(LoadDataType type) {
    if (type == LoadDataType.refresh) {
      energyPage = 1;
    } else if (type == LoadDataType.loadMore) {
      energyPage++;
    }
    HttpUtils.diorequst('/energy/energyHistoryList',
        query: {"page": 1, "size": 10}).then((res) {
      List<dynamic> data = res['data'] ?? [];
      final list = data.map((e) => EnergyCard.fromJson(e)).toList();
      if (type == LoadDataType.refresh) {
        energyCardList = list;
        energyRefreshController.refreshCompleted();
      } else if (type == LoadDataType.loadMore) {
        energyCardList.addAll(list);
        energyRefreshController.loadComplete();
      }
    }).catchError((err) {});
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
