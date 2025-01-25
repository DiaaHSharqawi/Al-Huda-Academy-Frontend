import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_plan_details_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/geoup_plan_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_content/group_content_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/delete_group_plan_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/edit_group_plan_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/group_plan_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor_group_days/supervisor_group_days_response_model.dart';

class SupervisorGroupPlanDetailsController extends GetxController {
  final SupervisorGroupPlanDetailsService _supervisorCreateGroupPlanService;

  SupervisorGroupPlanDetailsController(
    this._supervisorCreateGroupPlanService,
  );

  var isLoading = false.obs;

  var groupId = "".obs;
  var groupPlanId = "".obs;

  var isSubmitting = false.obs;

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

  var groupPlanDetails = Rxn<GroupPlanDetails>();

  var isContentChanged = false.obs;

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

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading(true);

      debugPrint(Get.arguments.toString());

      groupId(Get.arguments["groupId"]);
      groupPlanId(Get.arguments["planId"]);

      await fetchGroupPlanDetails();

      await getDaysList();

      await getGroupContent();

      everContentListenChanged();
    } catch (error) {
      debugPrint("Error SupervisorGroupPlanDetailsController onInit : $error");
    } finally {
      isLoading(false);
    }
  }

  void everContentListenChanged() {
    ever(selectedDate, (_) {
      isContentChanged(true);

      debugPrint('Selected date changed: $selectedDate');
    });

    ever(selectedReviewContnet, (_) {
      isContentChanged(true);

      debugPrint('Selected review content changed: $selectedReviewContnet');
    });

    ever(selectedMemorizeContnet, (_) {
      isContentChanged(true);

      debugPrint('Selected memorize content changed: $selectedMemorizeContnet');
    });

    ever(noteController.text.obs, (_) {
      isContentChanged(true);

      debugPrint('Note: ${noteController.text}');
    });
  }

  Future<void> fetchGroupPlanDetails() async {
    debugPrint("Fetching group plan details");

    isLoading(true);
    try {
      GroupPlanDetailsResponseModel groupPlanResponseModel =
          await _supervisorCreateGroupPlanService.fetchGroupPlanDetails(
        groupId.value,
        groupPlanId.value,
      );

      debugPrint(
          "Group Plan Response controller Model: $groupPlanResponseModel");

      if (groupPlanResponseModel.statusCode == 200) {
        groupPlanDetails.value = groupPlanResponseModel.groupPlanDetails;

        selectedDate(groupPlanDetails.value!.dayDate);

        selectedReviewContnet.addAll(
          groupPlanDetails.value!.contentToReviews.map((content) {
            debugPrint("Content: ${content.toJson()}");

            return RxMap<dynamic, dynamic>({
              'surahId': content.surahId,
              'surahName': content.surah!.name!,
              'startAyah': content.startAyah,
              'endAyah': content.endAyah,
            });
          }).toList(),
        );

        selectedMemorizeContnet
            .addAll(groupPlanDetails.value!.contentToMemorizes.map((content) {
          return RxMap<dynamic, dynamic>({
            'surahId': content.surahId,
            'surahName': content.surah!.name!,
            'startAyah': content.startAyah,
            'endAyah': content.endAyah,
          });
        }));

        noteController.text = groupPlanDetails.value!.note ?? "";

        selectedReviewContnet.refresh();
        selectedMemorizeContnet.refresh();

        debugPrint("Selected Memorize Content: $selectedMemorizeContnet");
        debugPrint("Selected Review Content: $selectedReviewContnet");

        debugPrint("Selected Date: ${selectedDate.value}");

        debugPrint("Group Plan Details: ${groupPlanDetails.value}");
      } else {
        debugPrint("Failed to get group plan details");
        groupPlanDetails.value = null;
      }
    } catch (error) {
      debugPrint("Error SupervisorCreateGroupPlanController onInit : $error");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getDaysList() async {
    var groupDaysResponse =
        await _supervisorCreateGroupPlanService.getGroupDaysList(
      groupId.value,
    );
    debugPrint("get days list");
    debugPrint(groupDaysResponse.toString());
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

  Future<EditGroupPlanDetailsResponseModel> editGroupPlan() async {
    debugPrint("editGroupPlan");

    isSubmitting(true);

    debugPrint("selectedDate: ${selectedDate.value}");

    if (selectedMemorizeContnet.isEmpty && selectedReviewContnet.isEmpty) {
      return EditGroupPlanDetailsResponseModel(
        success: false,
        statusCode: 500,
        message: "يجب ان تختار على الاقل محتوى للمراجعة او للحفظ ",
      );
    }

    if (selectedDate.value == null) {
      return EditGroupPlanDetailsResponseModel(
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
      return EditGroupPlanDetailsResponseModel(
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

      EditGroupPlanDetailsResponseModel editGroupPlanDetailsResponseModel =
          await _supervisorCreateGroupPlanService.editGroupPlan(
        groupId.value,
        groupPlanId.value,
        selectedDate.value!,
        selectedMemorizeContnetList,
        selectedReviewContnetList,
        noteController.text,
      );

      return editGroupPlanDetailsResponseModel;
    } catch (error) {
      debugPrint("Error editGroupPlanDetailsResponseModel: $error");
      return EditGroupPlanDetailsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $error",
      );
    } finally {
      isLoading(false);
      isSubmitting(false);
    }
  }

  Future<DeleteGroupPlanDetailsResponseModel> deleteGroupPlan() async {
    debugPrint("deleteGroupPlan");

    isSubmitting(true);

    isLoading(true);
    try {
      DeleteGroupPlanDetailsResponseModel deleteGroupPlanDetailsResponseModel =
          await _supervisorCreateGroupPlanService.deleteGroupPlan(
        groupId.value,
        groupPlanId.value,
      );

      return deleteGroupPlanDetailsResponseModel;
    } catch (error) {
      debugPrint("Error deleteGroupPlanDetailsResponseModel: $error");
      return DeleteGroupPlanDetailsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $error",
      );
    } finally {
      isLoading(false);
      isSubmitting(false);
    }
  }

  void navigateToGroupPlanScreen() {
    Get.back(
      result: true,
    );
  }
}
