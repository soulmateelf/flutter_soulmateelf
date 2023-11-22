import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter/src/material/slider_theme.dart';

class Step2Controller extends GetxController {
  RangeValues _genderRange = RangeValues(16, 56);

  RangeValues get genderRange => _genderRange;

  set genderRange(RangeValues value) {
    _genderRange = value;
    update();
  }
}
