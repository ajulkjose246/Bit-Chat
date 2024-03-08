import 'package:flutter/material.dart';

// ignore: camel_case_types
class chatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const chatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              isCurrentUser ? Color.fromRGBO(228, 255, 201, 1) : Colors.white,
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
      child: Text(message),
    );
  }
}
