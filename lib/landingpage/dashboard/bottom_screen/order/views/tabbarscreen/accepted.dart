// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/accepted.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/utils/Utils.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/constantOrderid.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../../../../colors/colors_const.dart';
import '../../../../../../const/constContainer.dart';
import '../../../../../../styles/textstyle_const.dart';
import '../../../home/widgets/vaccinatedconstant.dart';

class AcceptOrder extends StatefulWidget {
  final List acceptedOrderList;
  final ScrollPhysics ? physics;
  const AcceptOrder({Key? key, this.physics, required this.acceptedOrderList}) : super(key: key);

  @override
  State<AcceptOrder> createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptOrder> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Accept( acceptedOrderList: widget.acceptedOrderList,),
      ],
    );
  }
}
