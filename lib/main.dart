import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/change_localization.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/translation.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/register_screen/register_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/entry_screens/language_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/login_screen/login_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/home_screen.dart';
import 'package:toastification/toastification.dart';
import 'src/view/screens/entry_screens/splash_screen.dart';

void main() async {
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
        home: SafeArea(
          child: Scaffold(
            body: SplashScreen(),
          ),
        ),
        getPages: [
          GetPage(
            name: AppRoutes.language,
            page: () => const LanguageScreen(),
          ),
          GetPage(
            name: AppRoutes.login,
            page: () => const LoginScreen(),
          ),
          GetPage(
            name: AppRoutes.register,
            page: () => const RegisterScreen(),
          ),
          GetPage(
            name: AppRoutes.home,
            page: () => const HomeScreen(),
            transition: Transition.leftToRightWithFade,
            transitionDuration: const Duration(milliseconds: 500),
            // Define the transition here
          ),
        ],
      ),
    );
  }
}
