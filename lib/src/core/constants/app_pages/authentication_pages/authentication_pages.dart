import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/login_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/reset_password_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages/authentication_pages/register_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/login_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/reset_password_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/send_password_reset_code_screen.dart';

class AuthenticationPages {
  static final List<GetPage> pages = [
    ...RegisterPages.pages,
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 800),
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
}
