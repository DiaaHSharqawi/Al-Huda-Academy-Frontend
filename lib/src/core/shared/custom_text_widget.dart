import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGoogleTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final double letterSpacing;
  final TextDecoration? textDecoration;
  final String fontFamily;
  final TextAlign textAlign;
  final VoidCallback? onTap;

  const CustomGoogleTextWidget({
    super.key,
    required this.text,
    this.fontSize = 24.0,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0.0,
    this.textDecoration,
    required this.fontFamily,
    this.textAlign = TextAlign.right,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue.withAlpha(30),
      child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.getFont(
          fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          decoration: textDecoration,
          color: color,
        ),
      ),
    );
  }
}
