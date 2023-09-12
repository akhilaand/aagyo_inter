// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/modal/add_story_modal.dart';
import 'package:aagyo/services/api_services.dart';

class AddStoryController extends GetxController{
var isLoading = false.obs;
final ApiService _apiService = ApiService();
Future<bool> addStory({required AddStoryModal addStoryModal})async{
  try{
    isLoading(true);
    final result = await _apiService.addStory(addStoryModal);
    if (result == null) {
      Get.showSnackbar( const GetSnackBar(
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
  } finally{
    isLoading(false);

  }
}
}
