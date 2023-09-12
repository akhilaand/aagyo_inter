// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../../../../colors/colors_const.dart';
import '../../../../../../const/constContainer.dart';
import '../../../../../../styles/textstyle_const.dart';
import '../../widgets/constantOrderid.dart';
import '../../widgets/vaccinatedconstant.dart';

class PickedUp extends StatefulWidget {
  final ScrollPhysics ? physics;
  final List pickedUpOrderList;

  const PickedUp({Key? key, this.physics, required this.pickedUpOrderList}) : super(key: key);

  @override
  State<PickedUp> createState() => _PickedUpState();
}

class _PickedUpState extends State<PickedUp> {
  late Timer _timer;
  int _start = 59;

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
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.pickedUpOrderList.isNotEmpty){
      return ListView.builder(
          itemCount: widget.pickedUpOrderList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index) {
            Datum pickedUpOrderList = widget.pickedUpOrderList[index];

            return ConstantOrderId(
              item: pickedUpOrderList,
              widgets: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    VaccinatedConstant(callColor: AppColors.primary700,deliveryPartnerDetails: pickedUpOrderList.delievryMan),
                    const SizedBox(
                      height: 8,
                    ),

                  ],
                ),
              ), status: 'Pickedup',);
          }
      );
    }else{
      return const Center(child: Text("No orders"));
    }

  }
}
