// Flutter imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/delivered.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/vaccinatedconstant.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../../../../const/constContainer.dart';
import '../../../../../../styles/textstyle_const.dart';
import '../../../home/widgets/constantOrderid.dart';

class DeliveredOrder extends StatefulWidget {
  final ScrollPhysics ? physics;
  final List deliveredOrderList;
  const DeliveredOrder({Key? key, this.physics, required this.deliveredOrderList}) : super(key: key);

  @override
  State<DeliveredOrder> createState() => _DeliveredOrderState();
}

class _DeliveredOrderState extends State<DeliveredOrder> {
  @override
  Widget build(BuildContext context) {
    return ListView(
       children: [
         Delivered(deliveredOrderList: widget.deliveredOrderList)
       ],
    );
  }
}
