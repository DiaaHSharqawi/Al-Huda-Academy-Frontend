import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomAuthTextButton extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final double borderRadiusCircular;
  final String buttonText;
  final Color buttonTextColor;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final double padding;
  final Widget? loadingWidget;

  const CustomAuthTextButton(
      {super.key,
      required this.foregroundColor,
      required this.backgroundColor,
      this.borderRadiusCircular = 12,
      required this.buttonText,
      required this.buttonTextColor,
      this.fontFamily = AppFonts.arabicFont,
      required this.fontSize,
      required this.fontWeight,
      required this.onPressed,
      this.padding = 4,
      this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          foregroundColor,
        ),
        backgroundColor: WidgetStateProperty.all(
          backgroundColor,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusCircular),
            side: const BorderSide(color: Colors.white),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: loadingWidget ??
            CustomGoogleTextWidget(
              text: buttonText,
              color: buttonTextColor,
              fontFamily: fontFamily,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
      ),
    );
  }
}
