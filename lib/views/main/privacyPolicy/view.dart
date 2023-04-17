/*
 * @Date: 2023-04-16 11:01:36
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-16 11:07:51
 * @FilePath: \soulmate\lib\views\main\privacyPolicy\view.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("Privacy Policy",
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(24.w),
          child: const Text(text),
        )));
  }

  static const text = '''To ensure transparency, we have created a comprehensive privacy policy that outlines the types of personal information we collect, how we use and share this information, and the steps we take to safeguard it.

We collect personal information, such as name, email address, and phone number, only with the user's consent and for specific purposes, such as improving the user experience or providing customer support. We do not share this information with any third-party without the user's explicit consent.

We also collect non-personal information, such as device type and usage data, to improve the performance of our app and understand how users interact with it. This information is aggregated and does not identify individual users.

We take reasonable measures to protect the security and confidentiality of our users' personal information, including implementing physical, technical, and administrative safeguards. We also regularly review and update our privacy policy to ensure that it remains up-to-date with changes in technology and legal requirements.

If you have any questions or concerns about our privacy policy or the handling of your personal information, please contact us at [邮箱下来写邮箱].
We also use cookies and similar technologies to enhance the user experience and personalize the content that we show to our users. These cookies may collect non-personal information such as browser type, language preference, and operating system, and do not collect any personally identifiable information. Users have the option to disable cookies in their browser settings, although this may limit the functionality of our app.

In compliance with applicable laws and regulations, we will notify users in the event of a data breach that affects their personal information. We will also work diligently to investigate and remediate any such incidents.

We may update our privacy policy from time to time, and we will notify our users of any material changes. Users are encouraged to review our privacy policy periodically to stay informed about our practices.

By using our app, users acknowledge that they have read and agree to the terms of our privacy policy. If a user does not agree with any aspect of our privacy policy, they should refrain from using our app.

We are committed to protecting the privacy of our users and maintaining their trust in our app. If you have any further questions or concerns about our privacy policy or the handling of your personal information, please do not hesitate to contact us.
Finally, we want to assure our users that we do not sell, rent, or lease their personal information to any third-party for any reason, including advertising or marketing purposes. We only share personal information with third-parties in limited circumstances, such as when we are required to do so by law, or when we have a legitimate business need to do so.

If we do share personal information with a third-party, we will ensure that they are bound by strict confidentiality and data protection requirements, and that they only use the information for the specific purposes for which it was shared.

In conclusion, our privacy policy reflects our commitment to protecting the personal information of our users, and to being transparent about how we collect, use, and share this information. We believe that by being upfront about our practices, we can build trust with our users and provide them with a better experience using our app.

Thank you for taking the time to read our privacy policy. If you have any feedback or suggestions on how we can improve it, please do not hesitate to contact us.''';
}
