import 'package:bitchat/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class chatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const chatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvide>(context, listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser
              // ? Color.fromRGBO(228, 255, 201, 1)
              ? (isDarkMode
                  ? const Color.fromRGBO(20, 76, 55, 1)
                  : const Color.fromRGBO(217, 253, 211, 1))
              : (isDarkMode
                  ? const Color.fromRGBO(31, 44, 51, 1)
                  : const Color.fromRGBO(255, 255, 255, 1)),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
      child: Text(message),
    );
  }
}
