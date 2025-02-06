import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_create_group_plan_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/group_services/group_plan_services/supervisor_create_group_plan_service.dart';

class SupervisorCreateGroupPlanScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorCreateGroupPlanService>(
      () => SupervisorCreateGroupPlanService(),
    );

    Get.lazyPut<SupervisorCreateGroupPlanController>(
      () => SupervisorCreateGroupPlanController(
        Get.find<SupervisorCreateGroupPlanService>(),
      ),
    );
  }
}
