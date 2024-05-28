import 'package:chat_app/chatscreen/chatscreen.dart';
import 'package:chat_app/components/colors.dart';
import 'package:chat_app/components/general_utils.dart';
import 'package:chat_app/components/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  FocusNode emailfocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  FocusNode namefocusnode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.001,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 90, bottom: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Sign In',
                    style: AppColors.heading,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Please enter your login details',
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
                          title: 'Sign In',
                          loading: value1.load,
                          ontap: () async {
                            value1.progressindic(true);
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailcontroller.text.toString(),
                                    password:
                                        passwordcontroller.text.toString())
                                .then((value) => {
                                      value1.progressindic(false),
                                      value1.successfulmessage(
                                          'Sucess', context),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChatScreen()))
                                    })
                                .onError((error, stackTrace) => {
                                      value1.showerrormessage(
                                          error.toString(), context),
                                      value1.progressindic(false)
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
