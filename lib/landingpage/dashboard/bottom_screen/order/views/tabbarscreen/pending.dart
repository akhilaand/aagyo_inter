// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/home_page.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/pending.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/constantOrderid.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import 'package:aagyo/styles/textstyle_const.dart';

class PendingOrder extends StatefulWidget {
  final ScrollPhysics ? physics;
  final List pendingOrderList;

  const PendingOrder({Key? key, this.physics, required this.pendingOrderList, }) : super(key: key);

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Pending(pendingOrderList: widget.pendingOrderList,),
      ],
    );
  }
}

