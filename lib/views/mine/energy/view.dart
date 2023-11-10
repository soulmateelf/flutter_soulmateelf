import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
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

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  List<dynamic> starEnergyList = [
    {"energy": 20, "count": 2, "price": 2.99, "id": 1},
    {"energy": 50, "count": 2, "price": 6.99, "id": 1},
    {"energy": 100, "count": 2, "price": 16.99, "id": 1},
    {"energy": 150, "count": 2, "price": 26.99, "id": 1}
  ];

  @override
  Widget build(BuildContext context) {
    return basePage("Buy energy",
        backGroundImage:
            const AssetImage("assets/images/image/backgroundGray.png"),
        child: Column(
          children: [
            SizedBox(
              height: 9.w,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Container(
                  width: double.infinity,
                  child: GetBuilder<EnergyController>(
                    builder: (controller) {
                      return CupertinoSlidingSegmentedControl<EnergyTabKey>(
                        padding: EdgeInsets.all(4),
                        thumbColor: primaryColor,
                        backgroundColor: CupertinoColors.white,
                        groupValue: controller.tabKey,
                        onValueChanged: (EnergyTabKey? value) {
                          controller.tabKey = value!;
                          _tabController
                              ?.animateTo(value == EnergyTabKey?.vip ? 0 : 1);
                        },
                        children: {
                          EnergyTabKey.vip: Container(
                            height: 44.w,
                            alignment: Alignment.center,
                            child: Text(
                              energyTabMap[EnergyTabKey.vip]!,
                              style: controller.tabKey == EnergyTabKey.vip
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
                              style: controller.tabKey == EnergyTabKey.star
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
                      );
                    },
                  ),
                )),
            SizedBox(
              height: 24.w,
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Container(
                              height: 514.w,
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
                                    height: 272.w,
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
                                      TextSpan(
                                        text: "VIP",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 48.sp,
                                          fontFamily:
                                              FontFamily.SFProRoundedBlod,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      WidgetSpan(
                                          child: SizedBox(
                                        width: 20.w,
                                      )),
                                      TextSpan(
                                        text: "+500",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 48.sp,
                                          fontFamily:
                                              FontFamily.SFProRoundedBlod,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ])),
                                  ),
                                  SizedBox(
                                    height: 30.w,
                                  ),
                                  Text(
                                    "Get 500 star energy every month",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontFamily: FontFamily.SFProRoundedMedium,
                                      color:
                                          const Color.fromRGBO(0, 0, 0, 0.48),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
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
                              onPressed: () {},
                              child: const Text(
                                "\$ 56.99 / Month",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.SFProRoundedBlod,
                                  fontSize: 20,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Text(
                            "\$ 99.99 / Month",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: const Color.fromRGBO(0, 0, 0, 0.48),
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                              ),
                              child: GetBuilder<EnergyController>(
                                builder: (controller) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return cardItem(
                                          energy: starEnergyList[index]
                                              ["energy"],
                                          count: starEnergyList[index]["count"],
                                          price: starEnergyList[index]["price"],
                                          active: index ==
                                              controller.starEnergyCardIndex,
                                          onPressed: () {
                                            controller.starEnergyCardIndex =
                                                index;
                                          });
                                    },
                                    itemCount: starEnergyList.length,
                                  );
                                },
                              )),
                          SizedBox(
                            height: 16.w,
                          ),
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
                            height: 12.w,
                          ),
                          doubleCardList(),
                          SizedBox(height: 30.w,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            height: 64.w,
                            width: double.infinity,
                            child: MaterialButton(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(borderRadius)),
                              onPressed: () {},
                              child: const Text(
                                "Pay \$ 16.99",
                                style: TextStyle(
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
        ));
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
        height: 104.w,
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
                    "${energy}",
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    gradient: LinearGradient(
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
              ],
            )),
            SizedBox(
              width: 8.w,
            ),
            Text(
              "\$ ${price}",
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

    Widget item = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(width: 3.w, color: primaryColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
      margin: EdgeInsets.only(right: 4.w),
      child: Column(
        children: [
          Text(
            "x2",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.48),
              fontFamily: FontFamily.SFProRoundedBlod,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          Text(
            "Doubling of energy",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.48),
              fontSize: 13.sp,
            ),
          )
        ],
      ),
    );
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            item,item,item,item
          ],
        ),
      ),
    );
  }
}
