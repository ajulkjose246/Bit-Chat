import 'package:flutter/material.dart';

class myTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecuredText;
  final FocusNode? focusNode;

  const myTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecuredText,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecuredText,
      focusNode: focusNode,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
    );
  }
}
