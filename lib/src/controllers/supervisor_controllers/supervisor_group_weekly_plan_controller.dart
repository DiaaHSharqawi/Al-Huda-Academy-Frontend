import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_weekly_plan_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_weekly_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/group_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor_group_days/supervisor_group_days_response_model.dart';

class SupervisorGroupWeeklyPlanController extends GetxController {
  final SupervisorGroupWeeklyPlanService _supervisorAddGroupWeeklyPlanService;

  SupervisorGroupWeeklyPlanController(
    this._supervisorAddGroupWeeklyPlanService,
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

  DateTime calculateNextWeekDay(int dayId, int nextWeekNumber) {
    DateTime today = DateTime.now();

    int offset = (today.weekday - dayId) % 7;

    if (offset < 0) offset += 7;

    DateTime specificDayThisWeek = today.subtract(Duration(days: offset));

    return specificDayThisWeek.add(Duration(days: 7 * nextWeekNumber));
  }

  Future<CreateGroupWeeklyPlanResponseModel> createGroupWeeklyPlan() async {
    isLoading(true);
    try {
      String nextWeekNumber =
          groupPlanList.isNotEmpty ? (groupPlanList.length).toString() : "0";

      debugPrint("Next Week Number: $nextWeekNumber");

      DateTime result = calculateNextWeekDay(
          (supervisorGroupDaysList.first.dayId! - 1),
          int.parse(nextWeekNumber));

      CreateGroupWeeklyPlanResponseModel createGroupWeeklyPlanResponseModel =
          await _supervisorAddGroupWeeklyPlanService.createGroupWeeklyPlan(
              groupId.value,
              nextWeekNumber,
              groupPlanList.isNotEmpty
                  ? groupPlanList.first.startWeekDayDate!
                      .add(Duration(days: 7 * int.parse(nextWeekNumber)))
                  : result);

      return createGroupWeeklyPlanResponseModel;
    } catch (error) {
      debugPrint("Error createGroupWeeklyPlan: $error");
      return CreateGroupWeeklyPlanResponseModel(
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
        await _supervisorAddGroupWeeklyPlanService.getGroupDaysList(
      groupId.value,
    );
    debugPrint("controller");
    debugPrint(groupDaysResponse.firstOrNull.toString());
    if (groupDaysResponse.isNotEmpty) {
      supervisorGroupDaysList.addAll(groupDaysResponse);
    }
  }

  void navigateToCreateGroupWeeklyPlanScreen() {
    Get.toNamed(
      AppRoutes.supervisorCreateGroupWeeklyPlan,
      arguments: {
        "groupId": groupId.value,
      },
    );
  }
}
