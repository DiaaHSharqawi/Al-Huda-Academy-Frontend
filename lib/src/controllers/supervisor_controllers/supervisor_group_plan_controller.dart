import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_plan_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/group_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor_group_days/supervisor_group_days_response_model.dart';

class SupervisorGroupPlanController extends GetxController {
  final SupervisorGroupPlanService _supervisorAddGroupPlanService;

  SupervisorGroupPlanController(
    this._supervisorAddGroupPlanService,
  );

  var isLoading = false.obs;

  var groupPlanList = <GroupPlan>[].obs;

  var currentPage = 1.obs;
  var limit = 3.obs;

  var totalPages = 0.obs;

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  var supervisorGroupDaysList = <SupervisorGroupDay>[].obs;

  var queryParams = <String, dynamic>{}.obs;

  var groupId = "".obs;

  var selectedDate = DateTime.now().obs;

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

      isLoading(true);
      await getDaysList();
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
          await _supervisorAddGroupPlanService.fetchGroupPlans(
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

  Future<CreateGroupPlanResponseModel> createGroupPlan() async {
    isLoading(true);
    try {
      String nextWeekNumber =
          groupPlanList.isNotEmpty ? (groupPlanList.length).toString() : "0";

      debugPrint("Next Week Number: $nextWeekNumber");

      CreateGroupPlanResponseModel createGroupPlanResponseModel =
          await _supervisorAddGroupPlanService.createGroupPlan(
        groupId.value,
        selectedDate.value,
      );

      return createGroupPlanResponseModel;
    } catch (error) {
      debugPrint("Error createGroupPlan: $error");
      return CreateGroupPlanResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $error",
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> getDaysList() async {
    var groupDaysResponse =
        await _supervisorAddGroupPlanService.getGroupDaysList(
      groupId.value,
    );
    debugPrint("controller");
    debugPrint(groupDaysResponse.firstOrNull.toString());
    if (groupDaysResponse.isNotEmpty) {
      supervisorGroupDaysList.addAll(groupDaysResponse);
    }
  }

  void navigateToGroupPlanDetailsScreen() {
    Get.toNamed(
      AppRoutes.supervisorGroupPlanDetails,
      arguments: {
        "groupId": groupId.value,
      },
    );
  }
}
