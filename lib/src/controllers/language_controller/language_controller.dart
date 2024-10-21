import 'dart:ui';

import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class LanguageController extends GetxController {
  final AppService appService =
      Get.find<AppService>(); // Get the AppService instance
  void navigateToLoginSceen() {
    //Get.offNamed('/auth/login');
    Get.toNamed('/auth/login');
  }

  void changeLanguage(String languageCode) {
    appService.changeLanguage(languageCode);
  }
}
