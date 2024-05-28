import 'dart:convert';

import 'package:chat_app/components/message_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatMessage extends StatefulWidget {
  const ChatMessage({super.key});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  final id = FirebaseAuth.instance.currentUser!.uid;
  var data;
  var compare;
  var image;
  var devicetoken;

  get notificationServices => null;

  @override
  @override
  Widget build(BuildContext context) {
    print('fsd');
    print(image);
    print(id);
    print(data);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data found'));
          } else if (chatSnapshot.hasError) {
            return const Center(child: Text('Error, could not fetch data'));
          } else if (chatSnapshot.data == null) {
            return const Center(child: Text('Null'));
          } else {
            final chatmessages = chatSnapshot.data!.docs;

            void getdata() async {
              final data =
                  await FirebaseFirestore.instance.collection('user data');

              // Set the image variable with data fetched from Firestore
              setState(() {
                image = '';
              });
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 15, right: 5),
              child: ListView.builder(
                reverse: true,
                itemCount: chatmessages.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: FirebaseAuth.instance.currentUser!.uid ==
                              chatmessages[index]['userid']
                          ? MessageOne(
                              message: chatmessages[index]['text'],
                              image: chatmessages[index]['image'])
                          : Message2(
                              message: chatmessages[index]['text'],
                              image2: chatmessages[index]['image']));
                },
              ),
            );
          }
        });
  }
}
