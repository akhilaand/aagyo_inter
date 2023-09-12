// Flutter imports:
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/view/tabbarView/delivered.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../../../../colors/colors_const.dart';
import '../../../../../../const/constContainer.dart';
import '../../../../../../styles/textstyle_const.dart';
import '../../widgets/constantOrderid.dart';

class Rejected extends StatefulWidget {
  final ScrollPhysics ? physics;
  final List rejectedOrderList;

  const Rejected({Key? key, this.physics, required this.rejectedOrderList}) : super(key: key);

  @override
  State<Rejected> createState() => _RejectedState();
}

class _RejectedState extends State<Rejected> {
  @override
  Widget build(BuildContext context) {
    if(widget.rejectedOrderList.isNotEmpty){
      return ListView(
          children: [
            Rejected( rejectedOrderList: widget.rejectedOrderList,)
          ],
      );
    }else{
      return const Center(child: Text("No orders"));
    }

  }
}
