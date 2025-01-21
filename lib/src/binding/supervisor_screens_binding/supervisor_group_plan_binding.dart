import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_plan_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_plan_service.dart';

class SupervisorGroupPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorGroupPlanService>(
      () => SupervisorGroupPlanService(),
    );

    Get.lazyPut<SupervisorGroupPlanController>(
      () => SupervisorGroupPlanController(
        Get.find<SupervisorGroupPlanService>(),
      ),
    );
  }
}
