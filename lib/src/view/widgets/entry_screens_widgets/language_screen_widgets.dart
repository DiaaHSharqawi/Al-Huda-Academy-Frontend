import 'package:flutter/material.dart';

class CustomLanguageButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomLanguageButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        elevation: 8,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }
}
