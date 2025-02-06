import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_group_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_group_dashboard_service.dart';

class ParticipantGroupDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipantGroupDashboardService>(
      () => ParticipantGroupDashboardService(),
    );

    Get.lazyPut<ParticipantGroupDashboardController>(
      () => ParticipantGroupDashboardController(
        Get.find<ParticipantGroupDashboardService>(),
      ),
    );
  }
}
