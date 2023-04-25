/*
 * @Date: 2023-04-10 18:59:42
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-25 18:59:48
 * @FilePath: \soulmate\lib\views\base\verification\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/plugin/plugin.dart';

class VerificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerificationPage();
  }
}

class _VerificationPage extends State<VerificationPage> {
  bool _error = false;
  FocusNode focus = FocusNode();

  _sendCode() {
    final type = Get.arguments["type"];
    final email = Get.arguments["email"];
    if (type == null || email == null) {
      return;
    }
    Loading.show(status: "Sending");
    NetUtils.diorequst("/base/email", 'post', params: {
      "email": email,
      "type": type,
    }).then((value) {
      focus.requestFocus();
    }, onError: (err) {
      Loading.dismiss();
    }).whenComplete(() => Loading.success("send success"));
  }

  @override
  void initState() {
    // TODO: implement initState
    _sendCode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Loading.dismiss();
  }

  void _validate(String value) async {
    final type = Get.arguments["type"];
    final email = Get.arguments["email"];
    if (type == null || email == null) {
      return;
    }
    Loading.show();
    final result = await NetUtils.diorequst("/base/verify", 'post', params: {
      "code": value,
      "email": "${type}_${email}",
    });
    Loading.dismiss();
    if (result?.data?["code"] == 200) {
      final arguments = Get.arguments;
      arguments["code"] = value;
      Get.toNamed('/setPassword', arguments: arguments);
    } else {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil初始化
    ScreenUtil.init(Get.context!, designSize: const Size(750, 1624));
    return Scaffold(
      appBar: backBar(),
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "Create your account",
              style: TextStyle(
                fontSize: 48.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.w),
            child: Text(
              "Enter it below to verify your account.",
              style: TextStyle(
                fontSize: 22.sp,
                color: Color.fromRGBO(102, 102, 102, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.w),
            child: PinCodeTextField(
                focusNode: focus,
                appContext: context,
                keyboardType: TextInputType.number,
                length: 6,
                pinTheme: PinTheme(
                  inactiveColor: Color.fromRGBO(230, 230, 230, 1),
                ),
                onCompleted: (value) {
                  _validate(value);
                },
                onChanged: (value) {
                  setState(() {
                    _error = false;
                  });
                }),
          ),
          if (_error)
            Text(
              "The code you entered is incorrect.Please try again.",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22.sp,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 40.w),
            child: TextButton(
              onPressed: () {
                _sendCode();
              },
              child: Text(
                'Resend code.',
                style: TextStyle(color: Color.fromRGBO(78, 162, 79, 1)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
