// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../modal/varient_modal.dart';

class VarientListView extends StatelessWidget {
  final List<VarientModal> varientList;
  const VarientListView({
    super.key,
    required this.widget,
    required this.varientList,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    print("varient list length uis ${varientList.length}");
    if(varientList.isEmpty){
      return Container();
    }else{

      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:varientList.length,
          itemBuilder: (BuildContext context, index) {
            print(index);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                        offset: const Offset(4, 8), // Shadow position
                      ),
                    ],
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          varientInfoTextWidget(
                              infoType: "Type",
                              infoValue: varientList[index].type.toString(),
                              index: index),
                          varientInfoTextWidget(
                              infoType: "Price",
                              infoValue:
                              "₹ ${varientList[index].price.toString()}",
                              index: index),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      varientInfoTextWidget(
                          infoType: "Unit",
                          infoValue: varientList[index].unit.toString(),
                          index: index),
                      const SizedBox(
                        height: 4,
                      ),
                      varientInfoTextWidget(
                          infoType: "Stock",
                          infoValue: varientList[index].stock.toString(),
                          index: index),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          varientInfoTextWidget(
                              infoType: "Discount Type",
                              infoValue:
                              varientList[index].discountType.toString(),
                              index: index),
                          varientInfoTextWidget(
                              infoType: "Discount",
                              infoValue: setPreixText(
                                  discountType:
                                  varientList[index].discountType.toString().toLowerCase(),
                                  discount:
                                  varientList[index].discount.toString()),
                              index: index),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });

    }
  }

  String setPreixText(
      {required String discountType, required String discount}) {
    String prefixText = "";
    if (discountType == "amount") {
      prefixText = "₹ $discount";
    } else {
      prefixText = "$discount %";
    }
    return prefixText;
  }

  RichText varientInfoTextWidget(
      {required int index,
      required String infoType,
      required String infoValue}) {
    return RichText(
      text: TextSpan(
        text: '$infoType : ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
              text: infoValue,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
