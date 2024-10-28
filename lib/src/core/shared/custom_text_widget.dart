import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class CustomGoogleTextWidget extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final double letterSpacing;
  final TextDecoration? textDecoration;
  final String? fontFamily;
  final TextAlign? textAlign;
  final VoidCallback? onTap;

  const CustomGoogleTextWidget({
    super.key,
    required this.text,
    this.fontSize = 24.0,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0.0,
    this.textDecoration,
    this.fontFamily,
    this.textAlign,
    this.onTap,
  });

  @override
  State<CustomGoogleTextWidget> createState() => _CustomGoogleTextWidgetState();
}

class _CustomGoogleTextWidgetState extends State<CustomGoogleTextWidget> {
  get textAlign => null;
  set textAlign(textAlgin) => textAlgin;

  @override
  Widget build(BuildContext context) {
    final AppService appService = Get.find<AppService>();
    final bool isArabic = appService.isRtl.value;
    final String fontFamily =
        isArabic ? AppFonts.arabicFont : AppFonts.englishFont;

    textAlign ??= isArabic ? TextAlign.right : TextAlign.left;
    debugPrint(widget.textAlign.toString());

    return InkWell(
      onTap: widget.onTap,
      splashColor: Colors.blue.withAlpha(30),
      child: Text(
        widget.text,
        textAlign: widget.textAlign,
        style: GoogleFonts.getFont(
          fontFamily,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          letterSpacing: widget.letterSpacing,
          decoration: widget.textDecoration,
          color: widget.color,
        ),
      ),
    );
  }
}
