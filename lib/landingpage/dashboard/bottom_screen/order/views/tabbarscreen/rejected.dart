// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/modal/list_order_modal.dart';
import '../../../../../../colors/colors_const.dart';
import '../../../../../../const/constContainer.dart';
import '../../../../../../styles/textstyle_const.dart';
import '../../../home/widgets/constantOrderid.dart';

class RejectedOrder extends StatefulWidget {
  final ScrollPhysics ? physics;
  const RejectedOrder({Key? key, this.physics, required this.rejectedOrderList}) : super(key: key);
  final List rejectedOrderList;

  @override
  State<RejectedOrder> createState() => _RejectedOrderState();
}

class _RejectedOrderState extends State<RejectedOrder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.rejectedOrderList.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context,index) {
        Datum rejectedOrderList = widget.rejectedOrderList[index];

        return ConstantOrderId(
          item: rejectedOrderList,

          widgets: Column(

          children: [

            ConstantContainer(
                height: .06,
                width: .9,
                radiusBorder: 5,
                borderWidth: .5,
                color: AppColors.white10,
                borderColor: AppColors.neutralBorder,
                widget:Center(
                  child: Text(
                    "Rejected",
                    style: AppTextStyles.kBody15SemiboldTextStyle
                        .copyWith(color: AppColors.neutralBorder),
                  ),
                ),)

        ]), status: 'Rejected',);
      }
    );
  }
}
