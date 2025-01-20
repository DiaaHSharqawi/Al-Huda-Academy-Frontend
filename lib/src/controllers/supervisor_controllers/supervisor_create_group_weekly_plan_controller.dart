import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_create_group_weekly_plan_service.dart';

class SupervisorCreateGroupWeeklyPlanController extends GetxController {
  final SupervisorCreateGroupWeeklyPlanService
      _supervisorCreateGroupWeeklyPlanService;

  SupervisorCreateGroupWeeklyPlanController(
    this._supervisorCreateGroupWeeklyPlanService,
  );

  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading(true);

      debugPrint(Get.arguments.toString());
    } catch (error) {
      debugPrint(
          "Error SupervisorCreateGroupWeeklyPlanController onInit : $error");
    } finally {
      isLoading(false);
    }
  }
}
