import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomLanguageButton extends StatelessWidget {
  final String buttonText;
  final double fontSize;
  final VoidCallback onPressed;

  const CustomLanguageButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.fontSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        elevation: 8,
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
          side: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: CustomGoogleTextWidget(
        text: buttonText,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}
