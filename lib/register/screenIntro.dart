// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class screenIntro extends StatefulWidget {
  const screenIntro({super.key});

  @override
  State<screenIntro> createState() => screenIntroState();
}

// ignore: camel_case_types
class screenIntroState extends State<screenIntro> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const Spacer(),
              const Row(
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(24, 215, 144, 1)),
                  )
                ],
              ),
              const Row(
                children: [
                  Text(
                    "Please login or sign up to continue using our app",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(10, 59, 83, 1)),
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 500,
                height: 500,
                child: Lottie.asset('assets/lottie/logo.json'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'signUp', (route) => false);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue), // Set button background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
                    ),
                  ),
                ),
                child: Container(
                  width: double.infinity, // Set button width to maximum
                  alignment: Alignment.center, // Align text to center
                  padding: const EdgeInsets.all(
                      12), // Add padding for better appearance
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 16, // Adjust font size as needed
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "You already have an accound ?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(10, 59, 83, 1)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'signIn', (route) => false);
                      },
                      child: const Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
