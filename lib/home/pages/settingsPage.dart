// ignore_for_file: file_names

import 'package:bitchat/services/auth_service.dart';
import 'package:bitchat/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class pageSettings extends StatefulWidget {
  // ignore: use_super_parameters
  const pageSettings({Key? key}) : super(key: key);

  @override
  pageSettingsState createState() => pageSettingsState();
}

// ignore: camel_case_types
class pageSettingsState extends State<pageSettings> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      AuthService authService = AuthService();
      var userData = await authService.getUserData();
      setState(() {
        // Update the userName with the user's name from Firestore
        userEmail = userData['email'];
      });
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching user data: $e");
      // Handle error fetching user data
    }
  }

  void logOut() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50, // Adjust the size as needed
                child: Icon(Icons.person),
              ),
              SizedBox(height: 10),
              Text(
                userEmail ?? "", // Display user name, if available
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode"),
              Switch(
                activeColor: Colors.red,
                value: Provider.of<ThemeProvide>(context, listen: false)
                    .isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvide>(context, listen: false)
                        .toggleTheme(),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: logOut,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
            ),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
