// ignore_for_file: file_names

import 'package:bitchat/register/auth_service.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class screenHome extends StatefulWidget {
  const screenHome({super.key});

  @override
  State<screenHome> createState() => _screenHomeState();
}

// ignore: camel_case_types
class _screenHomeState extends State<screenHome> {
  void logOut() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(onPressed: logOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: const Text("Home Page"),
    );
  }
}
