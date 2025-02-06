import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/entry_screens_widgets/language_screen_widgets.dart';

import '../../../controllers/entry_screens_controllers/language_controller.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({super.key});

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
                SizedBox(child: _buildImageLogo()),
                const SizedBox(height: 82.0),
                _buildTitle(),
                const SizedBox(height: 32.0),
                _buildLanguageButton(
                  LangugeScreenLanguageConstants.arabicText.tr,
                  LangugeScreenLanguageConstants.arLanguageCode,
                ),
                const SizedBox(height: 20.0),
                _buildLanguageButton(
                  LangugeScreenLanguageConstants.englishText.tr,
                  LangugeScreenLanguageConstants.engLanguageCode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return CustomGoogleTextWidget(
      text: LangugeScreenLanguageConstants.chooseLanguage.tr,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildImageLogo() {
    return CustomProjectLogo(
      imagePath: AppImages.holyQuranLogo,
      width: 300,
      height: 300,
      text: SharedLanguageConstants.academyName.tr,
    );
  }

  Widget _buildLanguageButton(String buttonText, String languageCode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      child: CustomLanguageButton(
        buttonText: buttonText,
        fontSize: 20.0,
        onPressed: () {
          controller.changeLanguage(languageCode);
          controller.navigateToStartedPages();
          // todo:  return it back to navigate to login screen
          //Get.toNamed(AppRoutes.athkarCategories);
        },
      ),
    );
  }
}
