// import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/ontheway.dart';
// import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/pending.dart';
// import 'package:aagyo/styles/textstyle_const.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../colors/colors_const.dart';
// import '../view/tabbarView/accepted.dart';
// import '../view/tabbarView/delivered.dart';
// import '../view/tabbarView/pickedup.dart';
// import '../view/tabbarView/rejected.dart';
//
// class Tabbar extends StatefulWidget {
//   const Tabbar({Key? key}) : super(key: key);
//
//   @override
//   State<Tabbar> createState() => _TabbarState();
// }
//
// class _TabbarState extends State<Tabbar> with TickerProviderStateMixin{
//   int myIndex=1;
//
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController=TabController(length: 6, vsync: this);
//     return
//       Column(
//         children: [
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TabBar(
//                 indicator: BoxDecoration(
//                     borderRadius:BorderRadius.circular(8),
//                     border: Border.all(color: AppColors.primary700)
//                 ),
//                 isScrollable: true,
//                 unselectedLabelStyle: AppTextStyles.kSmall10RegularTextStyle,
//
//                 controller: tabController,
//                 tabs: [
//                   Tab(
//                       child:
//                       Text("Pending (0)",style:AppTextStyles.kCaption12RegularTextStyle
//                           .copyWith(color: AppColors.neutralLightFonts),)
//                   ),
//                   Tab(child:
//                   Text("Accepted (0) ",style: AppTextStyles.kCaption12RegularTextStyle
//                           .copyWith(color: AppColors.neutralLightFonts),)
//                   ),
//                   Tab(child:
//                   Text("Picked Up (0) ",style: AppTextStyles.kCaption12RegularTextStyle
//                           .copyWith(color: AppColors.neutralLightFonts),)
//                   ),
//                   Tab(child:
//                   Text("On the way Up (0) ",style: AppTextStyles.kCaption12RegularTextStyle
//                           .copyWith(color: AppColors.neutralLightFonts),)
//                   ),
//                   Tab(child:
//                   Text("Delivered (0) ",style: AppTextStyles.kCaption12RegularTextStyle
//                           .copyWith(color: AppColors.neutralLightFonts),)
//                   ),
//                   Tab(child:
//                   Text("Rejected (0) ",style: AppTextStyles.kCaption12RegularTextStyle
//                           .copyWith(color: AppColors.neutralLightFonts),)
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             child:
//             TabBarView(
//               controller: tabController,
//               children: [
//                 Pending(),
//                 Accept(),
//                 PickedUp(),
//                 Ontheway(),
//                 Delivered(),
//                 Rejected(),
//
//               ],
//             ),
//           ),
//
//         ],
//       );
//
//   }
// }