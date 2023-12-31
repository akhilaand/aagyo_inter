


// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/profile/view/recentactivity.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/profile/view/viewall.dart';
import 'package:aagyo/styles/textstyle_const.dart';

class WalletPageScreen extends StatefulWidget {
  const WalletPageScreen({super.key});

  @override
  State<WalletPageScreen> createState() => _WalletPageScreenState();
}

class _WalletPageScreenState extends State<WalletPageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary700,
        leading: IconButton(
          onPressed: () {
            // Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Payout',
          style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(
            color: AppColors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.help_outline,
                color: AppColors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const Divider(
                  color: Colors.white,
                  height: 1,
                ),
                Container(
                  height: size.height * 0.22,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: AppColors.primary700,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Balance',
                          style: AppTextStyles.kBody15RegularTextStyle
                              .copyWith(color: AppColors.white),
                        ),
                        Text(
                          '₹500',
                          style: AppTextStyles.kLargeTitleTextStyle
                              .copyWith(color: AppColors.white),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.16,
                ),
                // GestureDetector(
                //   onTap: () {
                //     // Get.bottomSheet(
                //     //   SingleChildScrollView(
                //     //     // scrollDirection: Axis.vertical,
                //     //     physics: const NeverScrollableScrollPhysics(),
                //     //     child: Column(
                //     //       children: [
                //     //         InkWell(
                //     //           // onTap: ()=>Get.back(),
                //     //           child: Container(
                //     //             height: 40,
                //     //             width: 40,
                //     //             decoration: BoxDecoration(
                //     //                 color: Colors.black38,
                //     //               borderRadius: BorderRadius.circular(20)
                //     //             ),
                //     //             child: const Icon(Icons.close_rounded,color: Colors.white,),
                //     //           ),
                //     //         ),
                //     //         const SizedBox(
                //     //           height: 10,
                //     //         ),
                //     //         Container(
                //     //           height: size.height*0.35,
                //     //           width: size.width,
                //     //           decoration: const BoxDecoration(
                //     //               color: AppColors.white,
                //     //               borderRadius: BorderRadius.only(
                //     //                 topRight: Radius.circular(20),
                //     //                 topLeft: Radius.circular(20),
                //     //               )),
                //     //           child: Padding(
                //     //             padding:
                //     //                 const EdgeInsets.symmetric(horizontal: 20),
                //     //             child: Column(
                //     //               children: [
                //     //                 const SizedBox(
                //     //                   height: 30,
                //     //                 ),
                //     //                 const Text(
                //     //                   'Redeem Gift/Coupon',
                //     //                   style: AppTextStyles
                //     //                       .kBody17SemiboldTextStyle,
                //     //                 ),
                //     //                 const SizedBox(
                //     //                   height: 10,
                //     //                 ),
                //     //                 SizedBox(
                //     //                   width: size.width * 0.6,
                //     //                   child: const Text(
                //     //                     textAlign: TextAlign.center,
                //     //                     'Enter the voucher code and redeem it to get the discount',
                //     //                     style: AppTextStyles
                //     //                         .kCaption12RegularTextStyle,
                //     //                   ),
                //     //                 ),
                //     //                 const SizedBox(
                //     //                   height: 30,
                //     //                 ),
                //     //                 SizedBox(
                //     //                   height: 45,
                //     //                   child: TextFormField(
                //     //                     decoration: InputDecoration(
                //     //                       contentPadding:
                //     //                           const EdgeInsets.symmetric(
                //     //                               horizontal: 15, vertical: 5),
                //     //                       hintText: 'Enter code here',
                //     //                       border: OutlineInputBorder(
                //     //                         borderRadius:
                //     //                             BorderRadius.circular(10),
                //     //                         borderSide: const BorderSide(
                //     //                             color: AppColors.white20),
                //     //                       ),
                //     //                     ),
                //     //                   ),
                //     //                 ),
                //     //                 const SizedBox(
                //     //                   height: 20,
                //     //                 ),
                //     //                 SizedBox(
                //     //                   height: 40,
                //     //                   child: ElevatedButton(
                //     //                       style: ElevatedButton.styleFrom(
                //     //                         backgroundColor:
                //     //                             AppColors.primary700,
                //     //                       ),
                //     //                       onPressed: () {},
                //     //                       child: Center(
                //     //                         child: Text(
                //     //                           'Redeem',
                //     //                           style: AppTextStyles
                //     //                               .kBody15SemiboldTextStyle
                //     //                               .copyWith(
                //     //                                   color: AppColors.white),
                //     //                         ),
                //     //                       )),
                //     //                 )
                //     //               ],
                //     //             ),
                //     //           ),
                //     //         ),
                //     //       ],
                //     //     ),
                //     //   ),
                //     // );
                //   },
                //   child: Container(
                //     height: 50,
                //     width: 328,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(4),
                //         border: Border.all(
                //           color: AppColors.white30,
                //         ),
                //         color: Colors.white),
                //     child: Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: Row(
                //         children: [
                //           // Image.asset('assets/icons/percentage.png'),
                //           const SizedBox(
                //             width: 10,
                //           ),
                //           const Text(
                //             'Redeem Gift/Coupon Code',
                //             style: AppTextStyles.kCaption12RegularTextStyle,
                //           ),
                //           const SizedBox(
                //             width: 80,
                //           ),
                //           const Icon(Icons.arrow_forward_ios)
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Activity',
                        style: AppTextStyles.kBody17SemiboldTextStyle,
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewAll()));
                        },
                        child: Text(
                          'view all',
                          style: AppTextStyles.kCaption12RegularTextStyle
                              .copyWith(color: AppColors.primary700),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext contex,index){
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.asset(success),
                          title: const Text(
                            'Cash Deposit Success',
                            style: AppTextStyles.kCaption12RegularTextStyle,
                          ),
                          subtitle: const Row(
                            children: [
                              Text('25/01/23'),
                              SizedBox(
                                width: 10,
                              ),
                              Text('09:30pm')
                            ],
                          ),
                          trailing: const Text(
                            '₹500',
                            style: AppTextStyles.kBody15SemiboldTextStyle,
                          ),
                        ),const Divider(
                          color: AppColors.white40,
                        ),
                        ListTile(
                          leading: Image.asset(desposit),
                          title: const Text(
                            'Cash Deposit failed !',
                            style: AppTextStyles.kCaption12RegularTextStyle,
                          ),
                          subtitle: const Row(
                            children: [
                              Text('25/01/23'),
                              SizedBox(
                                width: 10,
                              ),
                              Text('09:30pm')
                            ],
                          ),
                          trailing: const Text(
                            '₹500',
                            style: AppTextStyles.kBody15SemiboldTextStyle,
                          ),
                        ),
                        // const Divider(
                        //         color: AppColors.white40,
                        //       ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            Positioned(
              top: size.height * 0.11,
              left: size.width * 0.05,
              child: const TopUp(),
            )
          ],
        ),
      ),
    );
  }
}
