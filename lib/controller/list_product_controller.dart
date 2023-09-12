// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/modal/add_new_variant_modal.dart';
import 'package:aagyo/modal/add_product_modal.dart';
import 'package:aagyo/modal/list_product_response_model.dart';
import '../modal/get_product_name_via_subcategory.dart';
import '../modal/sub_category_via_module_modal.dart';
import '../services/api_services.dart';
import '../services/core.dart';

class ListProductController extends GetxController {
  var isLoading = false.obs;
  var productViewList = [].obs;
  var temperoryList = [].obs; //for storing the current productList on searching
  var categoryList = [].obs;
  var subCategoryList = [].obs;
  var categoryModuleId = "0".obs;
  var totalStock = 0.obs; //variant stock total
  final categoryMap = {};
  final productNameImageMap = {}.obs;
  final subcategoryName = "Sub-Category".obs;

  final newVariantMapList = [].obs;
  final selectedProductImage = "".obs;
  final ApiService _apiService = ApiService();
  final isProductListFetched = false.obs;

  //for add products
  var productDetails = [].obs;
  var productWithIndexMap = {}.obs;
  var productCurrentIndex = 0.obs;
  var attributeList = [].obs;
  var unitList = [].obs;
  var unitAttributeList = {}.obs;

  //for discount finder
  var salePrice = 0.0.obs;
  var mrp = 0.0.obs;
  var discountPercentage = 0.0.obs;

  Future<void> getProductViewList() async {
    try {
      clearListAndVariables();
      isLoading(true);
      String storeId = await getStoreId();
      final result = await _apiService.getProduct(storeId);
      ProductModel? product = result;
      List<ProductDatum>? productList = product?.data?.data;
      // String variantDetails =  product?.data?.data?.variantDetails;
      //
      // getUnitList(variantDetails: productList.variantDetails??'');
      if (productList != null) {
        productViewList.value = product!.data!.data!;
        productList.map((product) {
          productNameImageMap[product.name] = product.imageUrl;
          //saving image and product name to productnameimagemap
        }).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCategoryList({required String moduleId}) async {
    try {
      isLoading(true);
      clearListAndVariables();

      String finalModuleId = moduleId;
      final result = await _apiService.getCategoryViaModule(finalModuleId);
      categoryList.value = result.data ?? [];
      if (categoryList.isNotEmpty) {
        categoryModuleId.value = categoryList[0].name ?? "0";
      }
      generateCategoryMap();
      getSubCategoryList();
      // setImageForProduct(productViewList[0].name);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSubCategoryList({String? subCategoryId}) async {
    try {
      // isLoading.value = true;
      subCategoryList.clear();
      isProductListFetched.value = false;

      String id =
          subCategoryId ?? categoryMap[categoryModuleId.value].toString();
      final result = await _apiService.getSubCategoryViaModule(id);
      List<SubCategoryData>? data = result?.data;
      if (data != null && data.isNotEmpty) {
        data.map((e) {
          subCategoryList.add({e.name: e.id});
        }).toList();
        //for getting value for product name intially
        getProductDetailsViaSubcategoryList(
            subCategoryName: data[0].name.toString());
      }
      // subCategoryList.value = result?.data ?? [];
    } finally {
      isLoading(false);
    }
  }

  Future<void> getProductDetailsViaSubcategoryList(
      {required String subCategoryName}) async {
    try {
      isLoading(true);

      productDetails.clear();

      subCategoryList.forEach((element) async {
        if (element.containsKey(subCategoryName)) {
          String selectedSubCategoryId = element[subCategoryName].toString();
          final result = await _apiService
              .getProductDetailsFromSubCategory(selectedSubCategoryId);
          List<ProductDetailDatum> data = result.data ?? [];
          List<UnitsWithAttribute> unitList = result.unitsWithAttributes ?? [];
          //picking unit attribute to seperate map
          //{"weight":["kg","mm"],"color":["bt","dd"]}
          getUnitList(unitList);
          if (data.isNotEmpty) {
            for (var element in data) {
              productWithIndexMap[element.name] = data.indexOf(element);
            }
            productCurrentIndex.value = 0;
            attributeList.value = result.unitsWithAttributes!;
          }
          productDetails.value = data;
          isProductListFetched.value = true;
        }
      });

      // isLoading(true);
    } finally {
      isLoading(false);
    }
  }

  void getUnitList(List<UnitsWithAttribute> unitList) {
    unitList.map((attribute) {
      final unitList = attribute.unit ?? [];
      if (unitList.isNotEmpty) {
        List<String> units = unitList.map((e) => e.name.toString()).toList();
        unitAttributeList[attribute.name] = units;
      } else {
        unitAttributeList[attribute.name] = [];
      }
    }).toList();
    if (unitList.isNotEmpty) {
      getUnitListForDropDown(attributeName: unitList[0].name ?? "");
    }
  }

  getUnitListForDropDown({required String attributeName}) {
    unitAttributeList.keys.map((key) {
      if (key == attributeName) {
        final returnList = unitAttributeList[key];
        unitList.value = returnList;
      }
    }).toList();
  }

  addNewVariant(AddNewVariantModal variant) {
    totalStock += int.parse(variant.stock.toString());
    newVariantMapList.add(variant.toJson());
  }

  editProduct({
    required ProductUpdateModal updatedValues,
  }) async {
    try {
      isLoading(true);
      String storeId = await getStoreId();
      // final result = await _apiService.updateProducts(storeId, updatedValues);
      // if (result == null) {
      //   getProductViewList();
      //
      //   Get.showSnackbar(const GetSnackBar(
      //     titleText: Text(
      //       "Action Failed",
      //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      //     ),
      //     messageText: Text(
      //       "Product Updation Failed",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     duration: Duration(seconds: 3),
      //     backgroundColor: Colors.grey,
      //     icon: Icon(
      //       Icons.add_alert,
      //       color: Colors.white,
      //     ),
      //   ));
      //   newVariantMapList.clear();
      // } else {
      //   Get.showSnackbar(const GetSnackBar(
      //     titleText: Text(
      //       "Updated",
      //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      //     ),
      //     messageText: Text(
      //       "Product Updated",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     duration: Duration(seconds: 3),
      //     backgroundColor: Colors.grey,
      //     icon: Icon(
      //       Icons.add_alert,
      //       color: Colors.white,
      //     ),
      //   ));
      // }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addProduct({
    required AddProductModal addProductModal,
  }) async {
    try {
      isLoading(true);
      String storeId = await getStoreId();
      final result =
          await _apiService.addProduct(addProductModal: addProductModal);
      if (result == null) {
        getProductViewList();

        Get.showSnackbar(const GetSnackBar(
          titleText: Text(
            "Action Failed",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          messageText: Text(
            "Can't add product",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
          icon: Icon(
            Icons.add_alert,
            color: Colors.white,
          ),
        ));
        newVariantMapList.clear();
        return false;
      } else {
        Get.showSnackbar(const GetSnackBar(
          titleText: Text(
            "Updated",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          messageText: Text(
            "Product Added",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
          icon: Icon(
            Icons.add_alert,
            color: Colors.white,
          ),
        ));
        return true;
      }
    } finally {
      isLoading(false);
    }
  }

  clearListAndVariables() {
    categoryList.clear();
    subCategoryList.clear();
  }

  enableOrDisableProduct({
    required String uniqueId,
  }) async {
    try {
      String storeId = await getStoreId();
      final result = await _apiService.enableOrDisableProduct(
          uniqueId: uniqueId, storeId: storeId);
      if (result == null) {
        getProductViewList();
 //todo: move the snack bar to core folder
        Get.showSnackbar(const GetSnackBar(
          titleText: Text(
            "Action Failed",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          messageText: Text(
            "Product Updation Failed",
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
        Get.showSnackbar(const GetSnackBar(
          titleText: Text(
            "Updated",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          messageText: Text(
            "Product Updated",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
          icon: Icon(
            Icons.add_alert,
            color: Colors.white,
          ),
        ));
      }
    } finally {
      isLoading(false);
    }
  }

  searchProducts({required String comparerValue}) async {
    if (productViewList.isEmpty) {
      await getProductViewList();
    }
    if (comparerValue.isNotEmpty) {
      productViewList.value = productViewList.where((item) {
        return item.name.toString().toLowerCase().startsWith(comparerValue);
      }).toList();
    } else {
      await getProductViewList();
    }
  }

  searchCategories({required String comparerValue,required String moduleId}) async {
    if (categoryList.isEmpty) {
      await getCategoryList(moduleId: moduleId);
    }
    if (comparerValue.isNotEmpty) {
      categoryList.value = categoryList.where((item) {
        return item.name.toString().toLowerCase().startsWith(comparerValue);
      }).toList();
    } else {
      await getCategoryList(moduleId: moduleId);
    }
  }

  setImageForProduct(String productName) {
    String productImage = productNameImageMap[productName];
    selectedProductImage.value = productImage;
  }

  void generateCategoryMap() {
    categoryList.map((e) {
      categoryMap[e.name] = e.id;
    }).toList();
  }

  getDiscountPercentage() {
    double tempSalePrice = salePrice.value;
    double tempMRP = mrp.value;
    double tempDiscountPercentage = ((tempMRP - tempSalePrice) / tempMRP) * 100;
    if (tempDiscountPercentage > 0) {
      discountPercentage.value = tempDiscountPercentage;
    } else {
      discountPercentage.value = 0.0;
    }
    print(discountPercentage.value);
  }

  clearDiscountRelatedData() {
    salePrice.value = 0.0;
    mrp.value = 0.0;
    discountPercentage.value = 0.0;
  }
}
