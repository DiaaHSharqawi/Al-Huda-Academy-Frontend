import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_dashboard_service.dart';

class SupervisorGroupDashboardBinding extends Bindings {
  @override
  void dependencies() {
    debugPrint("SupervisorGroupDashboardBinding");

    Get.lazyPut<SupervisorGroupDashboardService>(
      () => SupervisorGroupDashboardService(),
    );

    Get.lazyPut<SupervisorGroupDashboardController>(
      () => SupervisorGroupDashboardController(
        Get.find<SupervisorGroupDashboardService>(),
      ),
    );
  }
}
