import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String usrProfileUrl;
  final void Function()? onTap;
  const UserTile(
      {super.key, required this.text, this.onTap, required this.usrProfileUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              //icon
              CircleAvatar(
                backgroundImage: NetworkImage(usrProfileUrl),
              ),
              const SizedBox(
                width: 20,
              ),
              //user Name
              Text(
                text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
