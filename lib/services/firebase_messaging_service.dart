// Dart imports:
import 'dart:async';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Project imports:
import 'package:aagyo/services/shared_preferance.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle incoming message when the app is in the background or terminated
  showNotification(message);
  print('Handling a background message: ${message.notification?.body}');
}

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  Future<void> initialize() async {
    await getDeviceToken();
    configureMessaging();
  }

  Future<String?> getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();
    print("-------------------------");
    print(token);
    return token;
  }

  Future<void> configureMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle incoming message when the app is in the foreground
      showNotification(message);
      print('Received message: ${message.notification?.body}');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when the user taps on a notification
      showNotification(message);

    });
  }




}
void showNotification(RemoteMessage message) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool isSoundEnabled = await SharedPreferanceClass.getNotifiationSound();
  var androidPlatformChannelSpecificsWithSound =  const AndroidNotificationDetails(
    'full',
    'high_importance_channel',
    enableLights: true,
    enableVibration: true,
    sound: RawResourceAndroidNotificationSound("notification"),//isSoundEnabled ? const RawResourceAndroidNotificationSound("notification") : null,
    playSound: true,
    icon: "@mipmap/ic_launcher",
    styleInformation: BigPictureStyleInformation(FilePathAndroidBitmap(
      "assets/splash/splash.bmp",
    ),
      hideExpandedLargeIcon: true,

    ),
    importance: Importance.high,
    priority: Priority.high,
  );
  var androidPlatformChannelSpecificsNoSound =  const AndroidNotificationDetails(
    'no_sounds',
    'high_importance_channel',
    enableLights: true,
    enableVibration: true,
    playSound: false,
    icon: "@mipmap/ic_launcher",
    styleInformation: BigPictureStyleInformation(FilePathAndroidBitmap(
      "assets/splash/splash.bmp",
    ),
      hideExpandedLargeIcon: true,

    ),
    importance: Importance.high,
    priority: Priority.high,
  );
  // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android:isSoundEnabled? androidPlatformChannelSpecificsWithSound
        :androidPlatformChannelSpecificsNoSound,
    // iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? '',
    message.notification?.body ?? '',
    platformChannelSpecifics,
  );
}
