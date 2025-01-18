import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_memorization_groups_dashboard_service.dart';

class SupervisorMemorizationGroupsDashboardController extends GetxController {
  final SupervisorMemorizationGroupsDashboardService
      // ignore: unused_field
      _supervisorMemorizationGroupDashboardService;

  SupervisorMemorizationGroupsDashboardController(
      this._supervisorMemorizationGroupDashboardService);

  void navigateToCreateGroupScreen() {
    Get.toNamed(AppRoutes.createGroupSupervisorScreen);
  }

  void navigateToCurrentGroupsScreen() {
    Get.toNamed(AppRoutes.supervisorCurrentGroupsScreen);
  }
}
