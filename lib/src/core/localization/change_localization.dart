import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class LocalizationController extends GetxController {
  Locale? initialLanguage;
  AppService appService = Get.find();

  changeLanguage(String language) {
    Locale locale = Locale(language);
    appService.languageStorage.write("language", language);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();

    // TODO: implement onInit

    String? savedLanguage = appService.languageStorage.read("language");

    if (savedLanguage != null) {
      initialLanguage = Locale(savedLanguage);
    } else {
      Locale deviceLocale = Get.deviceLocale ?? const Locale('en');
      initialLanguage = deviceLocale;

      appService.languageStorage.write("language", deviceLocale.languageCode);
    }
    Get.updateLocale(initialLanguage!);
  }
}
