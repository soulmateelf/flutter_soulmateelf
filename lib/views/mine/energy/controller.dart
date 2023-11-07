import 'package:get/get.dart';

enum EnergyTabKey {
  vip,
  star,
}

Map<EnergyTabKey, String> energyTabMap = {
  EnergyTabKey.vip: "VIP package",
  EnergyTabKey.star: "Star energy",
};

class EnergyController extends GetxController {
  EnergyTabKey _tabKey = EnergyTabKey.vip;

  EnergyTabKey get tabKey => _tabKey;

  set tabKey(EnergyTabKey value) {
    _tabKey = value;
    update();
  }

  int _starEnergyCardIndex = 0;

  int get starEnergyCardIndex => _starEnergyCardIndex;

  set starEnergyCardIndex(int value) {
    _starEnergyCardIndex = value;
    update();
  }
}
