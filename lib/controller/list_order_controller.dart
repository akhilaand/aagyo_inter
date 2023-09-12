// Flutter imports:

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/const/constString.dart';
import 'package:aagyo/modal/list_order_modal.dart';
import '../services/api_services.dart';
import '../services/core.dart';

class ListOrderController extends GetxController {
  var isLoading = false.obs;
  var pendingOrderCount = 0.obs;
  var acceptedOrderCount = 0.obs;
  var pickedUpOrderCount = 0.obs;
  var onTheWayOrderCount = 0.obs;
  var deliveredOrderCount = 0.obs;
  var rejectedOrderCount = 0.obs;

  var pendingOrderList = [].obs;
  var acceptedOrderList = [].obs;
  var pickedUpOrderList = [].obs;
  var onTheWayOrderList = [].obs;
  var deliveredOrderList = [].obs;
  var rejectedOrderList = [].obs;
  final ApiService _apiService = ApiService();

  Future<void> getOrdersList() async {
    try {
      isLoading(true);
      String storeId = await getStoreId();
      addOrdersToList(pending, storeId);
      addOrdersToList(accepted, storeId);
      addOrdersToList(pickedUp, storeId);
      addOrdersToList(orderOnTheWay, storeId);
      addOrdersToList(delivered, storeId);
      addOrdersToList(rejected, storeId);
    } finally {
      isLoading(false);
    }
  }

  void addOrdersToList(String orderStatus, String storeId) async {
    if (orderStatus == accepted) {
      final orders =
          await getOrderList(orderStatus: accepted, storeKey: storeId);
      acceptedOrderCount.value = orders.length;
      acceptedOrderList.value = orders;
    } else if (orderStatus == pending) {
      final orders =
          await getOrderList(orderStatus: pending, storeKey: storeId);
      pendingOrderCount.value = orders.length;
      pendingOrderList.value = orders;
    } else if (orderStatus == orderOnTheWay) {
      final orders =
          await getOrderList(orderStatus: orderOnTheWay, storeKey: storeId);
      onTheWayOrderCount.value = orders.length;
      onTheWayOrderList.value = orders;
    } else if (orderStatus == delivered) {
      final orders =
          await getOrderList(orderStatus: delivered, storeKey: storeId);
      deliveredOrderCount.value = orders.length;
      deliveredOrderList.value = orders;
    } else if (orderStatus == rejected) {
      final orders =
          await getOrderList(orderStatus: rejected, storeKey: storeId);
      rejectedOrderCount.value = orders.length;
      rejectedOrderList.value = orders;
    } else if (orderStatus == pickedUp) {
      final orders =
          await getOrderList(orderStatus: pickedUp, storeKey: storeId);
      pickedUpOrderCount.value = orders.length;
      pickedUpOrderList.value = orders;
    }
  }

  Future<List<Datum>> getOrderList(
      {required String orderStatus, required String storeKey}) async {
    final result = await _apiService.getOrders(storeKey, orderStatus);
    ListOrdersModal? orders = result;
    final orderData = orders?.data?.data;
    if (orderData != null) {
      return orderData;
    }
    return [];
  }
}
