import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomBox extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color? textColor;
  final TextAlign? textAlign;

  final Color boxColor;
  final ImageProvider? imageProvider;
  final VoidCallback? onTap;
  final double? height;
  final double? width;

  final List<Widget>? boxChildren;

  const CustomBox({
    super.key,
    this.boxChildren,
    this.textAlign,
    required this.text,
    required this.boxColor,
    this.imageProvider,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (imageProvider != null)
                      Center(
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image(
                              image: imageProvider!,
                              fit: BoxFit.cover,
                              width: 80.0,
                              height: 80.0,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 24.0),
                    Flexible(
                      child: CustomGoogleTextWidget(
                        text: text,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        fontSize: textSize!,
                        textAlign: textAlign,
                      ),
                    ),
                    const SizedBox(width: 48.0),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ],
                ),
                if (boxChildren != null) ...boxChildren!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
