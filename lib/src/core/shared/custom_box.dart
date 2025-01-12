import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomGroupJoinRequest extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color? textColor;

  final Color boxColor;
  final String? imagePath;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  const CustomGroupJoinRequest({
    super.key,
    required this.text,
    this.imagePath,
    required this.boxColor,
    this.onTap,
    this.height = 160.0,
    this.width = double.infinity,
    this.textSize = 24,
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
              color: boxColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imagePath != null)
                  Center(
                    child: CircleAvatar(
                      foregroundColor: Colors.white,
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.network(
                          imagePath!,
                          fit: BoxFit.cover,
                          width: 80.0,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 24.0),
                CustomGoogleTextWidget(
                  text: text,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: textSize!,
                ),
                const SizedBox(width: 48.0),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
