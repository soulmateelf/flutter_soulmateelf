/// Author: kele
/// Date: 2022-03-07 13:31:49
/// LastEditors: kele
/// LastEditTime: 2022-03-09 18:46:02
/// Description:

part of projectLibrary;

Future<void> showLoadingMask({String message = '加载中……'}) {
  return EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      indicator: Container(
        margin: const EdgeInsets.all(0),
//        color:Colors.red,
        width: 110.w,
        child: Row(children: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(
              'assets/images/icons/refresh_icon.png',
              width: 20.w,
              height: 20.w,
            ),
          ),
          Expanded(
              child: Text(
            message,
            style: const TextStyle(color: Colors.black),
          )),
        ]),
      ));
}
