// Package imports:
import 'package:aagyo/services/shared_preferance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import '../services/api_services.dart';
import '../services/core.dart';

class OverviewController extends GetxController {
  var isLoading = false.obs;
  var selectedFilter = "Today".obs;
  var overViewList = [
    {"Orders": 0}.obs,
    {"Total Sales": 0}.obs,
    {"All Customers": 0},
    {"Total Products": 0},
  ].obs;
  final ApiService _apiService = ApiService();

  Future<void> updateOrderStatusLogic(
      {required String uniqueId, required String status}) async {
    try {
      isLoading(true);
      final result = await _apiService.updateOrderStatus(uniqueId, status);

      // statuses.value = result!.status!;
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateOrderStatusTimer(
      {required String uniqueId, required int time}) async {
    try {
      isLoading(true);
      DateTime currentTime = DateTime.now();
      final preparationTime = currentTime.add(Duration(minutes: time)).toString();
      final result = await _apiService.updateStatusTimer(uniqueId, preparationTime);


      // statuses.value = result!.status!;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getOverViewList({DateTime? startDate, DateTime? endDate}) async {
    try {
      isLoading(true);
      String storeId = await getStoreId();
      String formattedFromDate = "";
      String formattedToDate = "";
      switch (selectedFilter.value) {
        case 'Today':
          DateTime currentDate = DateTime.now();
          formattedFromDate = DateFormat('yyyy-MM-dd').format(currentDate);
          formattedToDate = DateFormat('yyyy-MM-dd').format(currentDate);
          break;

        case 'Yesterday':
          DateTime currentDate =
              DateTime.now().subtract(const Duration(days: 1));
          formattedFromDate = DateFormat('yyyy-MM-dd').format(currentDate);
          formattedToDate = DateFormat('yyyy-MM-dd').format(currentDate);
          break;

        case 'This Week':
          DateTime currentDate = DateTime.now();
          formattedFromDate = DateFormat('yyyy-MM-dd')
              .format(currentDate.subtract(const Duration(days: 7)));
          formattedToDate = DateFormat('yyyy-MM-dd').format(currentDate);
          break;

        default:
          if(startDate!=null&&endDate!=null){
            formattedFromDate = DateFormat('yyyy-MM-dd').format(startDate);
            formattedToDate = DateFormat('yyyy-MM-dd').format(endDate);
          }
      }
      if(formattedFromDate.isNotEmpty &&formattedToDate.isNotEmpty ){
        final result = await _apiService.getOverViewData(
            storeId: storeId,
            fromDate: formattedFromDate,
            toDate: formattedToDate);
        int totalSales = result?.overview?.totalSales ?? 0;
        int allCustomer = result?.overview?.allCustomers ?? 0;
        int totalOrders = result?.overview?.totalOrders ?? 0;
        int totalProducts = result?.overview?.totalProducts ?? 0;
        resetOverViewList();
        overViewList[0]["Orders"] = totalOrders;
        overViewList[1]["Total Sales"] = totalSales;
        overViewList[2]["All Customers"] = allCustomer;
        overViewList[3]["Total Products"] = totalProducts;
      }

    } finally {
      isLoading(false);
    }
  }

  Future<bool> updateStoreStatus({required bool currentStoreStatus}) async {
    String storeId = await getStoreId();
    final result = await _apiService.switchStoreStatus(storeId: storeId);
    if (result != null) {
      Get.showSnackbar(const GetSnackBar(
        titleText: Text(
          "Status Updated",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        messageText: Text(
          "Store Status Updation Completed",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        icon: Icon(
          Icons.add_alert,
          color: Colors.white,
        ),
      ));
      if (currentStoreStatus) {
        SharedPreferanceClass.saveUpdatedStoreStatus(isStoreOnline: '0');
        return true;
      } else {
        SharedPreferanceClass.saveUpdatedStoreStatus(isStoreOnline: '1');

        return false;
      }
    } else {
      Get.showSnackbar(const GetSnackBar(
        titleText: Text(
          "Action Failed",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        messageText: Text(
          "Store Status Updation Failed",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.add_alert,
          color: Colors.white,
        ),
      ));
      return false;
    }
  }

  void resetOverViewList() {
    overViewList[0]["Orders"] = 0;
    overViewList[1]["Total Sales"] = 0;
    overViewList[2]["All Customers"] = 0;
    overViewList[3]["Total Products"] = 0;
  }
}
