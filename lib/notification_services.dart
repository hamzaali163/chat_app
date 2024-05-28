import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void requestpermissions() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('Permission Granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('provisional status');
    } else {
      debugPrint('permissions denied');
    }
  }

  Future<String> getdevicetoken() async {
    String? token = await firebaseMessaging.getToken();
    print(token);
    return token!;
  }

  void istokenrefresh() async {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void firebaseinit() async {
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
    });
  }
}
