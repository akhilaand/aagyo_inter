// Flutter imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/ontheway.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/vaccinatedconstant.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../home/widgets/constantOrderid.dart';

class OnthewayOrder extends StatefulWidget {
  final ScrollPhysics ? physics;
  final List onTheWayOrderList;

  const OnthewayOrder({Key? key, this.physics, required this.onTheWayOrderList}) : super(key: key);

  @override
  State<OnthewayOrder> createState() => _OnthewayOrderState();
}

class _OnthewayOrderState extends State<OnthewayOrder> {
  @override
  Widget build(BuildContext context) {
    return ListView(
    children: [
      Ontheway(onTheWayOrderList: widget.onTheWayOrderList)
    ],
    );
  }
}
