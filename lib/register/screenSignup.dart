// ignore_for_file: file_names

import 'package:bitchat/components/myTextfield.dart';
import 'package:bitchat/register/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class screenSignup extends StatefulWidget {
  const screenSignup({super.key});

  @override
  State<screenSignup> createState() => screenSignupState();
}

// ignore: camel_case_types
class screenSignupState extends State<screenSignup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  // signup user function
  void signUp(BuildContext context) async {
    final authService = AuthService();
    if (passwordController.text == confirmpasswordController.text) {
      try {
        await authService.signUpWithEmailandPassword(
            emailController.text, passwordController.text);
        Navigator.pushReplacementNamed(context, 'auth');
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password don't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
          top: 40,
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(24, 215, 144, 1)),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Please Registration with email and sign up to continue using our app",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(10, 59, 83, 1)),
              ),
              SizedBox(
                width: 400,
                height: 400,
                child: Lottie.asset('assets/lottie/login.json'),
              ),
              myTextfield(
                controller: emailController,
                hintText: "Email",
                obsecuredText: false,
              ),
              const SizedBox(height: 10),
              myTextfield(
                controller: passwordController,
                hintText: "Password",
                obsecuredText: true,
              ),
              const SizedBox(height: 10),
              myTextfield(
                controller: confirmpasswordController,
                hintText: "Confirm Password",
                obsecuredText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => signUp(context),
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
    ));
  }
}
