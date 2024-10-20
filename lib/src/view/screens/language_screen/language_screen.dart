import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/language_controller/language_controller.dart';

import '../../../core/constants/app_images.dart';
import './../../../core/constants/arabic_constants.dart';
import './../../../core/constants/app_colors.dart';

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
              const SizedBox(height: 15.0),
              Text(
                //ArabicConstants.chooseLanguageArabic,
                "1".tr,
                style: GoogleFonts.getFont(
                  'Almarai',
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FilledButton.tonal(
                  onPressed: () => {
                    languageController.changeLanguage("ar"),
                    languageController.navigateToLoginSceen()
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                    elevation: 8,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    "AR",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FilledButton.tonal(
                  onPressed: () => {
                    languageController.changeLanguage("en"),
                    languageController.navigateToLoginSceen()
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                    elevation: 8,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    "EN",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
