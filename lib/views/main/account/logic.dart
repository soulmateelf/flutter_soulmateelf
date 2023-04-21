import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';

class AccountLogic extends GetxController {
  var userInfo11 = Application.userInfo;

  abc(){
    userInfo11 = Application.userInfo;
    update();
  }
}
