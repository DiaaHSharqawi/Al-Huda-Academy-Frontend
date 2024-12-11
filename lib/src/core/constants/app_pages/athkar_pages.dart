import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moltqa_al_quran_frontend/src/binding/athkar_screens_binding/athkar_categories_screen_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/athkar_screens_binding/athkar_screen_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/athkar_screens/athkar_categories_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/athkar_screens/athkar_screen.dart';

class AthkarPages {
  static final List<GetPage> pages = [
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
