import 'dart:convert';

import 'package:chat_app/notification_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  TextEditingController messagecontroller = TextEditingController();
  final id = FirebaseAuth.instance.currentUser!.uid;
  var timeday;

  NotificationServices notificationServices = NotificationServices();
  var name;
  var message;

  @override
  void getdata() async {}

  void pushnotifications() async {
    notificationServices.requestpermissions();
    notificationServices.firebaseinit();
    // notificationServices.istokenrefresh();
    final firestore =
        await FirebaseFirestore.instance.collection('user data').doc(id).get();
    name = firestore.data()!['name'];

    final messagedata = await FirebaseFirestore.instance
        .collection('messages')
        .doc(timeday)
        .get();

    message = messagedata.data()!['text'];

    debugPrint('device tok');
    debugPrint(message);
    var data = {
      'to':
          'fFax5R9JRk2yRvs0WG410U:APA91bFohJXCrdd2h4uMlMVCuToyjf7QuWVWtQ2uu_1jIyZZWIiHzR6Dz_PceFaoOOlOpOSKYP164t09Ojopai0XTbfMoSUCGjwa6-BKwvbHclwbmNWVu7EzePU-t2nHkS4rnQ9T4fPC',
      'priority': 'high',
      'notification': {
        'title': name,
        'body': message,
        "sound": "jetsons_doorbell.mp3"
      },
      'android': {
        'notification': {
          'notification_count': 23,
        },
      },
      'data': {'type': 'msj', 'id': 'Hamza Ali'}
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
  }

  void initState() {
    super.initState();
    getdata();
  }

  void dispose() {
    messagecontroller.dispose();
    super.dispose();
  }

  void sendmessage() async {
    final enteredmessage = messagecontroller.text;
    if (enteredmessage.trim().isEmpty) {}

    messagecontroller.clear();
    FocusScope.of(context).unfocus();
    final userdata = await FirebaseFirestore.instance
        .collection('user data')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    FirebaseFirestore.instance.collection('messages').doc(timeday).set({
      'userid': userdata.data()!['id'],
      'text': enteredmessage,
      'createdAt': Timestamp.now(),
      'name': userdata.data()!['name'],
      'email': userdata.data()!['email'],
      'image': userdata.data()!['image'],
    }).then((value) {
      debugPrint('sent message');
      pushnotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    timeday = DateTime.now().millisecondsSinceEpoch.toString();

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 2, bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messagecontroller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(label: Text('Enter message')),
            ),
          ),
          IconButton(
              onPressed: () {
                sendmessage();
                // pushnotifications();
              },
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
