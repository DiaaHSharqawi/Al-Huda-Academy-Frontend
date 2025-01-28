import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_plans_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/group_services/group_plan_services/supervisor_group_plans_service.dart';

class SupervisorGroupPlansBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint('SupervisorGroupPlansBinding');

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
