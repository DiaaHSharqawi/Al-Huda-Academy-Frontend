import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class LocalizationController extends GetxController {
  var isRtl = false.obs;
  Locale? initialLanguage;
  AppService appService = Get.find();

  changeLanguage(String language) {
    appService.changeLanguage(language);
  }

  @override
  void onInit() {
    super.onInit();

    String? savedLanguage = appService.languageStorage.read("language");
    if (savedLanguage == null) {
      savedLanguage = "en";
      appService.languageStorage.write("language", savedLanguage);
    }
    initialLanguage = Locale(savedLanguage);
    Get.updateLocale(initialLanguage!);
  }
}
