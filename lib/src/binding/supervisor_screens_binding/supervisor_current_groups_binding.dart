import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_current_groups_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_current_groups_service.dart';

class SupervisorCurrentGroupsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorCurrentGroupsService>(
        () => (SupervisorCurrentGroupsService()));

    Get.lazyPut<SupervisorCurrentGroupsController>(
      () => SupervisorCurrentGroupsController(
        Get.find<SupervisorCurrentGroupsService>(),
      ),
    );
  }
}
