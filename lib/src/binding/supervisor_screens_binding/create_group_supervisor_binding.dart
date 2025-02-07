import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/create_group_supervisor_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/create_memorization_group_service.dart';

class SupervisorCreateGroupScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateMemorizationGroupService>(
        () => (CreateMemorizationGroupService()));

    Get.lazyPut<SupervisorCreateGroupController>(
        () => SupervisorCreateGroupController(
              Get.find<CreateMemorizationGroupService>(),
            ));
  }
}
