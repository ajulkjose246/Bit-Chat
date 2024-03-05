// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class screenSignin extends StatefulWidget {
  const screenSignin({super.key});

  @override
  State<screenSignin> createState() => screenSigninState();
}

// ignore: camel_case_types
class screenSigninState extends State<screenSignin> {
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
                    "Login Now",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(24, 215, 144, 1)),
                  )
                ],
              ),
              const Text(
                "Please login to continue using our app",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(10, 59, 83, 1)),
              ),
              const Spacer(),
              SizedBox(
                width: 500,
                height: 500,
                child: Lottie.asset('assets/lottie/login.json'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  print("Login Success");
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
                    "Login",
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
                    "Don't have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(10, 59, 83, 1)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'signUp', (route) => false);
                      },
                      child: const Text("Sign up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
