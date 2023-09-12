// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aagyo/services/shared_preferance.dart';
import 'package:url_launcher/url_launcher.dart';
import '../modal/varient_modal.dart';

Future<String> getUserId() async {
  final userDetails = await SharedPreferanceClass.getUserDetails();
  return userDetails["userId"];
}

Future<String> getStoreId() async {
  final userDetails = await SharedPreferanceClass.getUserDetails();
  return userDetails["storeId"];
}

Future<String> getModuleId() async {
  final userDetails = await SharedPreferanceClass.getUserDetails();
  return userDetails["moduleId"];
}

Future<String> getUserImage() async {
  final userDetails = await SharedPreferanceClass.getUserDetails();
  return userDetails["userImage"];
}

Future<bool> isStoreOnline() async {
  final userDetails = await SharedPreferanceClass.getUserDetails();
  String isStoreOnline = userDetails["isStoreOnline"];
  return isStoreOnline=="1"?true:false;
}

Future getUserDetails() async {
  final userDetails = await SharedPreferanceClass.getUserDetails();
  return userDetails;
}

Future<bool> isNotificationSoundEnabled() async {
  final isEnabled = await SharedPreferanceClass.getNotifiationSound();
  return isEnabled;
}

String convertTo24HourFormat(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final format24Hour = DateFormat.Hms();
  return format24Hour.format(dateTime);
}

List<VarientModal> getDecodedVariantDetails({required String variantDetails}) {
  try{
    List jsonDecodedVariantList = jsonDecode(variantDetails);
    List<VarientModal> varientList = jsonDecodedVariantList
        .map((varient) => VarientModal.fromJson(varient))
        .toList();
    return varientList;
  }catch(e){
    return [];
  }

}

Future<File?> pickImage(ImageSource source) async {
  final pickedFile = await ImagePicker().pickImage(source: source);

  if (pickedFile != null) {
    return File(pickedFile.path);
      // _selectedPhotos.add(File(pickedFile.path));
  }
  return null;}

launchCaller({required String phoneNumber}) async {
  const url = "1234567890";
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: url,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $url';
  }
}

extension StringExtension on String {
  String removeParanthesis() {
    return replaceAll('(', '').replaceAll(')', '');
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addHour(int hour) {
    return replacing(hour: this.hour + hour, minute: minute);
  }
}
