// import 'package:get/get.dart';
//
// import '../services/api_services.dart';
//
// class UpdateOrderStatusController extends GetxController{
//   var isLoading = false.obs;
//   final ApiService _apiService = ApiService();
//   Future<void> updateOrderStatusLogic({required String uniqueId,required String status}) async {
//     try {
//       isLoading(true);
//       final result = await _apiService.updateOrderStatus(uniqueId,status);
//       // statuses.value = result!.status!;
//     } finally {
//       isLoading(false);
//     }
//   }
// }