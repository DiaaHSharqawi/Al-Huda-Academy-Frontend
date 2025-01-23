import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_create_group_plan_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_content/group_content_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor_group_days/supervisor_group_days_response_model.dart';

class SupervisorCreateGroupPlanController extends GetxController {
  // ignore: unused_field
  final SupervisorCreateGroupPlanService _supervisorCreateGroupPlanService;

  SupervisorCreateGroupPlanController(this._supervisorCreateGroupPlanService);

  var isLoading = false.obs;

  var groupId = "".obs;

  var supervisorGroupDaysList = <SupervisorGroupDay>[].obs;

  var groupContentList = <GroupContent>[].obs;

  var selectedDate = Rx<DateTime?>(null);

  var noteController = TextEditingController();

  var selectedReviewFromSurah = 1.obs;
  var selectedReviewToSurah = 1.obs;

  var selectedReviewFromAyah = 1.obs;
  var selectedReviewToAyah = 1.obs;

//--------------------------------------------

  var selectedMemorizeFromSurah = 1.obs;
  var selectedMemorizeToSurah = 1.obs;

  var selectedMemorizeFromAyah = 1.obs;
  var selectedMemorizeToAyah = 1.obs;

  var selectedReviewContnet = [].obs;

  var selectedMemorizeContnet = [].obs;

  var isContentToReviewSelected = false.obs;

  var isContentToMemorizeSelected = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading(true);

      groupId(Get.arguments["groupId"]);

      await getDaysList();
      await getGroupContent();
    } catch (e) {
      debugPrint("Error SupervisorCreateGroupPlanController onInit : $e");
    } finally {
      isLoading(false);
    }
  }

  void resetSelectedMemorizedContent() {
    selectedMemorizeContnet.clear();

    selectedMemorizeFromSurah(1);
    selectedMemorizeToSurah(1);

    selectedMemorizeFromAyah(1);
    selectedMemorizeToAyah(1);

    isContentToMemorizeSelected(false);
  }

  void resetSelectedReviewContent() {
    selectedReviewContnet.clear();

    selectedReviewFromSurah(1);
    selectedReviewToSurah(1);

    selectedReviewFromAyah(1);
    selectedReviewToAyah(1);

    isContentToReviewSelected(false);
  }

  Future<CreateGroupPlanResponseModel> createGroupPlan() async {
    isLoading(true);
    try {
      CreateGroupPlanResponseModel createGroupPlanResponseModel =
          await _supervisorCreateGroupPlanService.createGroupPlan(
        groupId.value,
        selectedDate.value!,
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
        await _supervisorCreateGroupPlanService.getGroupDaysList(
      //groupId.value,
      "1",
    );
    debugPrint("get days list");
    debugPrint(groupDaysResponse.firstOrNull.toString());
    if (groupDaysResponse.isNotEmpty) {
      supervisorGroupDaysList.addAll(groupDaysResponse);
    }
  }

  Future<void> getGroupContent() async {
    try {
      var groupContentResponseList =
          await _supervisorCreateGroupPlanService.getGroupContent(
        groupId.value,
      );

      if (groupContentResponseList.isNotEmpty) {
        groupContentList.addAll(groupContentResponseList);
      }
    } catch (error) {
      debugPrint("Error fetching group content: $error");
    } finally {}
  }
}
