import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:moltqa_al_quran_frontend/src/binding/entry_screens_binding/language_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/entry_screens_binding/splash_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages/started_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/entry_screens/language_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/entry_screens/splash_screen.dart';

class EntryScreensPages {
  static final List<GetPage> pages = [
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
      name: AppRoutes.startPages,
      page: () => const StartedPages(),
    )
  ];
}
