// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/controller/list_product_controller.dart';
import '../../../../../colors/colors_const.dart';
import '../../../../../styles/textstyle_const.dart';

class SwitchScreen extends StatefulWidget {
  final Function onTap;
  final bool isSwitched;
  final String productUniqueId;

  const SwitchScreen({super.key, required this.onTap, required this.isSwitched, required this.productUniqueId});
  @override
  SwitchClass createState() => SwitchClass(isSwitched:isSwitched,productUniqueId: productUniqueId );
}

class SwitchClass extends State {
  var textValue = 'Disabled';
   bool isSwitched;
   String productUniqueId;
  SwitchClass({required this.isSwitched,required this.productUniqueId});
final productController = Get.put(ListProductController());
  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Enabled';
      });

    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'Disabled';
      });

    }
    productController.enableOrDisableProduct(uniqueId: productUniqueId);

  }
  @override
  Widget build(BuildContext context) {
    return Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children:[
          Transform.scale(
            scale: 0.52,
            child: CupertinoSwitch(

              onChanged: toggleSwitch,
              value: isSwitched,
              // activeColor: Colors.green,
              thumbColor: Colors.white,
              // activeTrackColor: Colors.white,
            ),
          ),

          Text(textValue,style:AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.neutralBodyFont))
        ]);
  }
}  
