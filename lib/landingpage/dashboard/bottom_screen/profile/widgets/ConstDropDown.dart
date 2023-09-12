

// Flutter imports:
import 'package:aagyo/controller/overview_controller.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/const/constContainer.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../colors/colors_const.dart';

class ConstDropDownProfile extends StatefulWidget {

  const ConstDropDownProfile({Key? key, }) : super(key: key);

  @override
  State<ConstDropDownProfile> createState() => _ConstDropDownProfileState();
}

class _ConstDropDownProfileState extends State<ConstDropDownProfile> {
  final overviewController = Get.put(OverviewController());
  String dropdownvalue = "Today";
  var items = ['Today', 'Yesterday', 'This Week', 'Custom'];
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ConstantContainer(
        height: .04,
        width: .35,
        radiusBorder: 5,
        borderColor: AppColors.neutralBorder,
        borderWidth: .5,
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  DropdownButtonHideUnderline(
            child: DropdownButton(
              // Initial Value
              value: overviewController.selectedFilter.value,

              // Down Arrow Icon
              icon: const Icon(Icons.arrow_drop_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,


                  child: Text(
                    items,
                    style: AppTextStyles.kCaption12RegularTextStyle,
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue)async {
                 //startDate and endDate values are only used when selected values is CUSTOM
                DateTime? startDate;
                DateTime? endDate;
                if(newValue=="Custom"){
                  final picked = await showDateRangePicker(
                    context: context,
                    lastDate: DateTime.now(),
                    firstDate: new DateTime(2022),
                  );
                  if(picked!=null){
                      startDate = picked.start;
                     endDate = picked.end;
                  }
                }
                overviewController.getOverViewList(startDate:startDate,endDate: endDate);
                overviewController.selectedFilter.value = newValue.toString();
              },
            ),
          ),
        ),
      );
    });


  }

}
