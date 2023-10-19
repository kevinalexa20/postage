import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const AuthButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFC94A38),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.notoSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE3F0FE),
              ),
            ),
          )),
    );
  }
}
