import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/entry_screens_widgets/language_screen_widgets.dart';
import '../../../controllers/language_controller/language_controller.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.holyQuranLogo,
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 16.0),
              _buildTitle(),
              const SizedBox(height: 32.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomLanguageButton(
                    buttonText: "ar",
                    onPressed: () {
                      languageController.changeLanguage("ar");
                      languageController.navigateToLoginSceen();
                    }),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomLanguageButton(
                    buttonText: "en",
                    onPressed: () {
                      languageController.changeLanguage("en");
                      languageController.navigateToLoginSceen();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "languge_screen.choose_language".tr,
      style: GoogleFonts.getFont(
        'Almarai',
        fontSize: 24.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
