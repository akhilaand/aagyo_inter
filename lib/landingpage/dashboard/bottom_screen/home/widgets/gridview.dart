// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/widgets/tabbar.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/order/widgets/consttabbar.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../controller/overview_controller.dart';

class CustomGrid extends StatelessWidget {
  CustomGrid({Key? key}) : super(key: key);
  final overViewController=Get.put(OverviewController());

  @override
  Widget build(BuildContext context) {

    List <String> img = [
      totalSales,
      totalProducts,
      orders,
      allCustomers,
    ];
    List <String> name = [
      "Orders",
      "Total Sales",
      "All Customers",
      "Total Products",
    ];
    final Screen = [
      const OrderScreen(),
      const OrderScreen(),
      const Text("s"),
      const MenuTabbar(),
    ];

    return Obx((){
      final overViewList = overViewController.overViewList;
      return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 4,
        childAspectRatio: 1.35,
        shrinkWrap: true,
        children: List.generate(overViewList.length, (index) {
          final overViewItem = overViewList[index].keys.toList();
          final overViewItemCount = overViewList[index].values.toList();


          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen[index]));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.neutralBorder)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(img[index],),
                      Text(overViewItemCount[0].toString(),style:AppTextStyles.kHeading3TextStyle),
                      Text(overViewItem[0],style:AppTextStyles.kBody15RegularTextStyle)
                    ],
                  ),
                ),
              ),
            ),
          );
        },),
      );
    });





  }
  }

