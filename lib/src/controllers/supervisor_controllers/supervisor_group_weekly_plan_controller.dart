import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_weekly_plan_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/group_plan_response_model.dart';

class SupervisorGroupWeeklyPlanController extends GetxController {
  final SupervisorGroupWeeklyPlanService _supervisorAddGroupWeeklyPlanService;

  SupervisorGroupWeeklyPlanController(
      this._supervisorAddGroupWeeklyPlanService);

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
      isLoading(true);

      groupId(Get.arguments);

      queryParams.addAll({
        "page": currentPage.value,
        "limit": limit.value,
      });

      await fetchGroupPlans();
    } catch (e) {
      debugPrint("Error SupervisorGroupWeeklyPlanController onInit : $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchGroupPlans() async {
    isLoading(true);
    try {
      GroupPlanResponseModel groupPlanResponseModel =
          await _supervisorAddGroupWeeklyPlanService.fetchGroupPlans(
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
}
