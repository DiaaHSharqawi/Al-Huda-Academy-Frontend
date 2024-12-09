import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomCategory extends StatelessWidget {
  final String categoryName;
  final String? imagePath;
  final Color categoryColor;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final double? categoryFontSize;
  final Color? textColor;

  const CustomCategory({
    super.key,
    required this.categoryName,
    this.imagePath,
    required this.categoryColor,
    this.onTap,
    this.height = 160.0,
    this.width = double.infinity,
    this.categoryFontSize = 24,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.white.withOpacity(0.4),
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          child: Ink(
            width: width,
            height: height,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomGoogleTextWidget(
                    text: categoryName,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: categoryFontSize!,
                  ),
                ),
                const SizedBox(width: 48.0),
                if (imagePath != null) Image.asset(imagePath!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
