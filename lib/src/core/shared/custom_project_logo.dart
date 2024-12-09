import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomProjectLogo extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final String? text;
  final double fontSize;

  const CustomProjectLogo({
    super.key,
    required this.imagePath,
    this.text,
    required this.width,
    required this.height,
    this.fontSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final AppService appService = Get.find<AppService>();
    final String fontFamily =
        appService.isRtl.value ? AppFonts.arabicFont : AppFonts.englishFont;

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          if (text != null)
            Positioned(
              bottom: 10,
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: CustomGoogleTextWidget(
                  text: text!,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: fontSize,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
