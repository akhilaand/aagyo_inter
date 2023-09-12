// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/order/views/tabbarscreen/accepted.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/order/views/tabbarscreen/delivered.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/order/views/tabbarscreen/ontheway.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/order/views/tabbarscreen/pending.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/order/views/tabbarscreen/pickedup.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/order/views/tabbarscreen/rejected.dart';
import '../../../../../colors/colors_const.dart';
import '../../../../../controller/list_order_controller.dart';
import '../../../../../styles/textstyle_const.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin{
  int myIndex=1;
  final getOrdersController = Get.put(ListOrderController());

  @override
  Widget build(BuildContext context) {
    TabController tabController=TabController(length: 6, vsync: this);
    return
      Material(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius:BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primary700)
                    ),
                    isScrollable: true,
                    unselectedLabelColor: Colors.red,

                    controller: tabController,
                    tabs: [
                      Tab(
                          child: Text(
                            "Pending (${getOrdersController.pendingOrderCount})",
                            style: AppTextStyles.kCaption12RegularTextStyle
                                .copyWith(color: AppColors.neutralLightFonts),
                          )),
                      Tab(
                          child: Text(
                            "Accepted (${getOrdersController.acceptedOrderCount}) ",
                            style: AppTextStyles.kCaption12RegularTextStyle
                                .copyWith(color: AppColors.neutralLightFonts),
                          )),
                      Tab(
                          child: Text(
                            "Picked Up (${getOrdersController.pickedUpOrderCount}) ",
                            style: AppTextStyles.kCaption12RegularTextStyle
                                .copyWith(color: AppColors.neutralLightFonts),
                          )),
                      Tab(
                          child: Text(
                            "On the way Up (${getOrdersController.onTheWayOrderCount}) ",
                            style: AppTextStyles.kCaption12RegularTextStyle
                                .copyWith(color: AppColors.neutralLightFonts),
                          )),
                      Tab(
                          child: Text(
                            "Delivered (${getOrdersController.deliveredOrderCount}) ",
                            style: AppTextStyles.kCaption12RegularTextStyle
                                .copyWith(color: AppColors.neutralLightFonts),
                          )),
                      Tab(
                          child: Text(
                            "Rejected (${getOrdersController.rejectedOrderCount}) ",
                            style: AppTextStyles.kCaption12RegularTextStyle
                                .copyWith(color: AppColors.neutralLightFonts),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                TabBarView(
                  controller: tabController,
                  children: [
                   PendingOrder(pendingOrderList:getOrdersController.pendingOrderList),
                   AcceptOrder(acceptedOrderList:getOrdersController.acceptedOrderList),
                   PickedUpOrder(pickedUpOrderList:getOrdersController.pickedUpOrderList),
                   OnthewayOrder( onTheWayOrderList: getOrdersController.onTheWayOrderList),
                   DeliveredOrder(deliveredOrderList: getOrdersController.deliveredOrderList),
                   RejectedOrder(rejectedOrderList: getOrdersController.rejectedOrderList),

                  ],
                ),
              ),

            ],
          ),
        ),
      );

  }
}
