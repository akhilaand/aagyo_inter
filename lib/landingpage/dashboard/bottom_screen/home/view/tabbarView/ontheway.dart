// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/vaccinatedconstant.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import '../../widgets/constantOrderid.dart';

class Ontheway extends StatefulWidget {
  final ScrollPhysics ? physics;
  final List onTheWayOrderList;

  const Ontheway({Key? key, this.physics,required this.onTheWayOrderList}) : super(key: key);

  @override
  State<Ontheway> createState() => _OnthewayState();
}

class _OnthewayState extends State<Ontheway> {
  @override
  Widget build(BuildContext context) {
if(widget.onTheWayOrderList.isNotEmpty){
  return ListView.builder(
      itemCount: widget.onTheWayOrderList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context,index) {
        Datum onTheWayOrderList = widget.onTheWayOrderList[index];

        return ConstantOrderId(
          item: onTheWayOrderList,
          widgets: Column(
            children: [
              VaccinatedConstant(callColor: AppColors.primary700,deliveryPartnerDetails: onTheWayOrderList.delievryMan,)
            ],
          ), status: 'On the way',);
      }
  );
}else{
  return const Center(child: Text("No orders"));

}

  }
}
