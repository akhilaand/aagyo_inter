// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constContainer.dart';
import 'package:aagyo/controller/list_product_controller.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/add/view/varietyTextfild.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/add/widgets/constswitch.dart';
import 'package:aagyo/modal/add_new_variant_modal.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../modal/varient_modal.dart';
import '../../../../../services/core.dart';
import '../widgets/varient_list_view.dart';

class EditProduct extends StatefulWidget {
  final String categoryName;
  final String subCategoryName;
  final String productName;
  final String moduleId;
  final String startTime;
  final String endTime;
  final String productId;
  final String variantDetails;
  const EditProduct(
      {Key? key,
      required this.moduleId,
      required this.productId,
      required this.startTime,
      required this.endTime,
      required this.variantDetails,
      required this.categoryName,
      required this.subCategoryName,
      required this.productName})
      : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool showListView = false;
  final productController = Get.put(ListProductController());
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController subCategoryNameController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController taxController = TextEditingController();


  String subCategoryValue = "";
  String attributeValue = "";
  String discountTypeValue = "Amount";
  String unitValue = "";
  bool vegOrNonVeg = false; //false for veg
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUnitListFromVariantList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getCategoryList(moduleId: widget.moduleId);
    });
    initializeTextControllers();
  }

  initializeTextControllers() {
    categoryNameController.text = widget.categoryName;
    subCategoryNameController.text = widget.subCategoryName;
    productNameController.text = widget.productName;
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = [];

    void addAnotherVarient() {
      setState(() {
        items.add('New Item'); // Add a new item to the list
      });
    }

    void toggleListView() {
      setState(() {
        showListView = !showListView;
      });
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Edit Product",
            style: AppTextStyles.kBody17SemiboldTextStyle
                .copyWith(color: AppColors.neutralDark),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.neutralDark,
              )),
        ),
        body: Obx(() {
          if(productController.isLoading.isFalse&&productController.categoryList.isNotEmpty){
            attributeValue= attributeValue.isEmpty?productController.categoryList[0].toString():attributeValue;
            unitValue=unitValue.isEmpty?getUnitListFromVariantList()[0]:unitValue;
          }
          // varientNameController.text = "2";
          // discountController.text = "5";
          // mrpController.text = "8";
          // salePriceController.text = "7";
          // stockController.text = "9";



          return ModalProgressHUD(
            inAsyncCall: productController.isLoading.isTrue,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ConstTextField(
                      controller: categoryNameController,
                      height1: 0,
                      isEnabled: false,
                      title: 'Category Name',
                      hint: 'Category Name',
                    ),
                    ConstTextField(
                      controller: subCategoryNameController,
                      height1: 0,
                      isEnabled: false,
                      title: 'Sub Category Name',
                      hint: 'Sub Category Name',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ConstTextField(
                      controller: productNameController,
                      height1: 0,
                      title: 'Product Name',
                      hint: 'Add your product name',
                    ),
                    ConstTextField(
                      controller: descriptionController,
                      height: 5,
                      title: 'Description',
                      hint: 'Comment/Optional',
                      maxLine: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.neutralBorder, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.neutralBorder, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.neutralBorder, width: 1)),
                        filled: true,
                        fillColor: AppColors.neutralBackground,
                      ),
                    ),
                    Text(
                      "Maximum 100 characters",
                      style: AppTextStyles.kSmall8RegularTextStyle
                          .copyWith(color: AppColors.neutralBodyFont),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstTextField(
                      controller: tagController,
                      title: 'Tags',
                      hint: 'Add tags related to product',
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: const ConstTextField(
                              title: 'Tax',
                              hint: 'Add Tax Percentge',
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Display Veg/Non-Veg",
                          style: AppTextStyles.kCaption12RegularTextStyle,
                        ),
                        const Spacer(),
                        ConstSwitchWithoutText(
                          callBack: (value) {
                            vegOrNonVeg = value;
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text("Available Varients"),
                    const SizedBox(
                      height: 3,
                    ),

                    VarientListView(
                      key: UniqueKey(),
                        widget: widget,
                        varientList: getDecodedVariantDetails(
                            variantDetails: widget.variantDetails)),
                    VarientListView(
                      key: UniqueKey(),

                      widget: widget,
                        varientList:
                        productController.newVariantMapList.map((variantMap) => VarientModal.fromJson(variantMap)).toList(),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text("Varient"),
                          const Spacer(),
                          IconButton(
                              onPressed: toggleListView,
                              icon: Icon(showListView
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down)),
                        ],
                      ),
                    ),
                    if (showListView)
                      Variety(
varientList: getDecodedVariantDetails(
    variantDetails: widget.variantDetails),
                          attributeList: productController.attributeList,
                          unitList:
                          productController.unitList.cast<String>()
                        // getUnitList(
                        //     productController.productDetails[int.parse(
                        //         productController.productCurrentIndex
                        //             .toString())])
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        ProductUpdateModal updatedModal = ProductUpdateModal(
                            productId: widget.productId,
                            stock:
                                productController.totalStock.value.toString(),
                            tag: tagController.text,
                            startTime: widget.startTime,
                            endTime: widget.endTime,
                            variantDetails:
                                productController.newVariantMapList.value);
                        productController.editProduct(
                            updatedValues: updatedModal);
                        await productController.getProductViewList();
                        Navigator.of(context).pop();
                      },
                      child: ConstantContainer(
                          height: .06,
                          width: .94,
                          color: AppColors.primary700,
                          radiusBorder: 5,
                          borderWidth: .5,
                          widget: Center(
                              child: Text(
                            "Publish",
                            style: AppTextStyles.kBody15SemiboldTextStyle
                                .copyWith(color: AppColors.white10),
                          )),
                          borderColor: AppColors.neutralBorder),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  List<String> getUnitListFromVariantList() {
    List<VarientModal> jsonDecodedVariantList = getDecodedVariantDetails(
      variantDetails: widget.variantDetails,
    );
    List<String> unitList = jsonDecodedVariantList.map((e) {
      return e.unit.toString();
    }).toList();
    return unitList;
  }


}

class ConstTextField extends StatefulWidget {
  final String title;
  final String hint;
  final int? maxLine;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final double? height;
  final double? height1;
  final bool isEnabled;
  const ConstTextField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.decoration,
      this.maxLine,
      this.height,
      this.isEnabled = true,
      this.height1})
      : super(key: key);

  @override
  State<ConstTextField> createState() => _ConstTextFieldState();
}

class _ConstTextFieldState extends State<ConstTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyles.kCaption12RegularTextStyle
              .copyWith(color: AppColors.neutralBodyFont),
        ),
        SizedBox(
          height: widget.height1 == null ? 10 : widget.height,
        ),
        SingleChildScrollView(
          child: TextFormField(
            enabled: widget.isEnabled,
            controller: widget.controller,
            cursorHeight: 25,
            maxLines: widget.maxLine ?? 1,
            decoration: widget.decoration ?? InputDecoration(
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.neutralBorder,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.neutralBorder,
                      ),
                    ),
                    hintText: widget.hint,
                    hintStyle: AppTextStyles.kBody15RegularTextStyle
                        .copyWith(color: AppColors.neutral50)),
          ),
        ),
        SizedBox(
          height: widget.height ?? 10,
        )
      ],
    );
  }
}
