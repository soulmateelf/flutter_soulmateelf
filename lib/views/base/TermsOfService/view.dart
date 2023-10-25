import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return basePage("Terms of Service",
        backGroundImage: null,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.w)),
              padding: EdgeInsets.all(20.w),
              child: Text(
                """Acceptance of Terms
By using our app, you agree to these terms of service. If you do not agree to these terms, please do not use our app.

Privacy Policy
We take your privacy seriously. Our privacy policy outlines how we collect, use, and protect your personal information. By using our app, you agree to our privacy policy.

License to Use
We grant you a limited, non-exclusive, non-transferable, revocable license to use our app for personal, non-commercial purposes only. You may not modify, copy, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any information, software, products or services obtained from our app.

Prohibited Uses
You agree not to use our app for any unlawful or prohibited purpose, including but not limited to:

·Violating any applicable laws or regulations
·Posting or transmitting any material that is harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, or otherwise objectionable
·Impersonating any person or entity
·Posting or transmitting any unsolicited advertising, promotional materials, or any other forms of solicitation
·Interfering with the operation of our app or any server, network or system associated with our app
·Using any robot, spider, scraper, or other automated means to access our app.

User Content
You are solely responsible for any content you post or transmit through our app. You agree that we are not responsible for any user content and that you will not hold us liable for any user content that violates these terms of service.

Termination
We reserve the right to terminate your access to our app at any time, without notice, for any reason. Upon termination, you must immediately cease using our app.

Indemnification
You agree to indemnify and hold us harmless from any claim or demand, including reasonable attorneys' fees, made by any third party due to or arising out of your use of our app, your violation of these terms of service, or your violation of any rights of another.

Disclaimer of Warranties
Our app is provided "as is" and without warranties of any kind, either express or implied. We do not warrant that our app will be uninterrupted or error-free, nor do we make any warranty as to the results that may be obtained from the use of our app.

Limitation of Liability
In no event shall we be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with your use of our app.

Governing Law
These terms of service shall be governed by and construed in accordance with the laws of the state/country where our company is headquartered.

Modifications
We reserve the right to modify or update these terms of service at any time, without notice. Any changes to the terms of service will be posted on our app and will become effective immediately upon posting. Your continued use of our app following any changes to the terms of service constitutes your acceptance of the revised terms.

Intellectual Property
All content, trademarks, service marks, logos, and intellectual property on our app are the property of our company or its licensors. You may not use or display any of these without our prior written consent.

Third-Party Links
Our app may contain links to third-party websites or services. We do not endorse and are not responsible for any content, products, services, or practices of any third-party websites or services.

Dispute Resolution
Any dispute arising out of or relating to these terms of service or your use of our app shall be resolved through binding arbitration in accordance with the rules of the American Arbitration Association. The arbitration shall be held in the state/country where our company is headquartered.

Entire Agreement
These terms of service constitute the entire agreement between you and our company and supersede any prior agreements, oral or written, between you and our company.

Thank you for taking the time to review our terms of service. We hope that our app provides you with a valuable and enjoyable experience.

By using our app, you acknowledge that you have read, understood, and agree to these terms of service. If you have any questions or concerns, please contact us at [
      """,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: FontFamily.SFProRoundedLight
                ),
              ),
            ),
          ),
        ));
  }
}
