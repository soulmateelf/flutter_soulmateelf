part of projectLibrary;

SnackbarController exSnackBar(
  String message,

  /// 内容
  {
  String type = ExSnackBarType.success,

  /// 类型
}) {
  return Get.snackbar("", "",
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 12.w),
      maxWidth: 280.w,
      titleText: Container(
        constraints: const BoxConstraints.expand(height: 0),
      ),
      duration: const Duration(milliseconds: 1500),
      messageText: Container(
        margin: EdgeInsets.only(bottom: 6.w),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(
              type,
              width: 20.w,
              height: 20.w,
            ),
          ),
          Flexible(
              child: Text(message??"")),
        ]),
      ),
      backgroundColor: Colors.white);
}

class ExSnackBarType {
  static const String success = 'assets/images/icons/success.png';
  static const String warning = 'assets/images/icons/warning.png';
  static const String error = 'assets/images/icons/error.png';
}
