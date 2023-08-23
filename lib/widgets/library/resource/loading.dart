part of projectLibrary;

class Loading {
  /// 返回dismiss方法来关闭这个弹窗
  static show(
      {bool showMask = true,
      String status = "loading...",
      Widget? indicator,
      bool dismissOnTap = false,
      EasyLoadingMaskType maskType = EasyLoadingMaskType.black}) {
    EasyLoading.show(
        maskType: (showMask ? maskType : EasyLoadingMaskType.none),
        status: status,
        indicator: indicator,
        dismissOnTap: dismissOnTap);
  }

  /// 关闭这个弹窗
  static dismiss({bool animation = true}) {
    return EasyLoading.dismiss(animation: animation);
  }

  /// 成功弹窗
  static success(
    String status, {
    Duration? duration,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    bool showMask = false,
    bool? dismissOnTap,
  }) {
    EasyLoading.showSuccess(status,
        duration: duration,
        maskType: (showMask ? maskType : EasyLoadingMaskType.none),
        dismissOnTap: dismissOnTap);
  }

  /// 文本弹窗
  static toast(
    String status, {
    Duration? duration,
    EasyLoadingToastPosition? toastPosition,
    bool showMask = false,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    bool? dismissOnTap,
  }) {
    EasyLoading.showToast(
      status,
      duration: duration,
      maskType: (showMask ? maskType : EasyLoadingMaskType.none),
      toastPosition: toastPosition,
      dismissOnTap: dismissOnTap,
    );
  }

  /// 错误弹窗
  static error(
    String status, {
    Duration? duration,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    bool showMask = false,
    bool? dismissOnTap,
  }) {
    EasyLoading.showError(status,
        duration: duration,
        maskType: (showMask ? maskType : EasyLoadingMaskType.none),
        dismissOnTap: dismissOnTap);
  }

  /// 信息弹窗
  static info(
    String status, {
    Duration? duration,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    bool showMask = false,
    bool? dismissOnTap,
  }) {
    EasyLoading.showInfo(status,
        duration: duration,
        maskType: (showMask ? maskType : EasyLoadingMaskType.none),
        dismissOnTap: dismissOnTap);
  }

  /// 进度条弹窗 show progress with [value] [status] [maskType], value should be 0.0 ~ 1.0.
  static progress(
    double value, {
    String? status,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
    bool showMask = false,
  }) {
    EasyLoading.showProgress(
      value,
      status: status,
      maskType: (showMask ? maskType : EasyLoadingMaskType.none),
    );
  }
}
