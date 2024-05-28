import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageOne extends StatelessWidget {
  final String message;
  final image;
  MessageOne({super.key, required this.message, required this.image});
  final id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: image == null
              ? Container(
                  child: Center(
                  child: Icon(Icons.person),
                ))
              : Image(
                  height: 40,
                  width: 40,
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                ),
        ),
        Container(
          height: 25,
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(10)),
        ),
      ],
    );
  }
}

class Message2 extends StatelessWidget {
  final String message;
  final image2;

  const Message2({super.key, required this.message, required this.image2});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: image2 == null
              ? Container(
                  child: const Center(
                  child: Icon(Icons.person),
                ))
              : Image(
                  height: 40,
                  width: 40,
                  image: NetworkImage(image2),
                  fit: BoxFit.fill,
                ),
        ),
        Container(
          height: 25,
          child: Padding(
            padding: EdgeInsets.only(left: 13, right: 13),
            child: Text(message),
          ),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)),
        ),
      ],
    );
  }
}
