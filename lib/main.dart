import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/change_localization.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/translation.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:toastification/toastification.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  await AppTranslation.loadTranslations();

  try {
    await dotenv.load(fileName: 'assets/.env');
    debugPrint("Loaded .env file successfully.");
  } catch (e) {
    debugPrint("Error loading .env file: ${e.runtimeType} - $e");
  }

  runApp(const AlHudaAcademy());
}

class AlHudaAcademy extends StatelessWidget {
  const AlHudaAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    LocalizationController localizationController =
        Get.put(LocalizationController());

    return ToastificationWrapper(
      child: GetMaterialApp(
        locale: localizationController.initialLanguage,
        translations: AppTranslation(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splach,
        getPages: [
          ...AppPages.entryScreens,
          ...AppPages.authenticationPages,
          ...AppPages.homePages,
          ...AppPages.athkarPages,
          ...AppPages.familyLinksPages,
        ],
      ),
    );
  }
}
