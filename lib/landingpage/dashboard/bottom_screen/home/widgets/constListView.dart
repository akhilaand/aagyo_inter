
// import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/pending.dart';
// import 'package:aagyo/styles/textstyle_const.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../colors/colors_const.dart';
// import '../../../../../const/constString.dart';
//
// class ConstListV extends StatefulWidget {
//   const ConstListV({Key? key}) : super(key: key);
//
//   @override
//   State<ConstListV> createState() => _ConstListVState();
// }
//
// class _ConstListVState extends State<ConstListV> {
//     bool _pressed = false;
//   final List page =[
//     Pending(),
//     Text("ss"),
//     Pending(),
//   ];
//   final List<String> listname =[
//     "Pending(0)",
//     "Accepted(0)",
//     "Picked Up(0)",
//     "On the way(0)",
//     "Delivered(0)",
//     "Rejected(0)",
//
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height*0.08,
//           // width: MediaQuery.of(context).size.width*0.19,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//               // shrinkWrap: true,
//               itemCount: page.length,
//               itemBuilder: (context,index){
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: ()=>{
//                     this.setState(() {
//                       _pressed =true;
//                     }),
//                     page[index]
//                   },
//                   child: Container(
//                     width: MediaQuery.of(context).size.width*0.22,
//                       decoration: BoxDecoration(
//                         borderRadius:BorderRadius.circular(8),
//                         border: Border.all(
//
//                             color: _pressed?AppColors.primary700:AppColors.neutralBorder,width: 1)
//                       ),
//                     child: Center(child: Text(
//                       listname[index],style: AppTextStyles.kCaption12RegularTextStyle,)
//                     ),
//                   ),
//                 ),
//
//               );
//
//           }),
//         ),
//         Container(
//           height:MediaQuery.of(context).size.height*.4,
//           width:MediaQuery.of(context).size.width,
//
//           // color: Colors.red,
//         child:page[0] ,
//         )
//       ],
//     );
//   }
// }
//
//
//
