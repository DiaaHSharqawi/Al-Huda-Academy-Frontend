import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomImageWithText extends StatelessWidget {
  const CustomImageWithText({
    super.key,
    required this.imageProvider,
    required this.text,
    required this.width,
    required this.height,
    this.fontSize = 24.0,
    this.fontWeight = FontWeight.normal,
  });

  final ImageProvider? imageProvider;

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (imageProvider != null)
          Center(
            child: Image(
                image: imageProvider!,
                fit: BoxFit.cover,
                width: width,
                height: height),
          ),
        const SizedBox(
          height: 32.0,
        ),
        CustomGoogleTextWidget(
          text: text,
          textAlign: TextAlign.center,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ],
    );
  }
}
