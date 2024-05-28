import 'package:chat_app/auth/sign_in_screen.dart';
import 'package:chat_app/auth/sign_up_screen.dart';
import 'package:chat_app/components/colors.dart';
import 'package:chat_app/components/roundbutton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 90, left: 20, bottom: 10),
              child: Text(
                "Welcome",
                style: AppColors.heading,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: Text(
                "Lets get started",
                style: AppColors.subheading,
              ),
            ),
            const SizedBox(
              height: 250,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                "Existing  customer / Get started ",
                style: AppColors.subheading,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundButton(
                  title: 'Sign in',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    "New customer?",
                    style: AppColors.subheading,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: AppColors.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
