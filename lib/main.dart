import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/change_localization.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/translation.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/language_screen/language_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/entry_screens/login_screen/login_screen.dart';
import 'src/view/screens/entry_screens/splash_screen_view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

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
    return GetMaterialApp(
      locale: localizationController.initialLanguage,
      translations: AppTranslation(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SplashScreen(),
        ),
      ),
      getPages: [
        GetPage(
          name: '/language',
          page: () => const LanguageScreen(),
        ),
        GetPage(name: '/auth/login', page: () => const LoginScreen()),
      ],
    );
  }
}
