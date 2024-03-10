// ignore_for_file: file_names
import 'dart:typed_data';

import 'package:bitchat/components/imageSelect.dart';
import 'package:bitchat/components/myTextfield.dart';
import 'package:bitchat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class screenSignup extends StatefulWidget {
  const screenSignup({super.key});

  @override
  State<screenSignup> createState() => screenSignupState();
}

// ignore: camel_case_types
class screenSignupState extends State<screenSignup> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  Uint8List? _image;

  // signup user function
  void signUp(BuildContext context) async {
    final authService = AuthService();
    if (passwordController.text == confirmpasswordController.text) {
      try {
        await authService.signUpWithEmailandPassword(
            context,
            emailController.text,
            passwordController.text,
            firstNameController.text,
            usernameController.text,
            secondNameController.text,
            _image!);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, 'auth');
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match"),
        ),
      );
    }
  }

  void uploadProfile() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
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
              const SizedBox(height: 30),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.person,
                            size: 70,
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                      onPressed: uploadProfile,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: myTextfield(
                      controller: firstNameController,
                      hintText: "First Name",
                      obsecuredText: false,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: myTextfield(
                      controller: secondNameController,
                      hintText: "Second Name",
                      obsecuredText: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              myTextfield(
                controller: usernameController,
                hintText: "@Username",
                obsecuredText: false,
              ),
              const SizedBox(height: 10),
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
