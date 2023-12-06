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

import '../../../models/energyCard.dart';

enum GiftTabKey {
  energy,
  rechargeable,
}

class GiftBackpackController extends GetxController {
  GiftTabKey _tabKey = GiftTabKey.energy;

  GiftTabKey get tabKey => _tabKey;

  set tabKey(GiftTabKey value) {
    _tabKey = value;
    update();
  }

  List<RechargeableCard> rechargeableCardList = [];
  List<EnergyCard> energyCardList = [];

  void getCardList() {
    HttpUtils.diorequst('/coupon/couponList', query: {"page": 1, "size": 10})
        .then((res) {
      APPPlugin.logger.d(res);
      List<dynamic> data = res['data'] ?? [];
      rechargeableCardList =
          data.map((e) => RechargeableCard.fromJson(e)).toList();
      update();
    });
  }

  void getEnergyHistoryList() {
    HttpUtils.diorequst('/energy/energyHistoryList',
        query: {"page": 1, "size": 10}).then((res) {
      APPPlugin.logger.d(res);
      List<dynamic> data = res['data'] ?? [];
      energyCardList = data.map((e) => EnergyCard.fromJson(e)).toList();
    }).catchError((err) {});
  }

  @override
  void onInit() {
    super.onInit();
    return;
  }

  @override
  void onReady() {
    getCardList();
    getEnergyHistoryList();
    super.onReady();
    return;
  }

  @override
  void onClose() {
    super.onClose();
    return;
  }
}
