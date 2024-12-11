import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/binding/home_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/home_screen.dart';

class HomePages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: HomeBinding(),
    ),
  ];
}
