import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/reset_password_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/login_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/register_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/entry_screens_binding/language_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/entry_screens_binding/splash_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/change_localization.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/translation.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/reset_password_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/send_password_reset_code_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/register_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/entry_screens/language_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/login_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/home_screen.dart';
import 'package:toastification/toastification.dart';
import 'src/view/screens/entry_screens/splash_screen.dart';

void main() async {
//  debugPaintSizeEnabled = true;
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
          GetPage(
            name: AppRoutes.splach,
            page: () => SplashScreen(),
            binding: SplashBinding(),
          ),
          GetPage(
            name: AppRoutes.language,
            page: () => const LanguageScreen(),
            binding: LanguageBinding(),
          ),
          GetPage(
            name: AppRoutes.login,
            page: () => const LoginScreen(),
            binding: LoginBinding(),
            transition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 800),
          ),
          GetPage(
            name: AppRoutes.register,
            page: () => const RegisterScreen(),
            binding: RegisterBinding(),
            transition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 1000),
          ),
          GetPage(
            name: AppRoutes.sendPasswordResetCode,
            page: () => const SendPasswordResetCodeScreen(),
            binding: ResetPasswordBinding(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 1000),
          ),
          GetPage(
            name: AppRoutes.home,
            page: () => const HomeScreen(),
            transition: Transition.leftToRightWithFade,
            transitionDuration: const Duration(milliseconds: 500),
          ),
          GetPage(
            name: AppRoutes.resetPassword,
            page: () => const ResetPasswordScreen(),
            binding: ResetPasswordBinding(),
            transition: Transition.upToDown,
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        ],
      ),
    );
  }
}
