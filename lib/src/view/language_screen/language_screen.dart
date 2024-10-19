import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/view_model/language_view_model/language_view_model.dart';

import '../../constants/images_strings.dart';
import '../../constants/arabic_constants.dart';
import '../../constants/colors_constants.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageViewModel languageViewModel = Get.put(LanguageViewModel());
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                holyQuranLogo,
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 15.0),
              Text(
                chooseLanguageArabic,
                style: GoogleFonts.getFont(
                  'Almarai',
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FilledButton.tonal(
                  onPressed: () => {languageViewModel.navigateToLoginSceen()},
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
                  onPressed: () => {languageViewModel.navigateToLoginSceen()},
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
