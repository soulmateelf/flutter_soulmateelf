/*
 * @Date: 2023-04-10 09:35:33
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-17 17:17:50
 * @FilePath: \soulmate\lib\widgets\library\resource\exSnackBar.dart
 */
part of projectLibrary;

SnackbarController exSnackBar(
  String message,

  /// 内容
  {
  String type = 'success',

  /// 类型
}) {
  String url = 'assets/images/icons/success.png';
  switch (type) {
    case 'success':
      url = 'assets/images/icons/success.png';
      break;
    case 'warning':
      url = 'assets/images/icons/warning.png';
      break;
    case 'error':
      url = 'assets/images/icons/error.png';
      break;
    default:
      url = 'assets/images/icons/success.png';
      break;
  }
  return Get.snackbar("", "",
      padding: EdgeInsets.only(left: 12.w, top: 8.w, bottom: 12.w),
      maxWidth: 280.w,
      titleText: Container(
        constraints: const BoxConstraints.expand(height: 0),
      ),
      duration: const Duration(milliseconds: 2000),
      messageText: Row(children: [
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Image.asset(
            url,
            width: 20.w,
            height: 20.w,
          ),
        ),
        Expanded(child: Text(message)),
      ]),
      backgroundColor: Colors.white);
}
