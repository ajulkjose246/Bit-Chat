// ignore_for_file: file_names

import 'package:bitchat/home/screenHome.dart';
import 'package:bitchat/register/screenIntro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class userAuth extends StatelessWidget {
  const userAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return const screenHome();
          }
          //user is not logged in
          else {
            return const screenIntro();
          }
        },
      ),
    );
  }
}
