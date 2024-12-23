import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/admin_screens/admin_home_screen.dart';

class AdminPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.adminHomeScreen,
      page: () => const AdminHomeScreen(),
    ),
  ];
}
