import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/meeting_controllers/supervisor_meeting_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/meeting_services/supervisor_meeting_dashboard_service.dart';

class SupervisorMeetingDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorMeetingDashboardService>(
      () => SupervisorMeetingDashboardService(),
    );

    Get.lazyPut<SupervisorMeetingDashboardController>(
      () => SupervisorMeetingDashboardController(
        Get.find<SupervisorMeetingDashboardService>(),
      ),
    );
  }
}
