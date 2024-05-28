import 'dart:io';

import 'package:chat_app/chatscreen/chatscreen.dart';
import 'package:chat_app/components/colors.dart';
import 'package:chat_app/components/general_utils.dart';
import 'package:chat_app/components/roundbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firebase = FirebaseAuth.instance;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('user data');
  FocusNode emailfocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  FocusNode namefocusnode = FocusNode();
  var newurl;
  final _formkey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  final id = DateTime.now().millisecondsSinceEpoch;

  Future uploadImage() async {
    final storage = FirebaseStorage.instance;

    final pickedfile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      _image = File(pickedfile.path);
      final storageref = storage.ref('/blogapp$id');
      UploadTask uploadTask = storageref.putFile(_image!.absolute);
      await Future.value(uploadTask);
      newurl = await storageref.getDownloadURL();

      setState(() {});
    } else {
      GeneralUtils().showerrormessage("No Image found", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Sign Up',
                  style: AppColors.heading,
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Please create a new account',
                  style: AppColors.subheading,
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                        child: _image != null
                            ? ClipRect(
                                child: Image.file(
                                _image!.absolute,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ))
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(Icons.person),
                              )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image,
                          color: AppColors.mainColor,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        InkWell(
                          onTap: () {
                            uploadImage();
                          },
                          child: const Text(
                            'Upload Image',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: namecontroller,
                      focusNode: namefocusnode,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE1E1E1))),
                          hintText: "Enter name",
                          labelText: 'Name',
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.mainColor,
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {}
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      focusNode: emailfocusnode,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE1E1E1))),
                          fillColor: Colors.white,
                          hintText: "Enter email",
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.mainColor,
                          )),
                      onFieldSubmitted: ((value) {}),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your email address';
                        }

                        // else if (!value.contains('@')) {
                        //   return 'Enter a correct email, i.e hamza@gmail.com';
                        // }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordcontroller,
                      focusNode: passwordfocusnode,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE1E1E1))),
                          hintText: "Enter password",
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.mainColor,
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Consumer<GeneralUtils>(
                      builder: (context, value1, child) => RoundButton(
                          loading: value1.load,
                          title: 'Sign Up',
                          ontap: () async {
                            value1.progressindic(true);
                            await firebase
                                .createUserWithEmailAndPassword(
                                    email: emailcontroller.text.toString(),
                                    password:
                                        passwordcontroller.text.toString())
                                .then((value) {
                              FirebaseMessaging.instance
                                  .getToken()
                                  .then((token) => firestore
                                          .doc(firebase.currentUser!.uid)
                                          .set({
                                        'name': namecontroller.text.toString(),
                                        'email':
                                            emailcontroller.text.toString(),
                                        'image': newurl,
                                        'id': firebase.currentUser!.uid,
                                        'token': token.toString(),
                                      }))
                                  .onError((error, stackTrace) =>
                                      value1.showerrormessage(
                                          error.toString(), context));
                              value1.progressindic(false);
                              GeneralUtils()
                                  .successfulmessage('success', context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChatScreen()));
                            }).onError((error, stackTrace) {
                              value1.progressindic(false);

                              GeneralUtils()
                                  .showerrormessage(error.toString(), context);
                            });
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
