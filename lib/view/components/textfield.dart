import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;
  const MyTextfield({
    super.key,
    this.controller,
    required this.labelText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            // fillColor: Color(0xFFE3F0FE),
            // filled: true,
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.grey[500],
            )),
      ),
    );
  }
}
