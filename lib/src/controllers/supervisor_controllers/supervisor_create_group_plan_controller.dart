import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_create_group_plan_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/geoup_plan_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_content/group_content_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor_group_days/supervisor_group_days_response_model.dart';

class SupervisorCreateGroupPlanController extends GetxController {
  // ignore: unused_field
  final SupervisorCreateGroupPlanService _supervisorCreateGroupPlanService;

  SupervisorCreateGroupPlanController(this._supervisorCreateGroupPlanService);

  var isLoading = false.obs;

  var isSubmitting = false.obs;

  var groupId = "".obs;

  var supervisorGroupDaysList = <SupervisorGroupDay>[].obs;

  var groupContentList = <GroupContent>[].obs;

  var selectedDate = Rx<DateTime?>(null);

  var noteController = TextEditingController();

  var selectedReviewSurah = 1.obs;

  var selectedReviewFromAyah = 1.obs;
  var selectedReviewToAyah = 7.obs;

//--------------------------------------------

  var selectedMemorizeSurah = 1.obs;

  var selectedMemorizeFromAyah = 1.obs;
  var selectedMemorizeToAyah = 7.obs;

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
    selectedMemorizeSurah(1);

    selectedMemorizeFromAyah(1);
    selectedMemorizeToAyah(1);
  }

  void resetSelectedReviewContent() {
    selectedReviewSurah(1);

    selectedReviewFromAyah(1);
    selectedReviewToAyah(1);
  }

  Future<CreateGroupPlanResponseModel> createGroupPlan() async {
    debugPrint("createGroupPlan");

    isSubmitting(true);

    debugPrint("selectedDate: ${selectedDate.value}");

    if (selectedMemorizeContnet.isEmpty && selectedReviewContnet.isEmpty) {
      return CreateGroupPlanResponseModel(
        success: false,
        statusCode: 500,
        message: "يجب ان تختار على الاقل محتوى للمراجعة او للحفظ ",
      );
    }

    if (selectedDate.value == null) {
      return CreateGroupPlanResponseModel(
        success: false,
        statusCode: 500,
        message: "يجب ان تختار تاريخ يوم الخطة",
      );
    }
    final error = GeoupPlanValidations.validateAll({
      'dayDate': selectedDate.value.toString(),
    });

    debugPrint("error: $error");

    if (error != null) {
      Get.snackbar(
        "Error",
        error['dayDate']!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isSubmitting(false);
      return CreateGroupPlanResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: ${error['dayDate']}",
      );
    }

    isLoading(true);
    try {
      var selectedMemorizeContnetList = selectedMemorizeContnet.map((content) {
        return {
          'surahId': content['surahId'].toString(),
          'startAyah': content['startAyah'],
          'endAyah': content['endAyah'],
        };
      }).toList();

      var selectedReviewContnetList = selectedReviewContnet.map((content) {
        return {
          'surahId': content['surahId'].toString(),
          'startAyah': content['startAyah'],
          'endAyah': content['endAyah'],
        };
      }).toList();

      CreateGroupPlanResponseModel createGroupPlanResponseModel =
          await _supervisorCreateGroupPlanService.createGroupPlan(
        groupId.value,
        selectedDate.value!,
        selectedMemorizeContnetList,
        selectedReviewContnetList,
        "asdsad",
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
      isSubmitting(false);
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

  void navigateToGroupPlanScreen() {
    Get.back(
      result: true,
    );
  }
}
