import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/entry_screens_widgets/language_screen_widgets.dart';

import '../../../controllers/language_controller/language_controller.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final appService = Get.find<AppService>();
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildImageLogo(),
                const SizedBox(height: 16.0),
                Obx(() {
                  final isArabic = appService.isRtl.value;

                  final String fontFamily =
                      isArabic ? AppFonts.arabicFont : AppFonts.englishFont;
                  return _buildTitle(fontFamily);
                }),
                const SizedBox(height: 32.0),
                _buildLanguageButton(languageController,
                    LangugeScreenLanguageConstants.arabicText, "ar"),
                const SizedBox(height: 20.0),
                _buildLanguageButton(languageController,
                    LangugeScreenLanguageConstants.englishText, "en"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String fontFamily) {
    return CustomGoogleTextWidget(
      fontFamily: fontFamily,
      text: LangugeScreenLanguageConstants.chooseLanguage.tr,
    );
  }

  Widget _buildImageLogo() {
    return Image.asset(
      AppImages.holyQuranLogo,
      width: 300,
      height: 300,
    );
  }

  Widget _buildLanguageButton(LanguageController languageController,
      String buttonText, String languageCode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomLanguageButton(
        buttonText: buttonText,
        onPressed: () {
          languageController.changeLanguage(languageCode);
          languageController.navigateToLoginSceen();
        },
      ),
    );
  }
}
