import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_plans_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/group_plan_response_model.dart';

class SupervisorGroupPlansController extends GetxController {
  final SupervisorGroupPlansService _supervisorAddGroupPlansService;

  SupervisorGroupPlansController(
    this._supervisorAddGroupPlansService,
  );

  var isLoading = false.obs;

  var groupPlanList = <GroupPlan>[].obs;

  var currentPage = 1.obs;
  var limit = 3.obs;

  var totalPages = 0.obs;

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  var queryParams = <String, dynamic>{}.obs;

  var groupId = "".obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      groupId(Get.arguments);

      queryParams.addAll({
        "page": currentPage.value,
        "limit": limit.value,
      });

      isLoading(true);
      await fetchGroupPlans();
      isLoading(false);
    } catch (e) {
      debugPrint("Error SupervisorGroupPlanController onInit : $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchGroupPlans() async {
    isLoading(true);
    try {
      GroupPlanResponseModel groupPlanResponseModel =
          await _supervisorAddGroupPlansService.fetchGroupPlans(
        groupId.value,
        queryParams,
      );

      if (groupPlanResponseModel.statusCode == 200) {
        groupPlanList.value = groupPlanResponseModel.groupPlan;

        totalPages.value =
            groupPlanResponseModel.groupPlanMetaData!.totalPages!;
      } else {
        debugPrint(
            "Error fetching group plans: ${groupPlanResponseModel.message}");
        groupPlanList.value = [];
        totalPages.value = 0;
      }
    } catch (error) {
      debugPrint("Error fetching group plans: $error");
    } finally {
      isLoading(false);
    }
  }

  DateTime calculateNextWeekDay(int dayId, int nextWeekNumber) {
    DateTime today = DateTime.now();

    int offset = (today.weekday - dayId) % 7;

    if (offset < 0) offset += 7;

    DateTime specificDayThisWeek = today.subtract(Duration(days: offset));

    return specificDayThisWeek.add(Duration(days: 7 * nextWeekNumber));
  }

  void navigateToGroupPlanDetailsScreen() {
    Get.toNamed(
      AppRoutes.supervisorGroupPlanDetails,
      arguments: {
        "groupId": groupId.value,
      },
    );
  }

  void navigateToCreateGroupPlanScreen() {
    var result = Get.toNamed(
      AppRoutes.createGroupPlanScreen,
      arguments: {
        "groupId": groupId.value,
      },
    );
  }
}
