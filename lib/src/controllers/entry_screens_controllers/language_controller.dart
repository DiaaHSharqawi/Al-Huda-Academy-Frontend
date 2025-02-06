import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class LanguageController extends GetxController {
  final AppService appService = Get.find<AppService>();
  void navigateToLoginScreen() {
    Get.offNamed(AppRoutes.login);
  }

  void navigateToStartedPages() {
    Get.offNamed(AppRoutes.startPages);
  }

  Future<void> changeLanguage(String languageCode) async {
    appService.changeLanguage(languageCode);
    await initializeDateFormatting(languageCode, null);
  }
}
