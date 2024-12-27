import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_memorization_group_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_memorization_group_dashboard_service.dart';

class SupervisorMemorizationGroupDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorMemorizationGroupDashboardService>(
        () => (SupervisorMemorizationGroupDashboardService()));

    Get.lazyPut<SupervisorMemorizationGroupDashboardController>(
        () => SupervisorMemorizationGroupDashboardController(
              Get.find<SupervisorMemorizationGroupDashboardService>(),
            ));
  }
}
