/*
 * @Date: 2023-04-16 13:25:21
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-20 19:04:20
 * @FilePath: \soulmate\lib\views\main\recharge\view.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/views/main/home/logic.dart';
import 'package:flutter_soulmateelf/views/main/recharge/logic.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';

class RechargePage extends StatelessWidget {
  final logic = Get.put(RechargetLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("", child: GetBuilder<RechargetLogic>(
      builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 138.w,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: renderRoleList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.w),
                child: Text(
                  "Shopping",
                  style: TextStyle(
                      fontSize: 48.sp,
                      color: Color.fromRGBO(102, 102, 102, 100)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.w),
                child: Wrap(
                  spacing: 20.w,
                  runSpacing: 10.w,
                  children: renderProducList(),
                ),
              ),

              // 优惠券砍掉了
              // Padding(
              //   padding: EdgeInsets.only(top: 60.w),
              //   child: Text(
              //     "Discount voucher",
              //     style: TextStyle(
              //         fontSize: 48.sp,
              //         color: Color.fromRGBO(102, 102, 102, 100)),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(top: 10.w),
              //   child: Column(
              //     children: [
              //       card(),
              //       card(),
              //       card(),
              //     ],
              //   ),
              // )
            ],
          ),
        );
      },
    ));
  }

  List<Widget> renderRoleList() {
    List<Widget> widgets = [];
    logic.roleList.forEach((role) {
      if (role["roleType"] != 3) {
        widgets.add(
          InkWell(
            onTap: () {
              logic.checkedRoleId = role["id"];
            },
            child: Container(
              width: 138.w,
              height: 138.w,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 4.w,
                      color: logic.checkedRoleId == role["id"]
                          ? Colors.green
                          : Colors.transparent)),
              child: Image.network(
                role["images"] ?? " ",
                errorBuilder: (context, error, stackTrace) {
                  return Text("");
                },
              ),
            ),
          ),
        );
      }
    });
    return widgets;
  }

  List<Widget> renderProducList() {
    List<Widget> widgets = [];
    logic.productList.forEach((product) {
      widgets.add(Container(
        width: 346.w,
        height: 346.w,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(235, 248, 242, 1),
              Color.fromRGBO(195, 236, 218, 1)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // card(),
            Container(
              width: 121.w,
              padding: EdgeInsets.symmetric(vertical: 8.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(21.w))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icons/flash.png',
                    width: 26.w,
                    height: 26.w,
                  ),
                  Text(
                    product?["amout"]?.toString() ?? " ",
                    style: TextStyle(fontSize: 26.sp),
                  ),
                ],
              ),
            ),
            Container(
              child: product?["productImage"] != null
                  ? Image.network(
                      product?["productImage"],
                      width: 160.w,
                      height: 160.w,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(" ");
                      },
                    )
                  : null,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 18.w),
              width: 290.w,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 8.w)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(51.w)))),
                  child: Column(
                    children: [
                      Text(
                        "\$ ${product?["price"]}",
                        style: TextStyle(color: Colors.black, fontSize: 36.sp),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ));
    });
    return widgets;
  }

  Widget card() {
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(235, 248, 242, 1),
                Color.fromRGBO(195, 236, 218, 1)
              ])),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.ticket_fill,
            color: Colors.orange,
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Text("\$ 2.00")),
          ),
          Radio(
              value: 1,
              toggleable: true,
              groupValue: 1,
              onChanged: (obj) {
                print(obj);
              })
        ],
      ),
    );
  }
}
