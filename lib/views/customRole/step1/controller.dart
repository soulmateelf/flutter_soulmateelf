import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:soulmate/models/product.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class Step1Controller extends GetxController {

  ///定制角色商品
  Product? customRoleProduct;

  @override
  void onReady() {
    super.onReady();
    getProductList();
  }
  // 获取商品列表
  getProductList() {
    HttpUtils.diorequst("/product/productList", query:{'page':1,'size':999,'productType':'2'}).then((response) {
      if (response['code'] == 200) {
        List dataMap = response["data"];
        List<Product> serverDataList = dataMap.map((json) => Product.fromJson(json)).toList();
        customRoleProduct = serverDataList.firstWhereOrNull((Product product) => product.type == 2);
        print(customRoleProduct);
        if(customRoleProduct == null){
          exSnackBar("No custom role product", type: ExSnackBarType.error);
        }
      }
    }).catchError((error) {
      exSnackBar(error, type: ExSnackBarType.error);
    });
  }

  ///定制角色的信息填写
  goCustomRole(){
    if(customRoleProduct == null){
      exSnackBar("No custom role product", type: ExSnackBarType.error);
      return;
    }
    Get.toNamed("/customRoleStep2", arguments: {'customRoleProduct': customRoleProduct});
  }

}