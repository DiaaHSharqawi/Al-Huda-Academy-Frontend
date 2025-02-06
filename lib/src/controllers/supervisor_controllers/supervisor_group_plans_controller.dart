import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/group_services/group_plan_services/supervisor_group_plans_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
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

  var fromDateController = Rxn<DateTime>();
  var toDateController = Rxn<DateTime>();

  var sortOrder = SortOrder.ascending.obs;

  var isFilterApplied = false.obs;

  @override
  void onInit() async {
    super.onInit();

    debugPrint("SupervisorGroupPlansController onInit");

    try {
      debugPrint("Arguments: ${Get.arguments}");

      groupId(Get.arguments["groupId"]);

      queryParams.addAll({
        "page": currentPage.value,
        "limit": limit.value,
      });

      await fetchGroupPlans();
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

      debugPrint("Group plans: ${groupPlanResponseModel.toJson()}");

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

  Future<void> navigateToGroupPlanDetailsScreen(String planId) async {
    var result = await Get.toNamed(
      AppRoutes.supervisorGroupPlanDetails,
      arguments: {
        "groupId": groupId.value,
        "planId": planId,
      },
    );

    debugPrint("Result: $result");

    if (result != null) {
      await fetchGroupPlans();
    }
  }

  Future<void> navigateToCreateGroupPlanScreen() async {
    var result = await Get.toNamed(
      AppRoutes.createGroupPlanScreen,
      arguments: {
        "groupId": groupId.value,
      },
    );

    debugPrint("Result back to group plans: $result");

    // refresh the group plans list
    await fetchGroupPlans();
  }

  void applyFilters() {
    debugPrint("Apply filters");

    isFilterApplied(true);

    if (fromDateController.value != null) {
      queryParams["fromDate"] = fromDateController.value;
    }

    if (toDateController.value != null) {
      queryParams["toDate"] = toDateController.value;
    }

    if (sortOrder.value != SortOrder.notSelected) {
      queryParams["sortOrder"] =
          sortOrder.value == SortOrder.ascending ? "asc" : "desc";
    }
  }

  Future<void> clearFilters() async {
    debugPrint("Clear filters");
    isFilterApplied(false);

    fromDateController.value = null;
    toDateController.value = null;
    sortOrder.value = SortOrder.descending;

    queryParams.remove("fromDate");
    queryParams.remove("toDate");
    queryParams.remove("sortOrder");

    await fetchGroupPlans();
  }
}
