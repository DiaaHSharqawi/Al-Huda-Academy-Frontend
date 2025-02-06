import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_dashboard_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/group_dashboard_response_model.dart';

class SupervisorGroupDashboardController extends GetxController {
  final SupervisorGroupDashboardService _supervisorGroupDashboardService;
  SupervisorGroupDashboardController(this._supervisorGroupDashboardService);

  var isLoading = false.obs;

  var groupId = "".obs;

  var groupDashboard = Rxn<GroupDashboard>();

  @override
  void onInit() async {
    super.onInit();

    debugPrint("get arguments: ${Get.arguments.toString()}");

    debugPrint("onInit");

    try {
      debugPrint("get arguments: ${Get.arguments.toString()}");
      groupId.value = Get.arguments!;

      debugPrint("Group ID: ${groupId.value}");

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
        groupId.value,
        {},
      );

      debugPrint("groupDashboardResponseModel: $groupDashboardResponseModel");

      if (groupDashboardResponseModel.statusCode == 200) {
        groupDashboard.value = groupDashboardResponseModel.groupDashboard;
      } else {
        debugPrint(
            "Error fetching supervisor group dashboard data : ${groupDashboardResponseModel.message}");

        groupDashboard.value = null;
      }
    } catch (e) {
      debugPrint("Error fetching supervisor group dashboard data : $e");
      groupDashboard.value = null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> navigateToGroupJoinRequestScreen(String groupId) async {
    debugPrint("Navigate to Group Join Request Screen");
    debugPrint("Group ID: $groupId");

    var result = await Get.toNamed(
      AppRoutes.supervisorGroupJoinRequest,
      arguments: groupId,
    );

    debugPrint("result *--->: $result");

    debugPrint("shouldRefreshData ");
    groupDashboard.value = null;
    await fetchSupervisorGroupDashboard();
  }

  void navigateToGroupMembersScreen(String groupId) {
    debugPrint("Navigate to Group Members Screen");
    debugPrint("Group ID: $groupId");

    Get.toNamed(
      AppRoutes.supervisorGroupMembership,
      arguments: groupId,
    );
  }

  Future<void> navigateToGroupPlanScreen(String groupId) async {
    debugPrint("Navigate to Group  Plan Screen");
    debugPrint("Group ID: $groupId");

    var result = await Get.toNamed(
      AppRoutes.supervisorGroupPlanScreen,
      arguments: {
        "groupId": groupId,
      },
    );

    debugPrint("result *--->: $result");

    debugPrint("shouldRefreshData ");

    if (result != null) {
      groupDashboard.value = null;
      await fetchSupervisorGroupDashboard();
    }
  }

  Future<void> navigateToGroupPlanDetails(String groupId, groupPlanId) async {
    debugPrint("Navigate to Group Plan Details Screen");
    debugPrint("Group ID: $groupId");
    debugPrint("Group Plan ID: $groupPlanId");

    var result = await Get.toNamed(
      AppRoutes.supervisorGroupPlanDetails,
      arguments: {
        "groupId": groupId.toString(),
        "planId": groupPlanId.toString(),
      },
    );

    debugPrint("result *--->: $result");

    debugPrint("shouldRefreshData ");

    groupDashboard.value = null;
    await fetchSupervisorGroupDashboard();
  }

  Future<void> navigateToCreateGroupPlanScreen(DateTime dateTime) async {
    var result = await Get.toNamed(
      AppRoutes.createGroupPlanScreen,
      arguments: {
        "groupId": groupId.value,
        "selectedDate": dateTime.toString(),
      },
    );

    debugPrint("Result back to group plans: $result");

    // refresh the dashboard
    await fetchSupervisorGroupDashboard();
  }
}
