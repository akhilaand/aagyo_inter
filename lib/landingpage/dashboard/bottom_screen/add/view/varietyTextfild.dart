// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constContainer.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/add/widgets/varietyconstat.dart';
import 'package:aagyo/modal/add_new_variant_modal.dart';
import 'package:aagyo/modal/varient_modal.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../controller/list_product_controller.dart';
import '../../menu/widgets/constdropdown.dart';

class Variety extends StatefulWidget {
  final List attributeList;
  final List<VarientModal> varientList;
  final List<String> unitList;

  const Variety(
      {Key? key,
      required this.attributeList,
      required this.unitList,
      required this.varientList})
      : super(key: key);

  @override
  State<Variety> createState() => _VarietyState();
}

class _VarietyState extends State<Variety> {
  final productController = Get.put(ListProductController());
  bool showListView = false;
  String discountTypeValue = "Amount";
  String attributeValue = "";
  String unitValue = "";

  final TextEditingController varientNameController = TextEditingController();
  final TextEditingController discountTypeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void toggleListView() {
    setState(() {
      showListView = !showListView;
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDataAgainstVariant(variantList: widget.varientList,selectedString: widget.varientList.first.type.toString());
  }
  void clearAllVariantController() {
    varientNameController.clear();
    discountTypeController.clear();
    discountController.clear();
    mrpController.clear();
    salePriceController.clear();
    stockController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.clearDiscountRelatedData();
  }

  @override
  Widget build(BuildContext context) {
    return ConstantContainer(
        height: .4,
        width: .9,
        radiusBorder: 2,
        borderWidth: 0.5,
        widget: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  VarientNameDropDown(
                    varientList: widget.varientList.map((VarientModal varient) {
                      return varient.type.toString();
                    }).toList(),
                    varientCallBack: (value) {
                      setDataAgainstVariant(variantList: widget.varientList,selectedString: value);
                    },
                  ),
                  AttributesDropDown(
                      attributeCallBack: (value) {
                        attributeValue = value;
                        productController.getUnitListForDropDown(
                            attributeName: attributeValue);
                      },
                      itemList: widget.attributeList),
                ],
              ),
              // ValueListenableBuilder<String>(
              //   valueListenable: errorMessage,
              //   builder: (context, value, child) {
              //     return Text(
              //       value,
              //       style: TextStyle(color: Colors.red),
              //     );
              //   },
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() {
                    return UnitDropDown(
                      key: UniqueKey(),
                      unitCallBack: (value) {
                        unitValue = value;
                      },
                      unitList: productController.unitList
                          .map((element) => element.toString())
                          .toList(),
                    );
                  }),
                  ConstVarity(
                    controler: stockController,
                    hint: '10',
                    label: "Stock",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConstVarity(
                      controler: salePriceController,
                      hint: 'Rs10',
                      label: 'Sale Price',
                      isAdditionalValidationRequired: true,
                      onChanged: (value) {
                        productController.salePrice.value = double.parse(value);
                        productController.getDiscountPercentage();
                      }),
                  ConstVarity(
                    controler: mrpController,
                    hint: 'Rs10',
                    label: "MRP",
                    onChanged: (value) {
                      productController.mrp.value = double.parse(value);
                      productController.getDiscountPercentage();
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DiscountTypeDropDown(discountTypeCallBack: (val) {}),
                  Obx(() {
                    String discountPercentage =
                        productController.discountPercentage.ceil().toString();
                    return ConstVarity(
                      isTextEnabled: false,
                      needValidation: false,
                      controler: discountController,
                      hint: '20',
                      label: "$discountPercentage %",
                    );
                  })
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    if (discountTypeValue.isEmpty) {
                      Get.showSnackbar(const GetSnackBar(
                        titleText: Text(
                          "Error",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w800),
                        ),
                        messageText: Text(
                          "Please select discount type",
                          style: TextStyle(color: Colors.white),
                        ),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.grey,
                        icon: Icon(
                          Icons.add_alert,
                          color: Colors.white,
                        ),
                      ));
                    } else {
                      if (formKey.currentState!.validate()) {
                        AddNewVariantModal variant = AddNewVariantModal(
                            type: varientNameController.text,
                            categoryId: attributeValue,
                            discount: productController.discountPercentage.value
                                .ceil()
                                .toString(),
                            discountType: discountTypeValue.toLowerCase(),
                            mrp: mrpController.text,
                            price: salePriceController.text,
                            stock: stockController.text,
                            unit: unitValue);
                        productController.addNewVariant(variant);
                        clearAllVariantController();
                      }
                    }
                  },
                  child: const Center(
                    child: ConstantContainer(
                        height: .06,
                        width: .4,
                        radiusBorder: 5,
                        borderWidth: .5,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              CupertinoIcons.add,
                              color: AppColors.neutralLightFonts,
                              size: 20,
                            ),
                            Text(
                              "Add Another Varient",
                              style: AppTextStyles.kCaption12RegularTextStyle,
                            )
                          ],
                        ),
                        borderColor: AppColors.neutralBorder),
                  ),
                ),
              ),
            ],
          ),
        ),
        borderColor: AppColors.neutralBorder);
  }

  void setDataAgainstVariant(
      {required List<VarientModal> variantList,
      required String selectedString}) {
    VarientModal? item;
    for (var variant in variantList) {
      if (variant.type == selectedString) {
        item = variant;
      }
    }
    setState(() {
      stockController.text = item?.stock ?? "";
    });
  }
}

class VarientNameDropDown extends StatefulWidget {
  final List<String>? varientList;
  final Function(String) varientCallBack;

  const VarientNameDropDown({
    Key? key,
    required this.varientCallBack,
    this.varientList,
  }) : super(key: key);

  @override
  State<VarientNameDropDown> createState() => _VarientNameDropDownState();
}

class _VarientNameDropDownState extends State<VarientNameDropDown> {
  String? dropDownValue;
  @override
  Widget build(BuildContext context) {
    dropDownValue = dropDownValue ??
        (widget.varientList!.isNotEmpty ? widget.varientList![0] : "");
    return ConstantContainer(
      height: .055,
      width: .4,
      radiusBorder: 5,
      borderColor: AppColors.neutralBorder,
      borderWidth: 1,
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            // Initial Value
            value: dropDownValue,

            // Down Arrow Icon
            icon: const Icon(Icons.arrow_drop_down),

            // Array list of items
            items: widget.varientList?.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: AppTextStyles.kBody15RegularTextStyle,
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;
              });
              widget.varientCallBack(dropDownValue.toString());
            },
          ),
        ),
      ),
    );
  }
}

class UnitDropDown extends StatefulWidget {
  final List<String>? unitList;
  final Function(String) unitCallBack;

  const UnitDropDown({
    Key? key,
    required this.unitCallBack,
    this.unitList,
  }) : super(key: key);

  @override
  State<UnitDropDown> createState() => _UnitDropDownState();
}

class _UnitDropDownState extends State<UnitDropDown> {
  String? dropDownValue;
  @override
  Widget build(BuildContext context) {
    dropDownValue = dropDownValue ??
        (widget.unitList!.isNotEmpty ? widget.unitList![0] : "");
    return ConstantContainer(
      height: .055,
      width: .4,
      radiusBorder: 5,
      borderColor: AppColors.neutralBorder,
      borderWidth: 1,
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            // Initial Value
            value: dropDownValue,

            // Down Arrow Icon
            icon: const Icon(Icons.arrow_drop_down),

            // Array list of items
            items: widget.unitList?.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: AppTextStyles.kBody15RegularTextStyle,
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;
              });
              widget.unitCallBack(dropDownValue.toString());
            },
          ),
        ),
      ),
    );
  }
}

class AttributesDropDown extends StatefulWidget {
  final List itemList;

  final Function(String) attributeCallBack;
  const AttributesDropDown({
    Key? key,
    required this.attributeCallBack,
    required this.itemList,
  }) : super(key: key);

  @override
  State<AttributesDropDown> createState() => _AttributesDropDownState();
}

class _AttributesDropDownState extends State<AttributesDropDown> {
  String? dropdownvalue;
  var items = ['Select Attributes', 'aata', 'amul', 'kheer'];
  @override
  Widget build(BuildContext context) {
    dropdownvalue = dropdownvalue ??
        widget.itemList.map((e) {
          return e.name.toString();
        }).toList()[0];
    return ConstantContainer(
      height: .055,
      width: .4,
      radiusBorder: 5,
      borderColor: AppColors.neutralBorder,
      borderWidth: 1,
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            // Initial Value
            value: dropdownvalue,

            // Down Arrow Icon
            icon: const Icon(Icons.arrow_drop_down),

            // Array list of items
            items: getCategoryNameList(widget.itemList).map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: AppTextStyles.kBody15RegularTextStyle,
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
              widget.attributeCallBack(dropdownvalue ?? "");
            },
          ),
        ),
      ),
    );
  }
}

class DiscountTypeDropDown extends StatefulWidget {
  final Function(String) discountTypeCallBack;
  const DiscountTypeDropDown({
    Key? key,
    required this.discountTypeCallBack,
  }) : super(key: key);

  @override
  State<DiscountTypeDropDown> createState() => _DiscountTypeDropDownState();
}

class _DiscountTypeDropDownState extends State<DiscountTypeDropDown> {
  String dropdownvalue = 'Percent';
  var items = ['Percent'];
  @override
  Widget build(BuildContext context) {
    return ConstantContainer(
      height: .055,
      width: .4,
      radiusBorder: 5,
      borderColor: AppColors.neutralBorder,
      borderWidth: 1,
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            // Initial Value
            value: dropdownvalue,

            // Down Arrow Icon
            icon: const Icon(Icons.arrow_drop_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: AppTextStyles.kBody15RegularTextStyle,
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
              widget.discountTypeCallBack(dropdownvalue ?? "");
            },
          ),
        ),
      ),
    );
  }
}
