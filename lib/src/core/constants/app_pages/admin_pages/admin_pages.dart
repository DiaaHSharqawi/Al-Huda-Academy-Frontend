import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moltqa_al_quran_frontend/src/binding/admin_screens_binding/admin_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/admin_screens_binding/admin_group_dashboard_screen_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/admin_screens_binding/admin_requested_group_details_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/admin_screens_binding/admin_requests_for_creating_group_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/admin_screens_binding/admin_supervisor_dashboard_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/admin_screens_binding/admin_supervisor_request_registration_details_screen_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/admin_screens_binding/admin_supervisor_requests_registration_screen_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/admin_screens/admin_group_dashboard_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/admin_screens/admin_home_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/admin_screens/admin_requested_group_details_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/admin_screens/admin_requests_for_creating_group_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/admin_screens/admin_supervisor_dashboard_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/admin_screens/admin_supervisor_request_registration_details_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/admin_screens/admin_supervisor_requests_registration_screen.dart';

class AdminPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.adminHomeScreen,
      page: () => const AdminHomeScreen(),
      transition: Transition.upToDown,
      binding: AdminBinding(),
    ),
    GetPage(
      name: AppRoutes.adminGroupDashboard,
      page: () => const AdminGroupDashboardScreen(),
      binding: AdminGroupDashboardScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.adminRequestsForCreatingGroup,
      page: () => const AdminRequestsForCreatingGroupScreen(),
      binding: AdminRequestsForCreatingGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.adminRequestedGroupDetails,
      page: () => const AdminRequestedGroupDetailsScreen(),
      binding: AdminRequestedGroupDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.adminSupervisorDashboard,
      page: () => const AdminSupervisorDashboardScreen(),
      binding: AdminSupervisorDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.adminSupervisorRequestsRegistration,
      page: () => const AdminSupervisorRequestsRegistrationScreen(),
      binding: AdminSupervisorRequestsRegistrationScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.adminSupervisorRequestRegistrationDetails,
      page: () => const AdminSupervisorRequestRegistrationDetailsScreen(),
      binding: AdminSupervisorRequestRegistrationDetailsScreenBinding(),
    ),
  ];
}
