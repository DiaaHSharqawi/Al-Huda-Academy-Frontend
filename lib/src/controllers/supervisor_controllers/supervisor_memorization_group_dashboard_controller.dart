import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_memorization_group_dashboard_service.dart';

class SupervisorMemorizationGroupDashboardController extends GetxController {
  final SupervisorMemorizationGroupDashboardService
      // ignore: unused_field
      _supervisorMemorizationGroupDashboardService;

  SupervisorMemorizationGroupDashboardController(
      this._supervisorMemorizationGroupDashboardService);

  void navigateToCreateGroupScreen() {
    Get.toNamed(AppRoutes.createGroupSupervisorScreen);
  }
}
