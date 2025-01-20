import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_create_group_weekly_plan_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_create_group_weekly_plan_service.dart';

class SupervisorCreateGroupWeeklyPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorCreateGroupWeeklyPlanService>(
      () => (SupervisorCreateGroupWeeklyPlanService()),
    );

    Get.lazyPut<SupervisorCreateGroupWeeklyPlanController>(
      () => SupervisorCreateGroupWeeklyPlanController(
        Get.find<SupervisorCreateGroupWeeklyPlanService>(),
      ),
    );
  }
}
