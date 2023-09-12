// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferanceClass {
  static String doUserLoggedIn = "doUserLoggedIn";

  static String idKey = "id";
  static String firstNameKey = "firstName";
  static String lastNameKey = "lastName";
  static String addressKey = "address";
  static String emailKey = "email";
  static String phoneKey = "phone";
  static String userImageKey = "userImage";
  static String accessTokenKey = "accessToken";
  static String storeIdKey = "storeId";
  static String storeNameKey = "storeName";
  static String moduleIdKey = "storeName";
  static String enableNotificationSoundKey = "notificationSound";
  static String isStoreOnlineKey = "isStoreOnline";

  static Future<bool> saveUserLoggedInSharedPreferace(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(doUserLoggedIn, isUserLoggedIn);
  }

  static Future<bool> saveUserDetails({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String accessToken,
    required String storeId,
    required String storeName,
    required String moduleId,
    required String addressPara,
    required String userImage,
    required String isStoreOnline,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(idKey, userId);
    await prefs.setString(firstNameKey, firstName);
    await prefs.setString(lastNameKey, lastName);
    await prefs.setString(emailKey, email);
    await prefs.setString(phoneKey, phone);
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(storeIdKey, storeId);
    await prefs.setString(storeNameKey, storeName);
    await prefs.setString(moduleIdKey, moduleId);
    await prefs.setString(addressKey, addressPara);
    await prefs.setString(userImageKey, userImage);
    await prefs.setString(isStoreOnlineKey, isStoreOnline);
    await setNotifiationSound(isSoundEnabled: true);
    return true;
  }

  static Future<bool> saveUpdatedStoreStatus({
    required String isStoreOnline,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(isStoreOnlineKey, isStoreOnline);
    return true;
  }

  static Future<Map<String, dynamic>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(idKey);
    String? firstName = prefs.getString(firstNameKey);
    String? lastName = prefs.getString(lastNameKey);
    String? email = prefs.getString(emailKey);
    String? phone = prefs.getString(phoneKey);
    String? accessToken = prefs.getString(accessTokenKey);
    String? storeId = prefs.getString(storeIdKey);
    String? storeName = prefs.getString(storeNameKey);
    String? moduleId = prefs.getString(moduleIdKey);
    String? address = prefs.getString(addressKey);
    String? userImage = prefs.getString(userImageKey);
    String? isStoreOnline = prefs.getString(isStoreOnlineKey);
    Map<String, dynamic> userDetailMap = {
      'userId': userId,
      "userType": firstName,
      "username": "$firstName $lastName",
      "email1": email,
      "phone1": phone,
      "accessToken": accessToken,
      "storeId": storeId,
      "storeName": storeName,
      "moduleId": moduleId,
      "address" : address,
      "userImage" : userImage,
      "isStoreOnline" : isStoreOnline,
    };
    return userDetailMap;
  }



  static Future<bool?> getDoUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(doUserLoggedIn);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  ///----------------------------
  static Future<bool?> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.remove(accessTokenKey);
  }

  static Future<bool?> remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    removeToken();
    await prefs.remove(idKey);
    await prefs.remove(firstNameKey);
    await prefs.remove(lastNameKey);
    await prefs.remove(emailKey);
    await prefs.remove(phoneKey);
    await prefs.remove(accessTokenKey);
    await prefs.remove(storeIdKey);
    await prefs.remove(storeNameKey);
    await prefs.remove(enableNotificationSoundKey);
    await prefs.remove(isStoreOnlineKey);
    return true;
  }
  
  /// notification services
  static Future<bool?> setNotifiationSound({required bool isSoundEnabled}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(enableNotificationSoundKey, isSoundEnabled);
  }
  static Future<bool> getNotifiationSound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(enableNotificationSoundKey)??false;
  }
}
