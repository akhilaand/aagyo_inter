// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/home/widgets/vaccinatedconstant.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../../../../const/constContainer.dart';
import '../../../../../../styles/textstyle_const.dart';
import '../../widgets/constantOrderid.dart';

class Delivered extends StatefulWidget {
  final ScrollPhysics ? physics;
  final List deliveredOrderList;

  const Delivered({Key? key, this.physics,required this.deliveredOrderList}) : super(key: key);

  @override
  State<Delivered> createState() => _DeliveredState();
}

class _DeliveredState extends State<Delivered> {
  @override
  Widget build(BuildContext context) {
    if(widget.deliveredOrderList.isNotEmpty){
      return ListView.builder(
          itemCount: widget.deliveredOrderList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            Datum deliveredOrderList = widget.deliveredOrderList[index];

            return ConstantOrderId(
              item: deliveredOrderList,
              widgets: Column(
                children: [
                  VaccinatedConstant(callColor: AppColors.neutralBorder,deliveryPartnerDetails: deliveredOrderList.delievryMan),
                  const SizedBox(height: 10,),
                  ConstantContainer(
                    height: .06,
                    width: .9,
                    radiusBorder: 5,
                    borderWidth: .5,
                    color: AppColors.white10,
                    borderColor: AppColors.neutralBorder,
                    widget:Center(
                      child: Text(
                        "Delivered",
                        style: AppTextStyles.kBody15SemiboldTextStyle
                            .copyWith(color: AppColors.neutralBorder),
                      ),
                    ),)
                ],
              ), status: 'Delivered',);
          });
    }else{
      return const Center(child: Text("No orders"));
    }

  }
}
