// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/constantOrderid.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../../../../colors/colors_const.dart';
import '../../../../../../const/constContainer.dart';
import '../../../../../../styles/textstyle_const.dart';
import '../../../home/view/tabbarView/pickedup.dart';
import '../../../home/widgets/vaccinatedconstant.dart';

class PickedUpOrder extends StatefulWidget {
  final ScrollPhysics ? physics;
  final List pickedUpOrderList;

  const PickedUpOrder({Key? key, this.physics, required this.pickedUpOrderList}) : super(key: key);

  @override
  State<PickedUpOrder> createState() => _PickedUpOrderState();
}

class _PickedUpOrderState extends State<PickedUpOrder> {
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
    return ListView(
      children: [
        PickedUp( pickedUpOrderList: widget.pickedUpOrderList,)
      ],
    );
  }
}
