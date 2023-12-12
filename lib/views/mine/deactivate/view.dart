import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/views/mine/deactivate/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class MineDeactivatePage extends StatelessWidget {
  MineDeactivatePage({super.key});

  final logic = Get.put(MineDeactivateController());

  @override
  Widget build(BuildContext context) {
    return basePage("Deactivate vour account",
        backGroundImage: null,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    borderRadius,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    """Are you sure you want to deactivate your account? Deactivating your account will result in you losing access to this application and all of its features.

Reason for deactivating your account: Please note that deactivating your account is an irreversible action, which means that you will permanently lose access to this application and all of its features. If you deactivate your account, you will no longer be able to log in or use any of the features of this application.

Timeframe for account deactivation: To permanently deactivate your account, your account will be deactivated immediately and your account data and history will be permanently deleted.

Reactivating your account: If you wish to use this application again after deactivating your account, you will need to create a new account. Please note that your history and data cannot be restored.

Handling of user data: If you wish to preserve your data before deactivating your account, you need to back up your data before deactivating your account. Once you deactivate your account, your data will be permanently deleted, and we will not be able to recover it.

Finally, please note that deactivating your account is an irreversible action. If you are sure you want to deactivate your account, please ensure that you have completed the following steps:

Back up your account data if necessary.
Withdraw any outstanding orders or unused services if necessary.
Cancel your subscriptions if necessary.
If you have completed these steps and are sure you want to deactivate your account, please enter your password below to confirm this action.""",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: textColor,
                    ),
                  ),
                ),
              )),
              SizedBox(
                height: 12.w,
              ),
              Container(
                width: double.infinity,
                height: 64.w,
                child: MaterialButton(
                  onPressed: () {
                    Get.toNamed('/mineConfirmDeactivate');
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Text(
                    "Deactivate",
                    style: TextStyle(
                      color: errorTextColor,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
