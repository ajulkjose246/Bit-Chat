import 'package:bitchat/register/auth_service.dart';
import 'package:flutter/material.dart';

class screenHome extends StatefulWidget {
  const screenHome({super.key});

  @override
  State<screenHome> createState() => _screenHomeState();
}

class _screenHomeState extends State<screenHome> {
  void logOut() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [IconButton(onPressed: logOut, icon: Icon(Icons.logout))],
      ),
      body: Text("Home Page"),
    );
  }
}
