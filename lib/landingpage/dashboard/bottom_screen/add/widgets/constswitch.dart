// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../../../../colors/colors_const.dart';
import '../../../../../styles/textstyle_const.dart';

class ConstSwitchWithoutText extends StatefulWidget {
  final Function(bool value) callBack;

  const ConstSwitchWithoutText({super.key, required this.callBack});
  @override
  SwitchClass createState() =>  SwitchClass(callBack);
}

class SwitchClass extends State {
  final Function(bool value) callBack;
  SwitchClass(this.callBack);
  bool isSwitched = false;
  var textValue = 'Disabled';

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
    callBack(isSwitched);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.end,
        children:[
          Text('Veg',style:AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.neutralBodyFont))

          ,Transform.scale(
            scale: 0.52,
            child: CupertinoSwitch(

              onChanged: toggleSwitch,
              value: isSwitched,
              activeColor: Colors.brown,
              thumbColor: Colors.white,
              trackColor: Colors.green,
              // activeTrackColor: Colors.white,
            ),
          ),

          Text('Nov-Veg',style:AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.neutralBodyFont))
        ]);
  }
}
