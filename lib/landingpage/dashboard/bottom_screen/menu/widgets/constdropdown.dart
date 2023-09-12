// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/controller/list_product_controller.dart';
import 'package:aagyo/styles/textstyle_const.dart';

class ConstDropDown extends StatefulWidget {
  final String name;
  final List<String> itemList;
  final String dropDownInitialValue;
  final Function(String value) onChanged;
  const ConstDropDown(
      {Key? key,
      required this.name,
      required this.itemList,
      required this.onChanged,
      required this.dropDownInitialValue})
      : super(key: key);

  @override
  State<ConstDropDown> createState() => _ConstDropDownState();
}

class _ConstDropDownState extends State<ConstDropDown> {
  String? dropdownvalue;
  final productController = Get.put(ListProductController());
  // var items = ['Amul', 'Aata', 'Dahi'];

  @override
  Widget build(BuildContext context) {

    dropdownvalue = dropdownvalue ?? widget.dropDownInitialValue;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: AppTextStyles.kCaption12RegularTextStyle
                .copyWith(color: AppColors.neutralBodyFont),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: DropdownButton(
              // Initial Value
              value: dropdownvalue,
              // Down Arrow Icon
              icon: Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.arrow_drop_down),
                      ],
                    )),
              ),

              // Array list of items
              items: widget.itemList.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
                widget.onChanged(newValue.toString());

              },
            ),
          ),
        ],
      ),
    );
  }
}

List<String> getCategoryNameList(List itemList) {
  List<String> categoryNameList =
      itemList.map((category) => category.name.toString()).toList();
  return categoryNameList;
}
