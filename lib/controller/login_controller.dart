// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:aagyo/modal/login_response_modal.dart';
import 'package:aagyo/services/shared_preferance.dart';
import '../services/api_services.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final ApiService _apiService = ApiService();
  LoginResponseModal? loginResponseModal;

  Future<LoginResponseModal?> loginUser(String credentials) async {
    try {
      isLoading(true);
      final result = await _apiService.signIn(credentials);
      if (result!=null&&result.status==1) {
        await SharedPreferanceClass.saveUserDetails(
            userId: (result.data.id).toString(),
            firstName: result.data.fName,
            lastName: result.data.lName,
            email: result.data.email,
            addressPara: result.data.store.address,
            phone: (result.data.phone).toString(),
            accessToken: result.data.accessToken,
            storeId: (result.data.store.id).toString(),
            storeName: result.data.store.name,
            userImage: result.data.store.logoUrl,
            moduleId:( result.data.store.moduleId).toString(),
            isStoreOnline: result.data.store.status,
        );

        SharedPreferanceClass.saveUserLoggedInSharedPreferace(true);

        return result;
      } else {
        print("invalid credentials");
        return null;
      }
    } finally {
      isLoading(false);
    }
  }
}
