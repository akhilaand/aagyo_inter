// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/profile/view/profile.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/controller/list_order_controller.dart';
import 'package:aagyo/controller/overview_controller.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/accepted.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/delivered.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/ontheway.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/pending.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/pickedup.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/rejected.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/gridview.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/profile/widgets/ConstDropDown.dart';
import 'package:aagyo/services/core.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import 'package:share_plus/share_plus.dart';
final getOrdersController = Get.put(ListOrderController());

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> with TickerProviderStateMixin {
  final overViewController = Get.put(OverviewController());
  late TabController tabController;
  String userImage = "";
  bool status = false;
  int myIndex = 1;
  final double _tabHeight = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 6, vsync: this);

    callFutureFunctions();
    overViewController.getOverViewList();
    getOrdersController.getOrdersList();
    Timer.periodic(const Duration(seconds: 10),
        (Timer t) => getOrdersController.getOrdersList());
  }

  //TODO: CODE REVIEW
  callFutureFunctions() async {
    final image = await getUserImage();
    bool isStoreActive = await await isStoreOnline();
    setState(() {
      userImage = image;
      status = isStoreActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        // backgroundColor: Color(0xffDFDFDF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: SizedBox(
            height: 30,
            width: 80,
            // color: Colors.red,
            child: FlutterSwitch(
              activeText: "Online",
              inactiveText: "Offline",
              activeTextColor: Colors.black,
              inactiveTextColor: Colors.black,
              activeColor: Colors.green,
              toggleSize: 15,
              value: status,
              valueFontSize: 10,
              width: 60,
              height: 20,
              borderRadius: 30.0,
              showOnOff: true,
              onToggle: (val) async {
                 overViewController.updateStoreStatus(
                    currentStoreStatus: status);

                setState(() {
                  status = val;
                });
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none,
                        color: AppColors.neutralBodyFont,
                      )),
                  IconButton(
                      onPressed: () {
                        Share.share('Check out how Aagyo App',
                            subject: 'Link for Aaagyo App');
                      },
                      icon: const Icon(Icons.share,
                          color: AppColors.neutralBodyFont)),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Profile()));
                    },
                    child: Container(
                      child:  userImage == ""
                          ? const CircleAvatar(
                        child: Icon(Icons.person),
                      )
                          : CircleAvatar(
                        backgroundImage: NetworkImage(userImage),
                      ),
                    ),
                  )
                 
                ],
              ),
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverList(
                  delegate: SliverChildListDelegate([
                const Padding(
                  padding: EdgeInsets.only(left: 8, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Overview",
                          style: AppTextStyles.kBody17SemiboldTextStyle),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ConstDropDownProfile(),
                      )
                    ],
                  ),
                ),
                CustomGrid(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Overview",
                          style: AppTextStyles.kBody17SemiboldTextStyle),
                      Text("View All",
                          style: AppTextStyles.kCaption12RegularTextStyle
                              .copyWith(color: AppColors.primary700)),
                    ],
                  ),
                ),
              ])),
              Obx(() => SliverAppBar(
                    backgroundColor: Colors.white,
                    title: TabBar(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primary700)),
                      isScrollable: true,
                      unselectedLabelStyle:
                          AppTextStyles.kSmall10RegularTextStyle,
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
                    pinned: true,
                  ))
            ];
          },
          body: Obx(() {
            debugPrint(getOrdersController.pendingOrderList.toString());
            return TabBarView(
              controller: tabController,
              children: [
                Pending(pendingOrderList: getOrdersController.pendingOrderList),
                Accept(
                    acceptedOrderList: getOrdersController.acceptedOrderList,key: UniqueKey(),),
                PickedUp(
                    pickedUpOrderList: getOrdersController.pickedUpOrderList),
                Ontheway(
                    onTheWayOrderList: getOrdersController.onTheWayOrderList),
                Delivered(
                    deliveredOrderList: getOrdersController.deliveredOrderList),
                Rejected(
                    rejectedOrderList: getOrdersController.rejectedOrderList),
              ],
            );
          }),
        ));

  }
}

