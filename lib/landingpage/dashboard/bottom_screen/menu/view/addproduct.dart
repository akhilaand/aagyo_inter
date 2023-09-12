// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// Project imports:
import 'package:aagyo/colors/colors_const.dart';
import 'package:aagyo/const/constContainer.dart';
import 'package:aagyo/controller/list_product_controller.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/add/view/varietyTextfild.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/add/widgets/constswitch.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/widgets/constdropdown.dart';
import 'package:aagyo/landingpage/dashboard/bottom_screen/menu/widgets/varient_list_view.dart';
import 'package:aagyo/modal/add_product_modal.dart';
import 'package:aagyo/modal/varient_modal.dart';
import 'package:aagyo/services/core.dart';
import 'package:aagyo/styles/textstyle_const.dart';
import '../../../../../modal/get_product_name_via_subcategory.dart';

//TODO:TRY BY CHANGING TO STATELESS
class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _selectedImage;
  bool showListView = false;
  final productController = Get.put(ListProductController());
  //for varient
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController taxController = TextEditingController();

  String categoryName = "";
  String subCategoryValue = "";
  String productName = "";
  bool isVeg = true;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));

  bool textFieldUpdated = false;

  Future<DateTime?> showDateTimePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    return picked;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      productController.clearListAndVariables();
      await productController.getCategoryList(moduleId: "1");
      // initializeTextController();
    });
  }

  //for default isProductEmpty is false but when productList gets empty value will be passed as true
  void initializeTextController() {
    final product = productController.productDetails;
    final index = int.parse(productController.productCurrentIndex.toString());
    if (product.isNotEmpty && productController.subCategoryList.isNotEmpty) {
      productNameController.text = product[index].name;
      descriptionController.text = product[index].description;
      tagsController.text = product[index].tag;
      startTime =
          convertStringToTimeOfDay(timeString: product[index].startTime);
      endTime = convertStringToTimeOfDay(timeString: product[index].endTime);
    } else if (productController.subCategoryList.isEmpty || product.isEmpty) {
      productNameController.clear();
      descriptionController.clear();
      tagsController.clear();
      startTime = TimeOfDay.now();
      endTime =
          TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));
    } else {
      productNameController.text = "";
      startTime = TimeOfDay.now();
      endTime =
          TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));
    }
    textFieldUpdated = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    Get.delete<ListProductController>();
    textFieldUpdated = true;
  }

  TimeOfDay convertStringToTimeOfDay({required String timeString}) {
    List<String> timeComponents = timeString.split(":");
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);
    int seconds = int.parse(timeComponents[2]);

    TimeOfDay timeOfDay = TimeOfDay(hour: hours, minute: minutes);
    return timeOfDay;
  }

  @override
  Widget build(BuildContext context) {
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
            "Add Product",
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
          if (!textFieldUpdated &&
              productController.productDetails.isNotEmpty) {
            initializeTextController();
          } else if (!textFieldUpdated &&
              productController.isProductListFetched.value) {
            initializeTextController();
          }
          // if (product.isNotEmpty) {
          // final selectedIndex = int.parse(productController.productCurrentIndex.toString());
          // print("selected index is $selectedIndex");
          // print("selected index is ${productController.productWithIndexMap}");
          // productNameController.text = product[selectedIndex].name;
          // }

          return ModalProgressHUD(
            inAsyncCall: productController.isLoading.value,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: productController.categoryList.isNotEmpty,
                        child: ConstDropDown(
                          name: "Category",
                          itemList: getCategoryNameList(
                              productController.categoryList),
                          dropDownInitialValue:
                              productController.categoryList.isNotEmpty
                                  ? productController.categoryList.map((e) {
                                      return e.name.toString();
                                    }).toList()[0]
                                  : "",
                          onChanged: (value) async {
                            productController.categoryModuleId.value = value;
                            //TODO: CODE REVIEW REQUIRED
                            // Here we are using setstate for updating ui,try removing the setstate and run the application,then try to solve without setstate
                            await productController
                                .getSubCategoryList()
                                .then((value) {
                              setState(() {
                                textFieldUpdated = false;
                              });
                            });

                            // initializeTextController();
                          },
                        ),
                      ),
                      Visibility(
                        visible: productController.subCategoryList.isNotEmpty,
                        child: ConstDropDown(
                          name: "Sub Category",
                          itemList: productController.subCategoryList
                              .map((element) =>
                                  element.keys.toString().removeParanthesis())
                              .toList(),
                          dropDownInitialValue:
                              productController.subCategoryList.isNotEmpty
                                  ? productController.subCategoryList
                                      .map((element) => element.keys
                                          .toString()
                                          .removeParanthesis())
                                      .toList()[0]
                                  : "",
                          onChanged: (value) async {
                            await productController
                                .getProductDetailsViaSubcategoryList(
                                    subCategoryName: value)
                                .then((value) {
                              setState(() {
                                textFieldUpdated = false;
                              });
                            });

                            // subCategoryValue = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //TODO:uncomment this once product detail completed
                      Visibility(
                          visible:
                              productController.productDetails.isNotEmpty &&
                                  productController.subCategoryList.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //TODO: CODE REVIEW REQUIRED
                              ConstDropDown(
                                  name: "Search Your Product name",
                                  itemList: productController.productDetails
                                      .map((element) => element.name.toString())
                                      .toList(),
                                  dropDownInitialValue: productController
                                          .productDetails.isNotEmpty
                                      ? productController.productDetails
                                          .map((element) {
                                          // !textFieldUpdated?initializeTextController():null;
                                          return element.name.toString();
                                        }).toList()[0]
                                      : "",
                                  onChanged: (value) {
                                    textFieldUpdated = false;

                                    productName = value;
                                    productController.productWithIndexMap
                                        .forEach((k, v) {
                                      if (k == value) {
                                        productController.productCurrentIndex
                                            .value = int.parse(v.toString());
                                      }
                                    });
                                    !textFieldUpdated
                                        ? initializeTextController()
                                        : null;

                                    // productController
                                    //     .getProductDetailsViaSubcategoryList(
                                    //   subCategoryName: value,
                                    // );
                                    // productController.setImageForProduct(value);
                                  }),
                            ],
                          )),
                      //below commented code is for showing images from db when data is fetched from subprosuct list
                      // Visibility(
                      //   visible: productController.productDetails.isNotEmpty &&
                      //       productController.subCategoryList.isNotEmpty,
                      //   child: Padding(
                      //       padding: const EdgeInsets.only(left: 8.0),
                      //       child: FadeInImage.assetNetwork(
                      //           placeholder:
                      //               "assets/add/icons/image_loading.png",
                      //           height: 60,
                      //           width: 60,
                      //           image:
                      //               productController.productDetails.isNotEmpty
                      //                   ? productController
                      //                       .productDetails[int.parse(
                      //                           productController
                      //                               .productCurrentIndex
                      //                               .toString())]
                      //                       .image
                      //                   : "")),
                      // ),
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            Container(
                                height: 150,
                                color: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    TextButtons(
                                      text: "Upload From Camera",
                                      onPressed: () async {
                                        File? image =
                                            await pickImage(ImageSource.camera);
                                        if (image != null) {
                                          setState(() {
                                            _selectedImage = image;
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButtons(
                                      text: "Upload From Gallery",
                                      onPressed: () async {
                                        File? image = await pickImage(
                                            ImageSource.gallery);
                                        if (image != null) {
                                          setState(() {
                                            _selectedImage = image;
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )),
                            isDismissible: true,
                          );
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey.shade400,
                          child: getImageContainer(),
                        ),
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
                        controller: tagsController,
                        title: 'Tags',
                        hint: 'Add tags related to product',
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ConstTextField(
                                controller: taxController,
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
                            callBack: (bool value) {
                              isVeg = value;
                            },
                          )
                        ],
                      ),
                      TextButton(
                          onPressed: () async {
                            final selectedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );
                            if (selectedTime != null) {
                              setState(() {
                                startTime = selectedTime;
                              });
                            }
                          },
                          child: Text(
                            'Start Time : ${startTime.format(context).toString()}',
                            style: const TextStyle(color: Colors.blue),
                          )),
                      TextButton(
                          onPressed: () async {
                            final selectedTime = await showTimePicker(
                              initialTime: TimeOfDay.fromDateTime(
                                  DateTime.now().add(const Duration(hours: 3))),
                              context: context,
                            );
                            if (selectedTime != null) {
                              setState(() {
                                endTime = selectedTime;
                              });
                            }
                          },
                          child: Text(
                            'End Time : ${endTime.format(context).toString()}',
                            style: const TextStyle(color: Colors.blue),
                          )),

                      Visibility(
                        visible: productNameController.text.isNotEmpty,
                        child: VarientListView(
                            widget: widget,
                            varientList: productNameController.text.isEmpty
                                ? []
                                : getDecodedVariantDetails(
                                    variantDetails: getVarientDetails(
                                        productController.productDetails)

                                    // productController.productDetails
                                    //     .map((variantMap) {
                                    //       if(productNameController.text==variantMap.name){
                                    //         print(variantMap.name);
                                    //         return variantMap.variantDetails;
                                    //       }
                                    //       print(variantMap.variantDetails);
                                    //
                                    //     }).toList().toString()

                                    )),
                      ),
                      VarientListView(
                        widget: const AddProduct(),
                        varientList: productController.newVariantMapList
                            .map((variantMap) =>
                                VarientModal.fromJson(variantMap))
                            .toList(),
                      ),
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
                                variantDetails: getVarientDetails(
                                    productController.productDetails)),
                            attributeList: productController.attributeList,
                            unitList: productController.unitList.cast<String>()
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
                          final product = productController.productDetails;
                          int index =
                              (productController.productCurrentIndex.toInt());
                          final userId = await getUserId();
                          final moduleId = await getModuleId();
                          final storeId = await getStoreId();
                          final categoryId = product[index].categoryId;
                          final subCategoryId = product[index].subCategoryId;
                          final attributeId = product[index].attributeId;
                          final libProductId = product[index].id;
                          final image = _selectedImage;
                          final stock = product[index].stock;
                          final jsonEncodedVariantList =
                              jsonEncode(productController.newVariantMapList);
                          AddProductModal addProductModal = AddProductModal(
                              name: productNameController.text,
                              userId: userId,
                              moduleId: moduleId,
                              storeId: storeId,
                              categoryId: categoryId.toString(),
                              subCategoryId: subCategoryId.toString(),
                              attributeId: attributeId.toString(),
                              libProductId: libProductId.toString(),
                              isVeg: isVeg ? "Y" : "N",
                              description: descriptionController.text,
                              image: image,
                              stock: stock,
                              tag: tagsController.text,
                              startTime: convertTo24HourFormat(startTime),
                              endTime: convertTo24HourFormat(endTime),
                              // endTime: endTime.format(context).toString(),
                              variantDetails: jsonEncodedVariantList);
                          final isProductAdded = await productController
                              .addProduct(addProductModal: addProductModal);
                          if (isProductAdded) {
                            if (!mounted) return;
                            Navigator.of(context).pop();
                          }
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
                ],
              ),
            ),
          );
        }));
  }

   getImageContainer() {
    if(_selectedImage == null &&
        (productController.productDetails.isNotEmpty &&
            productController.subCategoryList.isNotEmpty)){
      return FadeInImage.assetNetwork(
          placeholder: "assets/add/icons/image_loading.png",
          height: 60,
          width: 60,
          fit: BoxFit.fill,
          image: productController.productDetails.isNotEmpty
              ? productController
              .productDetails[int.parse(
              productController.productCurrentIndex.toString())]
              .image
              : "");
    }else if(_selectedImage!=null){
      return Image.file(_selectedImage!, fit: BoxFit.fill);
    }else{
      return const Center(child: Icon(Icons.downloading),);
    }
  }

  List<String> getUnitList(ProductDetailDatum product) {
    List<String>? result = product.unit?.map((e) => e.name.toString()).toList();
    return result ?? [];
  }

  String getVarientDetails(List productDetails) {
    String returnString = "";
    for (ProductDetailDatum item in productDetails) {
      if (item.name == productNameController.text) {
        returnString = item.variantDetails ?? "";
      }
    }
    return returnString;
  }
}

class TextButtons extends StatelessWidget {
  final String text;
  final Function onPressed;
  const TextButtons({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConstTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final int? maxLine;
  final InputDecoration? decoration;
  final double? height;
  final double? height1;
  const ConstTextField(
      {Key? key,
      required this.title,
      required this.controller,
      required this.hint,
      this.decoration,
      this.maxLine,
      this.height,
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
            controller: widget.controller,
            cursorHeight: 25,
            maxLines: widget.maxLine ?? 1,
            decoration: widget.decoration ??
                InputDecoration(
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

class ProductConst extends StatefulWidget {
  final String label;
  final String name;
  const ProductConst({Key? key, required this.label, required this.name})
      : super(key: key);

  @override
  State<ProductConst> createState() => _ProductConstState();
}

class _ProductConstState extends State<ProductConst> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        controller: controller..text = widget.name,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.neutralBorder, width: 1)),
            focusedBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.neutralBorder, width: 1)),
            enabledBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.neutralBorder, width: 1)),
            labelText: widget.label,
            labelStyle: AppTextStyles.kBody15RegularTextStyle),
      ),
    );
  }
}
