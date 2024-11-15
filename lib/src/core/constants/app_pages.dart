import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/binding/athkar_screens_binding/athkar_categories_screen_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/athkar_screens_binding/athkar_screen_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/login_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/register_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/reset_password_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/entry_screens_binding/language_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/entry_screens_binding/splash_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/athkar_screens/athkar_categories_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/athkar_screens/athkar_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/login_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/register_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/reset_password_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth/send_password_reset_code_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/entry_screens/language_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/entry_screens/splash_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/home_screen.dart';

class AppPages {
  static final List<GetPage> authenticationPages = [
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
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];

  static final List<GetPage> entryScreens = [
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
  ];

  static final List<GetPage> homePages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];

  static final List<GetPage> athkarPages = [
    GetPage(
      name: AppRoutes.athkarCategories,
      page: () => AthkarCategoriesScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: AthkarCategoriesScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.athkar,
      page: () => AthkarScreen(),
      transition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      binding: AthkarScreenBinding(),
    ),
  ];
}
