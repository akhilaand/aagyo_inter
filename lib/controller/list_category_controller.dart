// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/modal/list_category_response_modal.dart';
import '../services/api_services.dart';
import '../services/core.dart';

class ListCategoryController extends GetxController {
  var isLoading = false.obs;
  var categoryList = [].obs;
  final ApiService _apiService = ApiService();

  Future<void> getCategoryList() async {
    try {
      isLoading(true);
      String storeId = await getStoreId();
      final result = await _apiService.getCategories(storeId);
      ListCategoryResponseModal? product = result;
      if(product.data?.data != null) {
        categoryList.value = product.data!.data!;
      }

    } finally {
      isLoading(false);
    }
  }

  searchCategories({required String comparerValue}) async {
    if (categoryList.isEmpty) {
      await getCategoryList();
    }
    if (comparerValue.isNotEmpty) {
      categoryList.value = categoryList.where((item) {
        return item.name.toString().toLowerCase().startsWith(comparerValue);
      }).toList();
    } else {
      await getCategoryList();
    }
  }

}
