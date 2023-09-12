// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:aagyo/landingpage/dashboard/auth/views/welcomeScreen.dart';
import 'package:aagyo/landingpage/dashboard/bottomnavbar.dart';
import 'package:aagyo/services/api_services.dart';
import 'package:aagyo/services/firebase_messaging_service.dart';
import 'package:aagyo/services/shared_preferance.dart';
import 'landingpage/dashboard/auth/controllers/auth_controller.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const InitializationSettings initializationSettings = InitializationSettings(
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  FirebaseMessagingService messagingService = FirebaseMessagingService();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await messagingService.initialize();
  Get.put(AuthControllerNew());
  Get.put(AuthController());
  // await MyShared_Pref.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const SplashScreens(),
      builder: EasyLoading.init(),
    );
  }
}

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();
    // Wait for 2 seconds before showing the second splash screen
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        // Change the state to display the second splash screen
        // _showSecondSplashScreen = true;
      });
      // Wait for 2 more seconds before navigating to the homepage
      Future.delayed(const Duration(seconds: 2), () async {
        final prefs = await SharedPreferences.getInstance();
        final userid = prefs.getString("userId");
        bool doUserLoggedIn = await checkLoggedIn();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => doUserLoggedIn
                  ? const Bottom_Page()
                  : const WelcomeScreen()), //OnBoarding
        );
      });
    });
  }

  final bool _showSecondSplashScreen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
               Scaffold(
            body: Center(
              child: Image.asset('assets/splash/splash.png',height:100,width: 100,),
            ),
          )
            ),
    );
  }

  Future<bool> checkLoggedIn() async {
    bool? returnValue = await SharedPreferanceClass.getDoUserLoggedIn();
    return returnValue ?? false;
  }
}
