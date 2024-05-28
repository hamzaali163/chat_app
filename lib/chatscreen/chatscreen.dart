import 'dart:convert';

import 'package:chat_app/auth/welcome_screen.dart';
import 'package:chat_app/chatscreen/chatmessage.dart';
import 'package:chat_app/chatscreen/new_messages.dart';
import 'package:chat_app/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  NotificationServices notificationServices = NotificationServices();
  // void setuppushnotifications() async {
  //   // final fcm = FirebaseMessaging.instance;

  //   // await fcm.requestPermission();
  //   final token = await fcm.getToken().then((value) async {
  //     var data = {
  //       'to': value.toString(),
  //       'priority': 'high',
  //       'notification': {
  //         'title': 'Hello',
  //         'body': 'Subscribe to my channel',
  //         "sound": "jetsons_doorbell.mp3"
  //       },
  //       'android': {
  //         'notification': {
  //           'notification_count': 23,
  //         },
  //       },
  //       'data': {'type': 'msj', 'id': 'Asif Taj'}
  //     };

  //     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         body: jsonEncode(data),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'Authorization':
  //               'key=AAAAGDBRcUs:APA91bEP93m6nCBZGy4AOTZJOhJmp2IZNJMIqc1EuXOJQPmqtseMhnZ-xFACBxGKx11sJE-fr3yGvVaYttUDTmjbVIUoSdpvNEij3YR_zFZsK3-yGL9k_mY3GpOiyrSzHv-qODiESuAg'
  //         }).then((value) {
  //       if (kDebugMode) {
  //         print('success');
  //       }
  //     }).onError((error, stackTrace) {
  //       if (kDebugMode) {
  //         print('error');
  //         print(error);
  //       }
  //     });
  //   });

  //   debugPrint('token');
  //   debugPrint(token);
  //   fcm.subscribeToTopic('chat');
  // }

  @override
  void initState() {
    super.initState();
    // setuppushnotifications();
    notificationServices.requestpermissions();
    notificationServices.firebaseinit();
    notificationServices.istokenrefresh();
    notificationServices.getdevicetoken().then((value) async {
      var data = {
        'to':
            'fFax5R9JRk2yRvs0WG410U:APA91bFohJXCrdd2h4uMlMVCuToyjf7QuWVWtQ2uu_1jIyZZWIiHzR6Dz_PceFaoOOlOpOSKYP164t09Ojopai0XTbfMoSUCGjwa6-BKwvbHclwbmNWVu7EzePU-t2nHkS4rnQ9T4fPC',
        'priority': 'high',
        'notification': {
          'title': 'Hello',
          'body': 'Welcome to chat app',
          "sound": "jetsons_doorbell.mp3"
        },
        'android': {
          'notification': {
            'notification_count': 23,
          },
        },
        'data': {'type': 'msj', 'id': 'Asif Taj'}
      };

      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAAGDBRcUs:APA91bEP93m6nCBZGy4AOTZJOhJmp2IZNJMIqc1EuXOJQPmqtseMhnZ-xFACBxGKx11sJE-fr3yGvVaYttUDTmjbVIUoSdpvNEij3YR_zFZsK3-yGL9k_mY3GpOiyrSzHv-qODiESuAg'
          }).then((value) {
        if (kDebugMode) {
          print('success');
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('error');
          print(error);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  // setuppushnotifications();
                },
                icon: Icon(Icons.abc_outlined)),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: const Column(
          children: [Expanded(child: ChatMessage()), NewMessages()],
        ),
      ),
    );
  }
}
