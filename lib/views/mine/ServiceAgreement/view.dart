import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class ServiceAgreementPage extends StatelessWidget {
  const ServiceAgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return basePage("Service Agreement",
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
                  item("Service Agreement",isBold: true),
                  item("Important Notice:"),
                  item("Welcome to the Never Alone Again membership services. To protect your rights, please read this service agreement (hereinafter referred to as \"this Agreement\") in detail before using the membership services, especially the bolded parts. Minors should read this with their legal guardians."),
                  item("You have no right to use the membership services unless you have read and accepted all terms of this Agreement. Your purchase and/or use of the membership services is deemed as your acceptance of the terms of this Agreement."),
                  item("Article 1 Acceptance and Revision of the Service Agreement"),
                  item("1.1 All rules are an integral part of this Agreement and have the same legal effect as the main text of the Agreement. In case of any conflict between the main text of this Agreement and the aforementioned rules, the main text shall prevail. Unless explicitly stated otherwise, your use of membership services is subject to this Agreement."),
                  item("1.2 Should there be a need to revise this Agreement and related service terms due to business development, SOULMATE TECHNOLOGY PTE. LTD. will publish the changes on the Never Alone Again platform. You can visit to view the latest terms of the agreement. If you do not accept the modified terms after SOULMATE TECHNOLOGY PTE. LTD. makes changes, you may choose to terminate the use of the membership services. Your continued use of the services will be regarded as acceptance of the modified agreement."),
                  item("Article 2 Definitions"),
                  item("2.1 Member: Refers to the network value-added services provided to you by Never Alone Again. After becoming a member, you can enjoy certain privileges or participate in activities according to this Agreement. The specific services are subject to what Never Alone Again provides. The ownership and operation rights of membership, as well as the right to formulate membership systems and activities, belong to Never Alone Again. Never Alone Again has the right of interpretation within the scope prescribed by law."),
                  item("2.2 \"User\" or \"You\": Refers to an individual or a single entity that enjoys the membership services provided by Never Alone Again."),
                  item("Article 3 Procedures for Becoming a Member"),
                  item("3.1 If you wish to use the membership services, you must first log in to your Never Alone Again account or register and log in to a Never Alone Again account. Upon successful login, you can apply for the membership services. If you use a third-party account to log in to Never Alone Again, you should ensure the stability, authenticity, and availability of the third-party account. If you cannot log in to Never Alone Again due to reasons related to the third-party account (e.g., the third-party account is banned), you should contact the company that owns the third-party account. The Never Alone Again account you use to log in during the use of membership services is the only basis for SOULMATE TECHNOLOGY PTE. LTD. to confirm your identity."),
                  item("3.2 You can complete the payment and activate the membership services through the payment methods recognized by SOULMATE TECHNOLOGY PTE. LTD. on the service activation interface. When activating the services, you should carefully verify the account name, service type, and duration of the service you wish to activate. If due to personal reasons you have recharged the wrong account, activated the wrong service, or chosen the wrong duration, SOULMATE TECHNOLOGY PTE. LTD. will not refund the fees collected."),
                  item("3.3 After successfully becoming a member, users can enjoy multiple exclusive privileges and services, which are subject to what Never Alone Again actually provides. Membership is based on a monthly settlement method, with the settlement date being one calendar month from the date of membership activation. If you have not used the corresponding energy before the settlement date, it will continue to be used after the settlement date until it is depleted."),
                  item("3.4 Never Alone Again may adjust the content of membership privileges from time to time according to changes in business development. You should pay timely attention to and understand the changes in privilege content and policies, and understand and agree to Never Alone Again's adjustments. Before Never Alone Again adjusts the privileges, you may have already enjoyed or are enjoying certain service content or rights. You understand and accept that Never Alone Again's adjustment of the privileges may affect the rights you have enjoyed or are enjoying, and agree to use them according to the adjusted privilege content without requiring Never Alone Again to bear any responsibility."),
                  item("Article 4 Regulations on Membership Qualification"),
                  item("4.1 Membership services are for individual use only and cannot be transferred between different Never Alone Again accounts."),
                  item("4.2 If you voluntarily cancel or terminate your membership during the valid period of the activated membership, you will not receive a refund of the membership fee.",isBold: true),
                  item("4.3 After the cancellation/termination of membership, you can no longer participate in activities organized by Never Alone Again and cannot enjoy various privilege services and value-added services provided by Never Alone Again, that is, you will no longer enjoy membership services."),
                  item("Article 5 Membership Service Rules"),
                  item("5.1 You acknowledge: You are a natural person, legal person, or other organization with full civil rights and full civil conduct capabilities, and have the ability to independently bear responsibility for all your actions using membership services. If you do not have the aforementioned qualifications, when Never Alone Again demands you to assume responsibility according to the law or this Agreement, it has the right to seek compensation from your guardian or other responsible parties. If you are a natural person, you should provide Never Alone Again with your real name, address, email, contact number, etc.; if you are a legal person or other organization, you should provide the name, address, contact person, etc."),
                  item("5.2 You should properly save your account and password and be responsible for all activities and behaviors carried out with that account. You are prohibited from giving, lending, renting, transferring, or selling the account. You should independently be responsible for properly keeping, using, and maintaining the account, account information, and account password you have obtained from Never Alone Again. Never Alone Again is not liable for any responsibility related to the leakage of your account password due to non-Never Alone Again reasons or losses caused by your improper keeping, using, or maintaining."),
                  item("5.3 If you commit any of the following acts, Never Alone Again has full rights to terminate the provision of membership services without notifying you and has the right to restrict, freeze, or terminate the use of the Never Alone Again account associated with the service. Never Alone Again is not obliged to provide any compensation or refund, and you shall independently bear all responsibilities arising therefrom. If this causes losses to Never Alone Again or a third party, you should fully compensate for the losses:"),
                  item("(1) Obtaining membership services for profit-making purposes for oneself or others;"),
                  item("(2) Providing the membership account to a third party for use in any form such as renting, lending, or selling;"),
                  item("(3) Using any content obtained through membership services for purposes other than personal learning, research, or appreciation;"),
                  item("(4) Registering or using membership services with someone else's Never Alone Again account without authorization;"),
                  item("(5) Obtaining membership services with any robot software, spider software, crawler software, screen scraping software, or other non-regular methods;"),
                  item("(6) Obtaining membership services through improper means or actions that violate the principle of good faith."),
                  item("5.4 If any of the following situations occur, Never Alone Again has the right to interrupt or terminate the provision of one, multiple, or all services to you without notification, and you shall bear the resulting losses. Never Alone Again is not obliged to provide any compensation or refund. If this causes losses to Never Alone Again or a third party, you should fully compensate for the losses:"),
                  item("(1) The personal information you provide is not true or inconsistent with the registration information and you fail to provide reasonable proof;"),
                  item("(2) Your illegal or infringing behavior is confirmed by the effective legal documents of national administrative or judicial organs, or Never Alone Again, according to its judgment, believes that your behavior is suspected of violating the provisions of laws and regulations;"),
                  item("(3) Your behavior interferes with the normal operation of any part or function of Never Alone Again;"),
                  item("(4) You engage in behaviors not permitted by SOULMATE TECHNOLOGY PTE. LTD. through Never Alone Again without the permission of SOULMATE TECHNOLOGY PTE. LTD., including but not limited to commercial activities using information obtained through Never Alone Again, such as adding advertisements, commercial content, or links, etc."),
                  item("(5) Your personal information, published content, etc., violate national laws and regulations, contradict social morals and ethics, public order and good customs, infringe on the legal rights of others, have strong political color, cause any disputes, or violate this Agreement, the requirements publicized by the Never Alone Again platform;"),
                  item("(6) You use Never Alone Again for any illegal activities."),
                  item("Article 6 Privacy Policy"),
                  item("6.1 If you exercise the rights stipulated in this Agreement to purchase/accept goods or services provided by third-party merchants other than SOULMATE TECHNOLOGY PTE. LTD., and disputes arise from this, you should claim rights from the third-party merchant who sells/provides the goods or services. This has nothing to do with SOULMATE TECHNOLOGY PTE. LTD."),
                  item("6.2 You must bear all legal responsibilities for all actions you and the users you invite implement when participating in activities organized by Never Alone Again or using various discounts and value-added services provided by Never Alone Again."),
                  item("6.3 SOULMATE TECHNOLOGY PTE. LTD. is not liable for any losses caused to you by third-party actions or inactions, force majeure, including but not limited to payment service failures, network access service failures, communication line failures of telecommunications departments, communication technology problems, network, computer failures, system instability, any third-party infringement actions, etc."),
                  item("6.4 You understand and agree that during the process of using membership services, you may encounter force majeure and other risk factors that may cause interruption of the services. If the aforementioned situation occurs, SOULMATE TECHNOLOGY PTE. LTD. promises to cooperate with relevant units to repair as soon as possible, but does not bear any loss caused to you and does not refund the membership fees."),
                  item("Article 7 Other Agreements"),
                  item("7.1 Suspension, Interruption, and Termination of Services: SOULMATE TECHNOLOGY PTE. LTD., based on its business decisions, government actions, force majeure, etc., may choose to change, suspend, interrupt, and terminate membership services. If such situations occur, SOULMATE TECHNOLOGY PTE. LTD. will notify you but is not liable for any losses caused to you. Except as explicitly provided by laws and regulations, Never Alone Again has the right to refund the fees corresponding to the unfulfilled membership services directly to you without your application."),
                  item("7.2 All notifications sent to you by SOULMATE TECHNOLOGY PTE. LTD. can be done via in-site messages, webpage announcements, public account notifications, your reserved email, mobile text messages, and letters, etc. Such notifications are deemed to have been delivered to the user on the date of sending. Please pay close attention to notifications sent by SOULMATE TECHNOLOGY PTE. LTD."),
                  item("7.3 SOULMATE TECHNOLOGY PTE. LTD.'s failure to exercise, failure to exercise promptly, or failure to fully exercise the rights stipulated in this Agreement or according to the law, should not be regarded as a waiver of such rights, nor does it affect SOULMATE TECHNOLOGY PTE. LTD.'s exercise of those rights in the future."),
                  item("7.4 If you have any questions about the content of these terms, please contact us in the following ways:"),
                  item("Send an email to our customer service email: sunsun@soulmate.health."),
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
