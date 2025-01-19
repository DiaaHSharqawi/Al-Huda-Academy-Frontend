import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_weekly_plan_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_weekly_plan_service.dart';

class SupervisorGroupWeeklyPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorGroupWeeklyPlanService>(
      () => SupervisorGroupWeeklyPlanService(),
    );

    Get.lazyPut<SupervisorGroupWeeklyPlanController>(
      () => SupervisorGroupWeeklyPlanController(
        Get.find<SupervisorGroupWeeklyPlanService>(),
      ),
    );
  }
}
