import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';

class SupervisorController extends GetxController {
  var dialogShown = false.obs;
  void navigateToCreateGroupScreen() {
    Get.toNamed(AppRoutes.createGroupSupervisorScreen);
  }

  void navigateToLoginScreen() {
    Get.back();
  }

  void navigateToSupervisorGroupDashboard() {
    debugPrint("navigateToSupervisorGroupDashboard");
    Get.toNamed(AppRoutes.supervisorGroupDashboard);
  }

  void navigateToSupervisorMeetingDashboard() {
    debugPrint("navigateToSupervisorMeetingDashboard");

    Get.toNamed(AppRoutes.supervisorMeetingDashboard);
  }
}
