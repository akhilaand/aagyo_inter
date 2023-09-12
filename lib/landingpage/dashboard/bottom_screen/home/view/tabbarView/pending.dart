// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/constantOrderid.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../../controller/list_order_controller.dart';
import '../../../../../../controller/overview_controller.dart';

class Pending extends StatefulWidget {
  final List pendingOrderList;
  final ScrollPhysics? physics;
  const Pending({Key? key, this.physics, required this.pendingOrderList})
      : super(key: key);
  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final overviewController = Get.put(OverviewController());
  final getOrdersController = Get.put(ListOrderController());
  int _counter = 20;
  void increment() {
    if (_counter <= 60) {
      setState(() {
        _counter = _counter + 5;
      });
    }
  }

  void decrement() {
    setState(() {
      if (_counter != 0) {
        _counter = _counter - 5;
      }
    });
  }

  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pendingOrderList.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.pendingOrderList.length,
          shrinkWrap: true,
          primary: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Datum pendingOrderList = widget.pendingOrderList[index];
            return ConstantOrderId(
              item: pendingOrderList,
              color: AppColors.white10,
              colorBorder: AppColors.white10,
              widgets: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: AppColors.neutralBorder,
                          height: 0.5,
                          // width: 100,
                        ),
                      ),
                      Text(" Set food preparation time ",
                          style: AppTextStyles.kSmall10RegularTextStyle
                              .copyWith(color: AppColors.neutralLightFonts)),
                      Expanded(
                        child: Container(
                          color: AppColors.neutralBorder,
                          height: 0.5,
                          // width: 100,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .052,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.neutralBorder),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            decrement();
                          },
                          icon: const Icon(
                            CupertinoIcons.minus,
                            color: AppColors.primary700,
                          ),
                        ),
                        const VerticalDivider(
                          width: 2,
                          thickness: 0.5,
                          color: AppColors.primary700,
                        ),
                        Text("$_counter mins",
                            style: AppTextStyles.kCaption12RegularTextStyle
                                .copyWith(
                              color: AppColors.neutralBodyFont,
                            )),
                        const VerticalDivider(
                          width: 2,
                          thickness: 0.5,
                          color: AppColors.primary700,
                        ),
                        IconButton(
                          onPressed: () {
                            increment();
                          },
                          icon: const Icon(
                            CupertinoIcons.add,
                            color: AppColors.primary700,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          await overviewController.updateOrderStatusLogic(
                              uniqueId: pendingOrderList.uniqueId.toString(),
                              status: "Cancelled");
                          overviewController.getOverViewList();
                          getOrdersController.getOrdersList();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
// color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.neutralBorder),
                          ),
                          child: Center(
                              child: Text("Reject",
                                  style: AppTextStyles.kBody15SemiboldTextStyle
                                      .copyWith(color: AppColors.neutralDark))),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          startTimer();
                          await overviewController.updateOrderStatusLogic(
                              uniqueId: pendingOrderList.uniqueId.toString(),
                              status: "Accepted");
                          overviewController.updateOrderStatusTimer(
                              uniqueId: pendingOrderList.uniqueId.toString(),
                              time: _counter);
                          overviewController.getOverViewList();
                          getOrdersController.getOrdersList();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: AppColors.primary700,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.neutralBorder),
                          ),
                          child: Center(
                              child: Text(
                            "Accept",
                            style: AppTextStyles.kCaption12SemiboldTextStyle
                                .copyWith(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              status: '',
            );
          });
    } else {
      return const Center(child: Text("No orders"));
    }
  }
}
