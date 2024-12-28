import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/create_group_supervisor_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/supervisor_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/supervisor_memorization_group_dashboard_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/create_group_supervisor_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_create_memorization_group_content_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_memorization_group_dashboard_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/supervisor_home_screen.dart';

class SupervisorPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.supervisorHomeScreen,
      page: () => SupervisorHomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: SupervisorBinding(),
    ),
    GetPage(
      name: AppRoutes.createGroupSupervisorScreen,
      page: () => const CreateGroupSupervisorScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: CreateGroupSupervisorBinding(),
    ),
    GetPage(
      name: AppRoutes.supervisorGroupDashboard,
      page: () => const SupervisorMemorizationGroupDashboardScreen(),
      transition: Transition.fadeIn,
      binding: SupervisorMemorizationGroupDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.supervisorCreateMemorizationGroupContentScreen,
      page: () => const SupervisorCreateMemorizationGroupContentScreen(),
      transition: Transition.fadeIn,
      binding: CreateGroupSupervisorBinding(),
    ),
  ];
}
