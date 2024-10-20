import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './../../../src/core/constants/app_fonts.dart';

class CustomGoogleTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final double letterSpacing;
  final TextDecoration? textDecoration;
  final String fontFamily;
  final TextAlign textAlign;

  const CustomGoogleTextWidget(
      {super.key,
      required this.text,
      this.fontSize = 24.0,
      this.color,
      this.fontWeight = FontWeight.normal,
      this.letterSpacing = 0.0,
      this.textDecoration,
      this.fontFamily = AppFonts.arabicFont,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
      ),
    );
  }
}
