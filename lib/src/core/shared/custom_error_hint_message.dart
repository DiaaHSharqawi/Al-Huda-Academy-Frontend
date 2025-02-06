import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomErrorHintMessage extends StatelessWidget {
  const CustomErrorHintMessage({
    super.key,
    required this.icon,
    required this.text,
    this.color = Colors.red,
    this.iconTextSpace = 8,
    this.fontSize = 16,
  });

  final String text;
  final double? fontSize;

  final IconData icon;
  final Color? color;

  final double iconTextSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          SizedBox(width: iconTextSpace),
          CustomGoogleTextWidget(
            text: text,
            fontSize: fontSize!,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ],
      ),
    );
  }
}
