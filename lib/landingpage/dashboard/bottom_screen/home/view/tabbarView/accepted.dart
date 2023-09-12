// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aagyo/controller/overview_controller.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/modal/list_order_modal.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../../../../colors/colors_const.dart';
import '../../../../../../const/constContainer.dart';
import '../../../../../../controller/list_order_controller.dart';
import '../../../../../../styles/textstyle_const.dart';
import '../../utils/Utils.dart';
import '../../widgets/constantOrderid.dart';
import '../../widgets/vaccinatedconstant.dart';

class Accept extends StatefulWidget {
  final List acceptedOrderList;

  final ScrollPhysics? physics;
  const Accept({Key? key, this.physics, required this.acceptedOrderList})
      : super(key: key);

  @override
  State<Accept> createState() => _AcceptState();
}

class _AcceptState extends State<Accept> {
  int tapCount = 0;

  void changeContent() {
    setState(() {
      tapCount++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.acceptedOrderList.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.acceptedOrderList.length,
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Datum acceptedList = widget.acceptedOrderList[index];
            bool doOrderAssigned = acceptedList.delievryMan != null;

            return ConstantOrderId(
              item: acceptedList,
              widgets: Column(
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: doOrderAssigned
                          ? ConstantContainer(
                              // color: Colors.red,
                              height: .07,
                              width: .9,
                              radiusBorder: 5,
                              borderWidth: 0,
                              widget: VaccinatedConstant(
                                deliveryPartnerDetails:
                                    acceptedList.delievryMan,
                                callColor: AppColors.primary700,
                              ),
                              borderColor: Colors.white10)
                          : ConstantContainer(
                              height: .043,
                              width: .9,
                              radiusBorder: 5,
                              borderWidth: .5,
                              borderColor: AppColors.primary700,
                              widget: Center(
                                  child: Text(
                                "${acceptedList.nearestDeliveryAgent?.length} riders nearby,assigning soon",
                                style: AppTextStyles.kCaption12RegularTextStyle
                                    .copyWith(color: AppColors.neutralBodyFont),
                              )))),
                  const SizedBox(
                    height: 15,
                  ),
                  OrderReadyButton(
                      uniqueId: acceptedList.uniqueId.toString(),
                      deliveryTime: acceptedList.deliveryTime.toString()),
                ],
              ),
              status: 'Ready',
            );
          });
    } else {
      return const Center(child: Text("No orders"));
    }
  }
}

class OrderReadyButton extends StatefulWidget {
  final String deliveryTime;
  final String uniqueId;
  const OrderReadyButton({
    required this.deliveryTime,
    required this.uniqueId,
    super.key,
  });

  @override
  State<OrderReadyButton> createState() => _OrderReadyButtonState();
}

class _OrderReadyButtonState extends State<OrderReadyButton> {
  final overViewController = Get.put(OverviewController());
  final listOrderController = Get.put(ListOrderController());

  String timeLeft = "00:00";
  @override
  void initState() {
    // TODO: implement initState
    // startTimer(widget.deliveryTime);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  startTimer(String deliveryTime) {
    // finding duration
    Duration duration = findTimer(deliveryTime);

    // logic for timer
    if (!duration.isNegative) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (duration.inSeconds > 0 && mounted) {
          duration = duration - const Duration(seconds: 1);
          setState(() {
            timeLeft =
                "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
          });
          print(timeLeft);
        } else {
          // setState(() {
          //   timeLeft = "00:00";
          // });
          timer.cancel(); // Stop the timer when duration reaches 0
        }
      });
    }
  }

  Duration findTimer(String deliveryTime) {
    // extracting current time
    DateTime currentTime = DateTime.now();

    // extracting delivery time
    DateTime convertedTime = DateFormat("HH:mm:ss")
        .parse(deliveryTime); //not required once unneccesary data flushed
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(
        convertedTime); //not required once unneccesary data flushed
    DateTime deliveryDateTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        timeOfDay.hour,
        timeOfDay.minute); //not required once unneccesary data flushed

    // calculation duration
    Duration duration = Duration(
        hours: deliveryDateTime.hour - currentTime.hour,
        minutes: deliveryDateTime.minute - currentTime.minute,
        seconds: deliveryDateTime.second - currentTime.second);
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await overViewController.updateOrderStatusLogic(
            uniqueId: widget.uniqueId.toString(), status: "Order Ready");
      },
      child: ConstantContainer(
          height: .06,
          width: .9,
          radiusBorder: 5,
          borderWidth: .5,
          color: AppColors.primary700,
          borderColor: AppColors.primary700,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Order ready",
                style: AppTextStyles.kCaption12SemiboldTextStyle
                    .copyWith(color: AppColors.white),
              ),
              Text(
                "  ($timeLeft)",
                style: AppTextStyles.kSmall10SemiboldTextStyle
                    .copyWith(color: AppColors.white30),
              ),
            ],
          )),
    );
  }
}
