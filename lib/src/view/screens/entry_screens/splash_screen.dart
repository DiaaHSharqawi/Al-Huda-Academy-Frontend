import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import '../../../controllers/splash_controller.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.find();
  final appService = Get.find<AppService>();

  static const double imageSize = 350.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildImage(
                  AppImages.splashScreenImage,
                ),
                Obx(() {
                  final isArabic = appService.isRtl.value;

                  final String fontFamily =
                      isArabic ? AppFonts.arabicFont : AppFonts.englishFont;
                  return SizedBox(
                    height: 64.0,
                    child: _buildAcademyNameText(fontFamily),
                  );
                }),
                const SizedBox(
                  height: 50.0,
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: _buildLoader(
                    context,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? const CupertinoActivityIndicator(
            color: Colors.black,
            radius: 20.0,
          )
        : const CircularProgressIndicator(
            color: Colors.black,
          );
  }

  Widget _buildImage(String imagePath) {
    return Image.asset(
      imagePath,
      width: imageSize,
      height: imageSize,
      fit: BoxFit.contain,
    );
  }

  Widget _buildAcademyNameText(String fontFamily) {
    return Container(
      height: 24.0,
      alignment: Alignment.center,
      child: CustomGoogleTextWidget(
        fontSize: 24.0,
        color: Colors.white,
        textAlign: TextAlign.center,
        fontFamily: fontFamily,
        text: SplashScreenLanguageConstants.academyName.tr,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
