import 'package:bitchat/themes/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class chatBubble extends StatelessWidget {
  final String message;
  final Timestamp messageTime;
  final int messageStatus;
  final bool isCurrentUser;
  const chatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageTime,
    required this.messageStatus,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvide>(context, listen: false).isDarkMode;
    DateTime dateTime = messageTime.toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isCurrentUser
                ? (isDarkMode
                    ? const Color.fromRGBO(20, 76, 55, 1)
                    : const Color.fromRGBO(217, 253, 211, 1))
                : (isDarkMode
                    ? const Color.fromRGBO(31, 44, 51, 1)
                    : const Color.fromRGBO(255, 255, 255, 1)),
            borderRadius: isCurrentUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))
                : const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
          child: Text(message),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: isCurrentUser
              ? const EdgeInsets.only(right: 30)
              : const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment:
                isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                formattedTime,
                style: const TextStyle(fontSize: 10),
              ),
              const SizedBox(
                width: 10,
              ),
              isCurrentUser
                  ? Icon(
                      // Icons.done_all_rounded,
                      messageStatus != 2
                          ? Icons.done_rounded
                          : Icons.done_all_rounded,
                      size: 17,
                      // color: Colors.blue,
                      color: messageStatus != 2 ? Colors.grey : Colors.blue,
                    )
                  : Icon(null)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
