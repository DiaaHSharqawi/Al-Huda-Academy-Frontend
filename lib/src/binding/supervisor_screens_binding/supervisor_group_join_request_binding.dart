import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_join_request_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_join_request_service.dart';

class SupervisorGroupJoinRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorGroupJoinRequestService>(
      () => SupervisorGroupJoinRequestService(),
    );

    Get.lazyPut<SupervisorGroupJoinRequestController>(
      () => SupervisorGroupJoinRequestController(
        Get.find<SupervisorGroupJoinRequestService>(),
      ),
    );
  }
}
