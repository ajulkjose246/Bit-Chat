// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:bitchat/components/imageSelect.dart';
import 'package:bitchat/components/myTextfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class screenUserData extends StatefulWidget {
  const screenUserData({super.key});

  @override
  State<screenUserData> createState() => _screenUserDataState();
}

// ignore: camel_case_types
class _screenUserDataState extends State<screenUserData> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  Uint8List? _image;

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
                    "Complete Profile",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(24, 215, 144, 1)),
                  )
                ],
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: myTextfield(
                      controller: emailController,
                      hintText: "First Name",
                      obsecuredText: false,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: myTextfield(
                      controller: emailController,
                      hintText: "Second Name",
                      obsecuredText: false,
                    ),
                  ),
                ],
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
                onPressed: () {},
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
