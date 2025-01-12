import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_dashboard_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/group_dashboard_response_model.dart';

class SupervisorGroupDashboardController extends GetxController {
  final SupervisorGroupDashboardService _supervisorGroupDashboardService;
  SupervisorGroupDashboardController(this._supervisorGroupDashboardService);

  var isLoading = false.obs;

  var groupDashboard = Rxn<GroupDashboard>();

  @override
  void onInit() async {
    super.onInit();

    debugPrint("onInit");

    try {
      await fetchSupervisorGroupDashboard();
    } catch (e) {
      // Handle the error
      debugPrint("Error fetching supervisor group dashboard data : $e");
    }
  }

  Future<void> fetchSupervisorGroupDashboard() async {
    isLoading(true);

    debugPrint("fetchSupervisorGroupDashboard");

    try {
      GroupDashboardResponseModel groupDashboardResponseModel =
          await _supervisorGroupDashboardService.fetchSupervisorGroupDashboard(
        "1",
        {"filter": "filter"},
      );

      if (groupDashboardResponseModel.statusCode == 200) {
        groupDashboard.value = groupDashboardResponseModel.groupDashboard;

        // Do something
      } else {
        // Handle the error
        debugPrint(
            "Error fetching supervisor group dashboard data : ${groupDashboardResponseModel.message}");

        groupDashboard.value = null;
      }
    } catch (e) {
      // Handle the error
      debugPrint("Error fetching supervisor group dashboard data : $e");
      groupDashboard.value = null;
    } finally {
      isLoading(false);
    }
  }
}
