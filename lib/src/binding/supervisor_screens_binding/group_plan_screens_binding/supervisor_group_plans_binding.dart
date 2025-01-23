import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_plans_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_plans_service.dart';

class SupervisorGroupPlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorGroupPlansService>(
      () => SupervisorGroupPlansService(),
    );

    Get.lazyPut<SupervisorGroupPlansController>(
      () => SupervisorGroupPlansController(
        Get.find<SupervisorGroupPlansService>(),
      ),
    );
  }
}
