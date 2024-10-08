import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:soulmate/config.dart';
import 'package:soulmate/models/recharge.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/views/mine/energy/controller.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';

class EnergyPage extends StatefulWidget {
  EnergyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EnergyState();
  }
}

class EnergyState extends State<EnergyPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(EnergyController());

  @override
  void initState() {
    super.initState();
    logic.tabController = TabController(initialIndex: Utils.isEmpty(logic.couponId)?0:1,length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return basePage("Buy energy",
        backGroundImage: BackGroundImageType.gray,
        child: GetBuilder<EnergyController>(builder: (logic) { return Column(
          children: [
            SizedBox(
              height: 9.w,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Container(
                  width: double.infinity,
                  child: CupertinoSlidingSegmentedControl<EnergyTabKey>(
                    padding: EdgeInsets.all(4),
                    thumbColor: primaryColor,
                    backgroundColor: CupertinoColors.white,
                    groupValue: logic.tabKey,
                    onValueChanged: (EnergyTabKey? value) {
                      logic.tabKey = value!;
                      logic.tabController?.animateTo(value == EnergyTabKey?.vip ? 0 : 1);
                      logic.update();
                    },
                    children: {
                      EnergyTabKey.vip: Container(
                        height: 44.w,
                        alignment: Alignment.center,
                        child: Text(
                          energyTabMap[EnergyTabKey.vip]!,
                          style: logic.tabKey == EnergyTabKey.vip
                              ? TextStyle(
                            fontFamily: FontFamily.SFProRoundedBlod,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                            fontSize: 18.sp,
                          )
                              : TextStyle(
                            fontFamily: FontFamily.SFProRoundedMedium,
                            color:
                            const Color.fromRGBO(0, 0, 0, 0.48),
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      EnergyTabKey.star: Container(
                        height: 44.w,
                        alignment: Alignment.center,
                        child: Text(
                          energyTabMap[EnergyTabKey.star]!,
                          style: logic.tabKey == EnergyTabKey.star
                              ? TextStyle(
                            fontFamily: FontFamily.SFProRoundedBlod,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                            fontSize: 18.sp,
                          )
                              : TextStyle(
                            fontFamily: FontFamily.SFProRoundedMedium,
                            color:
                            const Color.fromRGBO(0, 0, 0, 0.48),
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    },
                  )
                )),
            SizedBox(
              height: 24.w,
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                    controller: logic.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Container(
                              height: 474.w,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(255, 161, 30, 1),
                                    CupertinoColors.white,
                                  ],
                                ),
                                border: Border.all(
                                  color: CupertinoColors.white,
                                  width: 6.w,
                                ),
                              ),
                              child: Column(
                                key: UniqueKey(),
                                children: [
                                  SizedBox(
                                    height: 50.w,
                                  ),
                                  Image.asset(
                                    "assets/images/image/energy.png",
                                    width: 272.w,
                                    height: 242.w,
                                  ),
                                  SizedBox(
                                    height: 36.w,
                                  ),
                                  ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromRGBO(255, 56, 48, 1),
                                            primaryColor
                                          ]).createShader(bounds);
                                    },
                                    child: RichText(
                                        text: TextSpan(children: [
                                      WidgetSpan(
                                          child: SizedBox(
                                        width: 20.w,
                                      )),
                                      TextSpan(
                                        text:"Get ${logic.monthProduct?.energy??'--'} star energy",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontFamily.SFProRounded,
                                          fontSize: 32.sp,
                                          color: const Color.fromRGBO(255, 56, 48, 1),
                                        ),
                                      )
                                    ])),
                                  ),
                                  Text(
                                    "every month",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.SFProRounded,
                                      fontSize: 32.sp,
                                      color: const Color.fromRGBO(255, 128, 0, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.w,
                                  ),
                                  RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:"Auto-renews for ",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: FontFamily.SFProRounded,
                                            color: const Color.fromRGBO(0, 0, 0, 0.48),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "\$${logic.monthProduct?.amount??'--'}/month ",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: FontFamily.SFProRounded,
                                            color: primaryColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " until canceled Subscribe",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: FontFamily.SFProRounded,
                                            color: const Color.fromRGBO(0, 0, 0, 0.48),
                                          ),
                                        )
                                      ])),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            height: 64.w,
                            width: double.infinity,
                            child: MaterialButton(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(borderRadius)),
                              onPressed: () {logic.payMonthly();},
                              child: Text(
                                "Subscribe",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.SFProRoundedBlod,
                                  fontSize: 20.sp,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: GestureDetector(
                            onTap: () {
                              logic.isAgree = !logic.isAgree;
                              logic.update();
                            },
                          child: Row(
                            children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  child: logic.isAgree ?
                                  Icon(CupertinoIcons.check_mark_circled_solid,color: primaryColor,size: 20.w)
                                          : Icon(CupertinoIcons.circle,color: primaryColor,size: 20.w),
                                ),
                              Expanded(child: RichText(
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(children: [
                                    TextSpan(
                                    text: "Clicking subscribe indicates that you agree to the  ",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(0, 0, 0, 0.8),
                                        fontSize: 15.sp,
                                        fontFamily: FontFamily.SFProRoundedMedium,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Service Agreement",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed("/webView", arguments: {
                                            "title": "Service Agreement",
                                            "url": "${ProjectConfig.getInstance()?.baseConfig['agreementBase']}/paymentAgreement.html"});
                                      },
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15.sp,
                                        fontFamily: FontFamily.SFProRoundedMedium,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: TextStyle(
                                        color: const Color.fromRGBO(0, 0, 0, 0.8),
                                        fontSize: 15.sp,
                                        fontFamily: FontFamily.SFProRoundedMedium,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Automatic Renewal Service Agreement.",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed("/webView", arguments: {
                                            "title": "Automatic Renewal Service Agreement",
                                            "url": "${ProjectConfig.getInstance()?.baseConfig['agreementBase']}/paymentAutoRenewAgreement.html"});
                                        },
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15.sp,
                                        fontFamily: FontFamily.SFProRoundedMedium,
                                      ),
                                    ),
                                  ],
                                  )))

                          ])
                          ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return cardItem(
                                      energy: logic.energyProductList[index].energy,
                                      count: logic.currentCard?.ratio ?? 1,
                                      price: logic.energyProductList[index].amount,
                                      active: logic.energyProductList[index].productId == logic.currentProduct?.productId,
                                      onPressed: () {
                                        logic.currentProduct = logic.energyProductList[index];
                                        logic.update();
                                      });
                                },
                                itemCount: logic.energyProductList.length,
                              )),
                          SizedBox(
                            height: 10.w,
                          ),
                          Offstage(
                            offstage: logic.cardList.isEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 28.w),
                                  child: Text(
                                    "Rechargeable card",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Color.fromRGBO(0, 0, 0, 0.48),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                doubleCardList(),
                              ],
                            )
                          ),
                          SizedBox(height: 15.w,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            height: 64.w,
                            width: double.infinity,
                            child: MaterialButton(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(borderRadius)),
                              onPressed: () {logic.payNow();},
                              child: Text(
                                "Pay \$${logic.currentProduct?.amount??'--'}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.SFProRoundedBlod,
                                  fontSize: 20,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            )
          ],
        );}));
  }

  Widget cardItem({
    required int energy,
    required int count,
    required double price,
    required bool active,
    required Function onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: AnimatedContainer(
        height: 90.w,
        padding: EdgeInsets.all(20.w),
        margin: EdgeInsets.only(bottom: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.w),
          color: CupertinoColors.white,
          border: active
              ? Border.all(
                  width: 3.w,
                  color: primaryColor,
                )
              : null,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: Row(
          children: [
            Image.asset(
              "assets/images/image/energyIcon.png",
              width: 64.w,
              height: 64.w,
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
                child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(255, 56, 48, 1),
                        primaryColor,
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                    "$energy",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.SFProRoundedBlod,
                      fontWeight: FontWeight.bold,
                      fontSize: 36.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Offstage(
                  offstage: logic.currentCard == null,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(255, 56, 48, 1),
                          primaryColor,
                        ],
                      ),
                      border: Border.all(
                        width: 2.w,
                        color: primaryColor,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "x",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontFamily.SFProRoundedBlod,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: "${count}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontFamily.SFProRoundedBlod,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(
              width: 8.w,
            ),
            Text(
              "\$ $price",
              style: TextStyle(
                color: textColor,
                fontFamily: FontFamily.SFProRoundedMedium,
                fontSize: 20.sp,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget doubleCardList() {
    Widget cardItem(RechargeableCard card) {
        return Container(
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(width: 3.w, color: logic.currentCard?.id == card.id ? primaryColor:const Color.fromRGBO(0, 0, 0, 0.06))
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
          margin: EdgeInsets.only(right: 4.w),
          child: Column(
            children: [
              Text(
                "x${card.ratio}",
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 0, 0.48),
                  fontFamily: FontFamily.SFProRoundedBlod,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                card.title.toString(),
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 0, 0.48),
                  fontSize: 13.sp,
                ),
              )
            ],
          ),
        );
      }
      return Container(
        height: 60.w,
        padding: EdgeInsets.only(left: 8.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {logic.currentCard= logic.cardList[index];logic.update();},
                child: cardItem(logic.cardList[index])
              );
            },
            itemCount: logic.cardList.length,
          ),
        ),
      );
    }
}
