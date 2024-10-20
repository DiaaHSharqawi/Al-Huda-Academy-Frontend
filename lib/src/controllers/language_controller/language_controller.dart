import 'dart:ui';

import 'package:get/get.dart';

class LanguageController extends GetxController {
  void navigateToLoginSceen() {
    Get.offNamed('/auth/login');
  }

  void changeLanguage(String languageCode) {
    Locale language = Locale(languageCode);
    Get.updateLocale(language);
  }
}
