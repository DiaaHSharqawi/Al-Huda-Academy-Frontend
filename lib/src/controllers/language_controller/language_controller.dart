import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class LanguageController extends GetxController {
  final AppService appService = Get.find<AppService>();
  void navigateToLoginScreen() {
    Get.offNamed(AppRoutes.login);
  }

  void changeLanguage(String languageCode) {
    appService.changeLanguage(languageCode);
  }
}
