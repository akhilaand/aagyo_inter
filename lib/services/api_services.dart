// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:aagyo/const/network_strings.dart';
import 'package:aagyo/modal/add_product_modal.dart';
import 'package:aagyo/modal/add_story_modal.dart';
import 'package:aagyo/modal/category_via_module_modal.dart';
import 'package:aagyo/modal/list_category_response_modal.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import 'package:aagyo/modal/list_product_response_model.dart';
import 'package:aagyo/modal/overview_response_modal.dart';
import 'package:aagyo/modal/product_edit_model.dart';
import 'package:aagyo/modal/sub_category_via_module_modal.dart';
import 'package:aagyo/services/dio_extension.dart';
import 'package:aagyo/services/shared_preferance.dart';
import '../modal/add_new_variant_modal.dart';
import '../modal/get_product_name_via_subcategory.dart';
import '../modal/login_response_modal.dart';
import '../modal/update_order_status_model.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ApiService {
  Future<String> getAccessToken() async {
    final String? accessToken = await SharedPreferanceClass.getToken();
    return accessToken ?? "";
  }

  //login services
  Future<LoginResponseModal?> signIn(String credentials) async {
    final Dio dio = Dio();
    print(loginApi);
    final response = await dio.post(
      loginApi,
      data: {
        "login_id": credentials,
      },
    );
    print(response.data);
    try {
      if (response.statusCode == 200) {
        return LoginResponseModal.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        rethrow;
      }
    }
  }

  //home services

  Future<OverViewResponseModal?> getOverViewData({required String storeId,required String fromDate,required String toDate}) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
debugPrint("$overViewApi$storeId?start=$fromDate&end=$toDate");
    final response = await dio.get("$overViewApi$storeId?start=$fromDate&end=$toDate",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {

      return OverViewResponseModal.fromJson(response.data);
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        rethrow;
      }
    }
  }

  Future<OrderStatusUpdateModel?> updateOrderStatus(
      String uniqueId, String status) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    print("+++++++++++++++++++++++");
    print("$updateOrderStatusApi$uniqueId/$status");
    final response = await dio.get("$updateOrderStatusApi$uniqueId/$status",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {
      if (response.statusCode == 200) {
        return OrderStatusUpdateModel.fromJson(response.data);
      } else {
        OrderStatusUpdateModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        rethrow;
      }
    }
    return null;
  }

  Future<ListOrdersModal?> updateStatusTimer(
      String uniqueId, String time) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    debugPrint("$updateOrderStatusApi$time");
    final response = await dio.get("$productStatusTimerApi$uniqueId/$time",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));

    try {
      if (response.statusCode == 200) {
        return ListOrdersModal.fromJson(response.data);
      } else {
        return ListOrdersModal.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return ListOrdersModal.fromJson(response.data);
        rethrow;
      }
    }
  }

  Future<ListOrdersModal?> getOrders(String storeId, String orderStatus) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    // debugPrint("$listOrderApi$storeId/$orderStatus");
    final response = await dio.get("$listOrderApi$storeId/$orderStatus",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));

    try {
      if (response.statusCode == 200) {
        return ListOrdersModal.fromJson(response.data);
      } else {
        return ListOrdersModal.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return ListOrdersModal.fromJson(response.data);
        rethrow;
      }
    }
  }

  Future<Unit?> switchStoreStatus({required String storeId}) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    print("$updateStoreStatusApi$storeId");
    try {
      var response = await dio.get("$updateStoreStatusApi$storeId",
          options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
      if (response.statusCode == 200) {
        debugPrint("store status updated");
        return unit;
      } else {
        debugPrint("store status updation failed with status code ${response.statusCode}");

        return null;
      }
    } on DioException catch (e) {
      debugPrint("store status updation failed =>$e");

      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return null;
        rethrow;
      }
    }
  }

  // product services
  Future<ProductModel?> getProduct(String storeId) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    debugPrint("$listProductApi$storeId");
    final response = await dio.get("$listProductApi$storeId",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        return ProductModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return ProductModel.fromJson(response.data);
        rethrow;
      }
    }
  }

  Future<ProductEditModel?> postProductEdit(String storeId) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    debugPrint("$listProductApi$storeId");
    final response = await dio.post("$listProductApi$storeId",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {
      if (response.statusCode == 200) {
        return ProductEditModel.fromJson(response.data);
      } else {
        return ProductEditModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        rethrow;
      }
    }
  }

  // category services
  Future<CategoryViaModuleModal> getCategoryViaModule(String moduleId) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    debugPrint("$getCategoryViaModuleApi/$moduleId");
    final response = await dio.get("$getCategoryViaModuleApi/$moduleId",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {
      if (response.statusCode == 200) {
        return CategoryViaModuleModal.fromJson(response.data);
      } else {
        return CategoryViaModuleModal.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return CategoryViaModuleModal.fromJson(response.data);
        rethrow;
      }
    }
  }

  Future<SubCategoryViaModuleModal?> getSubCategoryViaModule(
      String categoryId) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    final response = await dio.get("$getSubCategoryViaModuleApi/$categoryId",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {
      if (response.statusCode == 200) {
        return SubCategoryViaModuleModal.fromJson(response.data);
      } else {
        return SubCategoryViaModuleModal.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return SubCategoryViaModuleModal.fromJson(response.data);
        rethrow;
      }
    }
  }

  Future<GetProductDetailsFromSubCategoryModal>
      getProductDetailsFromSubCategory(String subCategoryId) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    print("$getProductDetailsFromSubCategoryIdApi/$subCategoryId");
    final response = await dio.get(
        "$getProductDetailsFromSubCategoryIdApi/$subCategoryId",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {
      if (response.statusCode == 200) {
        return GetProductDetailsFromSubCategoryModal.fromJson(response.data);
      } else {
        return GetProductDetailsFromSubCategoryModal.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return GetProductDetailsFromSubCategoryModal.fromJson(response.data);
        rethrow;
      }
    }
  }

  Future<Unit?> enableOrDisableProduct(
      {required String uniqueId, required String storeId}) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    print("$enableOrDisableProductApi/$storeId/$uniqueId");
    try {
      var response = await dio.get(
          "$enableOrDisableProductApi/$storeId/$uniqueId",
          options: Options(headers: {"Authorization": "Bearer $acceptToken"}));

      return unit;
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return null;
        rethrow;
      }
    }
  }

  Future<ListCategoryResponseModal> getCategories(String storeId) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    final response = await dio.get("$listCategoryApi$storeId",
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {
      if (response.statusCode == 200) {
        return ListCategoryResponseModal.fromJson(response.data);
      } else {
        return ListCategoryResponseModal.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return ListCategoryResponseModal.fromJson(response.data);
        rethrow;
      }
    }
  }

  Future<Unit?> updateProducts(
      String storeId, ProductUpdateModal updatedValues) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    var date = DateTime.now();
    String json = jsonEncode(updatedValues.variantDetails);
    final response = await dio.post(
        "$editProductApi/$storeId/${updatedValues.productId}",
        data: {
          "stock": updatedValues.stock,
          "tag": updatedValues.tag,
          "startTime": DateTime.now().toString(),
          "endTime": DateTime(date.year, date.month, date.day + 3).toString(),
          "variantDetails": json,
        },
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    try {
      if (response.statusCode == 200) {
        return unit;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return null;
        rethrow;
      }
    }
  }

  Future<Unit?> addProduct({required AddProductModal addProductModal}) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    FormData data = FormData.fromMap({
      "name": addProductModal.name,
      "user_id": addProductModal.userId,
      "module_id": addProductModal.moduleId,
      "store_id": addProductModal.storeId,
      "category_id": addProductModal.categoryId,
      "subCategory_id": addProductModal.subCategoryId,
      "attribute_id": addProductModal.attributeId,
      "lib_product_id": addProductModal.libProductId,
      "veg": addProductModal.isVeg, //Y,N
      "description": addProductModal.description,
      "stock": addProductModal.stock,
      "tag": addProductModal.tag,
      "startTime": addProductModal.startTime,
      "endTime": addProductModal.endTime,
      "image": await MultipartFile.fromFile(addProductModal.image!.path,
          filename: addProductModal.image?.path.split('/').last),
    });

    final response = await dio.post(addProductApi,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    print("product addeddd----------------------------");

    try {
      if (response.statusCode == 200) {
        return unit;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print("error occureeddd");
        return null;
        rethrow;
      }
    }
  }

  Future<Unit?> addStory(AddStoryModal addStoryModal) async {
    final Dio dio = Dio();
    String acceptToken = await getAccessToken();
    FormData data = FormData.fromMap({
      "title": addStoryModal.title,
      "thumbnail": await MultipartFile.fromFile(addStoryModal.thumbnail!.path,
          filename: addStoryModal.thumbnail?.path.split('/').last),
      "Type": addStoryModal.type,
      "video_img": await MultipartFile.fromFile(addStoryModal.videoImage!.path,
          filename: addStoryModal.videoImage?.path.split('/').last),
    });
    final response = await dio.post("$addStoryApi/${addStoryModal.storeId}",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $acceptToken"}));
    print(response.data);
    try {
      if (response.statusCode == 200) {
        return unit;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.isNoConnectionError) {
        debugPrint("No network connection available.");
        rethrow;
      } else {
        print(response.data);

        return null;
        rethrow;
      }
    }
  }
}
