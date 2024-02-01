import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class RenewalAgreementPage extends StatelessWidget {
  const RenewalAgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return basePage("Membership Auto-Renewal Service Agreement",
        backGroundImage: null,
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.w)),
                padding: EdgeInsets.all(20.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      item("Membership Auto-Renewal Service Agreement", isBold: true),
                      item("This rule is considered a supplementary agreement to the \"Membership Service Agreement,\" an integral part of it, forming a unified whole. In case of any conflict between this rule and the \"Membership Service Agreement,\" this rule shall prevail."),
                      item("Never Alone Again membership includes: Never Alone Again Membership VIP, Never Alone Again Social Membership VIP1, and Never Alone Again Business Membership VIP2 (collectively referred to as \"Never Alone Again Membership\")."),
                      item("If you need to use the Never Alone Again Membership auto-renewal service, you must carefully read and agree to the following rules."),
                      item("You understand and agree:"),
                      item("1. Service Name: Never Alone Again Membership Subscription Service."),
                      item("2. This service is an auto-renewal service provided to you on the premise that you have activated Never Alone Again membership services. If you activate this service, it is deemed that you authorize Never Alone Again Membership to have the right to deduct the subscription fee for the next billing cycle from your iTunes account balance (hereinafter referred to as \"account\") when your Never Alone Again Membership is about to expire. The implementation of this service is based on the precondition that your Never Alone Again membership account is bound to the aforementioned account, and successful deductions can be made from the account. You shall bear the failure of renewal due to insufficient deductible balance in the aforementioned account.",isBold: true),
                      item("3. Subscription Period: 1 month."),
                      item("4. Accounts purchasing the continuous monthly membership will be automatically charged from the iTunes account 24 hours before the end of each billing cycle, extending the membership validity period for the same defined cycle."),
                      item("5. To cancel the subscription, manually open the \"Settings\" on your Apple phone --> Go to \"iTunes Store and App Store\" --> Click \"Apple ID,\" select \"View Apple ID,\" enter the \"Account Settings\" page, click \"Subscriptions,\" and choose Never Alone Again Membership to cancel the subscription. If the subscription is not closed at least 24 hours before the end of the subscription period, this subscription will be automatically renewed."),
                      item("6.If you have any questions about the content of this agreement, please provide feedback through the \"Help and Feedback\" in the Never Alone Again client, or contact us via email: sunsun@soulmate.health.",isBold: true),
                  ]
                ),
              ),
            )));
  }

  Widget item(String content, {bool isBold = false} ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.w),
      child: Text(
        content,
        style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
            fontFamily: "SFProRounded",
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal
        ),
      ),
    );
  }
}
