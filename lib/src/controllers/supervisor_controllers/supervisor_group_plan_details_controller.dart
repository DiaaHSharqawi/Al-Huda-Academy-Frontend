import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_plan_details_service.dart';

class SupervisorGroupPlanDetailsController extends GetxController {
  final SupervisorGroupPlanDetailsService _supervisorCreateGroupPlanService;

  SupervisorGroupPlanDetailsController(
    this._supervisorCreateGroupPlanService,
  );

  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading(true);

      debugPrint(Get.arguments.toString());
    } catch (error) {
      debugPrint("Error SupervisorCreateGroupPlanController onInit : $error");
    } finally {
      isLoading(false);
    }
  }
}
