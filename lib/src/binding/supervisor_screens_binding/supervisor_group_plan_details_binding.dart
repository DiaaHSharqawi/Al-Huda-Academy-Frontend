import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_plan_details_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_plan_details_service.dart';

class SupervisorGroupPlanDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorGroupPlanDetailsService>(
      () => (SupervisorGroupPlanDetailsService()),
    );

    Get.lazyPut<SupervisorGroupPlanDetailsController>(
      () => SupervisorGroupPlanDetailsController(
        Get.find<SupervisorGroupPlanDetailsService>(),
      ),
    );
  }
}
