/*
 * @Date: 2023-04-14 17:47:32
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-14 17:53:28
 * @FilePath: \soulmate\lib\views\main\deactivate\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class DeactivatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Deactivate vour account",
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                Text(
                    '''Are you sure you want to deactivate your account? Deactivating your account will result in you losing access to this application and all of its features.

Reason for deactivating your account: Please note that deactivating your account is an irreversible action, which means that you will permanently lose access to this application and all of its features. If you deactivate your account, you will no longer be able to log in or use any of the features of this application.

Timeframe for account deactivation: To permanently deactivate your account, your account will be deactivated immediately and your account data and history will be permanently deleted.

Reactivating your account: If you wish to use this application again after deactivating your account, you will need to create a new account. Please note that your history and data cannot be restored.

Handling of user data: If you wish to preserve your data before deactivating your account, you need to back up your data before deactivating your account. Once you deactivate your account, your data will be permanently deleted, and we will not be able to recover it.

Finally, please note that deactivating your account is an irreversible action. If you are sure you want to deactivate your account, please ensure that you have completed the following steps:

Back up your account data if necessary.
Withdraw any outstanding orders or unused services if necessary.
Cancel your subscriptions if necessary.
If you have completed these steps and are sure you want to deactivate your account, please enter your password below to confirm this action.'''),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/confirmDeactivate');
                    },
                    child: Text(
                      "Deactivate",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
          ),
        ));
  }
}
