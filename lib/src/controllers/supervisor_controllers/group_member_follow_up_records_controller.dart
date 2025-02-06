import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/group_member_follow_up_records_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/attendance_status/attendance_status_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/create_group_members_follow_up_records_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/delete_group_members_follow_up_records_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/group_member_follow_up_records_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/update_group_members_follow_up_records_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan_dates/group_plan_dates_response_model.dart';

class GroupMemberFollowUpRecordsController extends GetxController {
  final GroupMemberFollowUpRecordsService _groupMemberFollowUpRecordsService;

  GroupMemberFollowUpRecordsController(this._groupMemberFollowUpRecordsService);

  var isLoading = false.obs;

  var selectedDate = Rx<DateTime?>(null);

  var isEditingGradeOfReview = false.obs;
  var isEditingGradeOfMemorize = false.obs;

  var groupId = "".obs;
  var groupMemberId = "".obs;
  var recordId = "".obs;

  var totalFollowUpRecords = 0.obs;
  // var totalGroupPlans = 0.obs;

  var dayDateToUse = Rxn<DateTime>();

  var previousNavigationDate = Rxn<DateTime>();
  var nextNavigationDate = Rxn<DateTime>();

  final List<AttendanceStatus> attendanceStatusList = [];
  var selectedAttendanceStatusId = Rxn<AttendanceStatus>();

  var groupPlan = Rxn<GroupPlan>();

  final List<GroupPlanDate> groupPlanDates = [];

  var isSubmitting = false.obs;

  var isEdited = false.obs;

  TextEditingController gradeOfReviewController = TextEditingController();

  TextEditingController gradeOfMemorizeController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  var queryParams = <String, dynamic>{}.obs;

  var absentAttendanceStatusId = "".obs;
  var absentWithExcuseStatusId = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    isLoading(true);

    debugPrint("Arguments: ${Get.arguments}");

    try {
      debugPrint("Get.arguments: ${Get.arguments["groupMemberId"]}");
      debugPrint("Get.arguments: ${Get.arguments["groupId"]}");

      groupMemberId(Get.arguments["groupMemberId"]);
      groupId(Get.arguments["groupId"]);

      debugPrint("Group Member ID: ${groupMemberId.value}");
      debugPrint("Group ID: ${groupId.value}");

      await getAttendanceStatusList();

      await groupPlanDatesList();

      await fetchGroupMemberFollowUpRecords();

      everValuesEditedEver();
    } catch (error) {
      debugPrint("Error during initialization: $error");
    } finally {
      isLoading(false);
    }
  }

  void everValuesEditedEver() {
    gradeOfMemorizeController.addListener(() {
      debugPrint("Memorize Changed: ${gradeOfMemorizeController.text}");
      isEdited(true);
    });

    gradeOfReviewController.addListener(() {
      debugPrint("Review Changed: ${gradeOfReviewController.text}");
      isEdited(true);
    });

    ever(selectedAttendanceStatusId, (_) {
      debugPrint(
          "selectedAttendanceStatusId: ${selectedAttendanceStatusId.value}");
      isEdited(true);
    });

    noteController.addListener(() {
      debugPrint("Note Changed: ${noteController.text}");
      isEdited(true);
    });
  }

  var groupMemberFollowUpRecords = Rxn<GroupMemberFollowUpRecord>();
  Future<void> fetchGroupMemberFollowUpRecords() async {
    isLoading(true);
    try {
      GroupMemberFollowUpRecordsResponseModel
          groupMemberFollowUpRecordsResponseModel =
          await _groupMemberFollowUpRecordsService
              .fetchGroupMemberFollowUpRecords(
        groupId: groupId.value,
        groupMemberId: groupMemberId.value,
        filter: queryParams,
      );

      debugPrint(
          "Group Member Follow Up Records ---> : ${groupMemberFollowUpRecordsResponseModel.toJson()}");

      debugPrint(
          "group member meta :${groupMemberFollowUpRecordsResponseModel.groupMemberFollowUpRecordsMetadata?.toJson().toString()}");

      if (groupMemberFollowUpRecordsResponseModel.statusCode == 200) {
        debugPrint(
            "Group Member Follow Up Records: ${groupMemberFollowUpRecordsResponseModel.groupMemberFollowUpRecords}");

        if (groupMemberFollowUpRecordsResponseModel
                .groupMemberFollowUpRecords !=
            null) {
          groupMemberFollowUpRecords.value =
              groupMemberFollowUpRecordsResponseModel
                  .groupMemberFollowUpRecords;

          var matchingStatus = attendanceStatusList.firstWhere((status) =>
              status.id ==
              groupMemberFollowUpRecordsResponseModel
                  .groupMemberFollowUpRecords?.attendanceStatus?.id);

          debugPrint("Matching Status: $matchingStatus");

          selectedAttendanceStatusId.value = matchingStatus;

          recordId.value = groupMemberFollowUpRecordsResponseModel
              .groupMemberFollowUpRecords!.id
              .toString();

          debugPrint("recordId: ${recordId.value}");

          gradeOfReviewController.text = groupMemberFollowUpRecordsResponseModel
                  .groupMemberFollowUpRecords?.gradeOfReview
                  ?.toString() ??
              '';

          debugPrint(
              "gradeOfReviewController.text: ${gradeOfReviewController.text}");

          debugPrint(
              "hiiiii --->: ${groupMemberFollowUpRecordsResponseModel.groupMemberFollowUpRecords?.note}");

          noteController.text = groupMemberFollowUpRecordsResponseModel
                  .groupMemberFollowUpRecords?.note
                  .toString() ??
              '';

          debugPrint("noteController.text: ${noteController.toString()}");

          gradeOfMemorizeController.text =
              groupMemberFollowUpRecordsResponseModel
                      .groupMemberFollowUpRecords!.gradeOfMemorization
                      ?.toString() ??
                  "";
          debugPrint(
              "gradeOfMemorizeController.text: ${gradeOfMemorizeController.text}");
        } else {
          groupMemberFollowUpRecords.value = null;
          gradeOfMemorizeController.text = "";
          gradeOfReviewController.text = "";

          noteController.text = "";

          groupPlan.value = groupMemberFollowUpRecordsResponseModel.groupPlan;

          isEditingGradeOfReview(true);
          isEditingGradeOfMemorize(true);
        }

        debugPrint(
            "Group Member Follow Up Records: ${groupMemberFollowUpRecords.value}");

        totalFollowUpRecords(groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecordsMetadata?.totalFollowUpRecords);

        debugPrint("Total Follow Up Records: ${totalFollowUpRecords.value}");

        // --------
        debugPrint("=-=-");
        debugPrint(
            "Navigation: ${groupMemberFollowUpRecordsResponseModel.groupMemberFollowUpRecordsMetadata?.navigation}");

        var navigation = groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecordsMetadata?.navigation;

        if (navigation?.previous == null) {
          previousNavigationDate.value = null;
        } else {
          previousNavigationDate.value = navigation?.previous;
          debugPrint(
              "Previous Navigation Date: ${previousNavigationDate.value}");
        }

        if (navigation?.next == null) {
          debugPrint("next null");
          nextNavigationDate.value = null;
        } else {
          nextNavigationDate.value = navigation?.next;
          debugPrint("Next Navigation Date: ${nextNavigationDate.value}");
        }

        if (groupMemberFollowUpRecordsResponseModel
                .groupMemberFollowUpRecordsMetadata?.dayDateToUse ==
            null) {
          dayDateToUse.value = null;
        } else {
          dayDateToUse.value = groupMemberFollowUpRecordsResponseModel
              .groupMemberFollowUpRecordsMetadata?.dayDateToUse;
        }

        debugPrint("Newest Day Date: ${dayDateToUse.value.toString()}");

        if (groupMemberFollowUpRecordsResponseModel
                .groupMemberFollowUpRecordsMetadata?.dayDateToUse ==
            null) {
          dayDateToUse.value = null;
        } else {
          dayDateToUse.value = groupMemberFollowUpRecordsResponseModel
              .groupMemberFollowUpRecordsMetadata?.dayDateToUse;

          selectedDate = dayDateToUse;
        }

        debugPrint("Newest Day Date: ${dayDateToUse.value.toString()}");

        debugPrint("Previous Navigation Date: ${previousNavigationDate.value}");
        debugPrint("Next Navigation Date: ${nextNavigationDate.value}");
      } else {
        groupMemberFollowUpRecords(null);
      }
    } catch (error) {
      debugPrint("Error: $error");
      groupMemberFollowUpRecords(null);
    } finally {
      isLoading(false);
      isEdited(false);
    }
  }

  Future<void> getAttendanceStatusList() async {
    var attendanceStatusListResponse =
        await _groupMemberFollowUpRecordsService.getAttendanceStatusList();

    debugPrint("attendanceStatusListResponse");
    debugPrint(attendanceStatusListResponse.toString());

    if (attendanceStatusListResponse.isNotEmpty) {
      attendanceStatusList.addAll(attendanceStatusListResponse);

      absentAttendanceStatusId = attendanceStatusListResponse
          .firstWhere((element) => element.nameEn == "absent")
          .id
          .toString()
          .obs;

      debugPrint("absentAttendanceStatusId: $absentAttendanceStatusId");

      absentWithExcuseStatusId = attendanceStatusListResponse
          .firstWhere((element) => element.nameEn == "absent with excuse")
          .id
          .toString()
          .obs;

      debugPrint("absentWithExcuseStatusId: $absentWithExcuseStatusId");
    }
  }

  Future<void> groupPlanDatesList() async {
    var groupPlanDatesListResponse = await _groupMemberFollowUpRecordsService
        .groupPlanDatesList(groupId.value);

    debugPrint(
        "groupPlanDatesListResponse : ${groupPlanDatesListResponse.toList()}");

    if (groupPlanDatesListResponse.isNotEmpty) {
      groupPlanDates.addAll(groupPlanDatesListResponse);
    }
  }

  Future<CreateGroupMembersFollowUpRecordsResponseModel>
      createGroupMemberFollowUpRecords() async {
    debugPrint(" ----> createGroupMemberFollowUpRecords");

    isSubmitting(true);

    debugPrint(
        'gradeOfReviewController: ${gradeOfReviewController.text.toString().runtimeType}');
    debugPrint(
        'gradeOfMemorizeController: ${gradeOfMemorizeController.text.toString()}');
    debugPrint(
        'attendanceStatusId: ${selectedAttendanceStatusId.value?.id.toString()}');

    if ([absentAttendanceStatusId.value, absentWithExcuseStatusId.value]
        .contains(selectedAttendanceStatusId.value?.id.toString())) {
      gradeOfReviewController.text = "0";
      gradeOfMemorizeController.text = "0";
    }

    final error = Validations.validateAll({
      'gradeOfReview': gradeOfReviewController.text,
      'gradeOfMemorize': gradeOfMemorizeController.text,
      'attendanceStatusId':
          selectedAttendanceStatusId.value?.id.toString() ?? "",
    });

    debugPrint("error: $error");

    if (error != null) {
      return CreateGroupMembersFollowUpRecordsResponseModel(
        success: false,
        statusCode: 500,
        message: error.values.join(",\n "),
      );
    }

    isLoading(true);
    try {
      debugPrint("groupPlanDates: $groupPlanDates");

      debugPrint("selectedDate: ${selectedDate.value}");

      var groupPlanId = groupPlanDates
              .firstWhere(
                (element) =>
                    element.dayDate?.day == selectedDate.value?.day &&
                    element.dayDate?.month == selectedDate.value?.month &&
                    element.dayDate?.year == selectedDate.value?.year,
              )
              .id
              ?.toString() ??
          '';

      debugPrint("groupPlanId ----> : $groupPlanId");

      debugPrint({
        "group_plan_id": groupPlanId,
        'grade_of_memorization': gradeOfMemorizeController.text,
        'grade_of_review': gradeOfReviewController.text,
        'attendance_status_id': selectedAttendanceStatusId.value?.id.toString(),
        // 'note': '',
      }.toString());

      CreateGroupMembersFollowUpRecordsResponseModel
          createGroupMembersFollowUpRecordsResponseModel =
          await _groupMemberFollowUpRecordsService
              .createGroupMembersFollowUpRecords(
        data: {
          'groupId': groupId.value,
          'groupMemberId': groupMemberId.value,
          'group_plan_id': groupPlanId,
          'grade_of_memorization': gradeOfMemorizeController.text,
          'grade_of_review': gradeOfReviewController.text,
          'attendance_status_id':
              selectedAttendanceStatusId.value?.id.toString(),
          'note': noteController.text,
        },
      );

      return createGroupMembersFollowUpRecordsResponseModel;
    } catch (error) {
      debugPrint(
          "Error CreateGroupMembersFollowUpRecordsResponseModel: $error");

      return CreateGroupMembersFollowUpRecordsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $error",
      );
    } finally {
      isLoading(false);
      isSubmitting(false);
    }
  }

  Future<UpdateGroupMembersFollowUpRecordsResponseModel>
      updateGroupMemberFollowUpRecords() async {
    debugPrint(" ----> updateGroupMemberFollowUpRecords");

    isSubmitting(true);

    debugPrint(
        'gradeOfReviewController: ${gradeOfReviewController.text.toString().runtimeType}');
    debugPrint(
        'gradeOfMemorizeController: ${gradeOfMemorizeController.text.toString()}');
    debugPrint(
        'attendanceStatusId: ${selectedAttendanceStatusId.value?.id.toString()}');

    final error = Validations.validateAll({
      'gradeOfReview': gradeOfReviewController.text,
      'gradeOfMemorize': gradeOfMemorizeController.text,
      'attendanceStatusId':
          selectedAttendanceStatusId.value?.id.toString() ?? "",
    });

    debugPrint("error: $error");

    if (error != null) {
      return UpdateGroupMembersFollowUpRecordsResponseModel(
        success: false,
        statusCode: 500,
        message: error.values.join(",\n "),
      );
    }

    isLoading(true);
    try {
      debugPrint("groupPlanDates: $groupPlanDates");

      debugPrint("selectedDate: ${selectedDate.value}");

      var groupPlanId = groupPlanDates
              .firstWhere(
                (element) =>
                    element.dayDate?.day == selectedDate.value?.day &&
                    element.dayDate?.month == selectedDate.value?.month &&
                    element.dayDate?.year == selectedDate.value?.year,
              )
              .id
              ?.toString() ??
          '';

      debugPrint("groupPlanId ----> : $groupPlanId");

      debugPrint({
        "group_plan_id": groupPlanId,
        'grade_of_memorization': gradeOfMemorizeController.text,
        'grade_of_review': gradeOfReviewController.text,
        'attendance_status_id': selectedAttendanceStatusId.value?.id.toString(),
        // 'note': '',
      }.toString());

      UpdateGroupMembersFollowUpRecordsResponseModel
          updateGroupMembersFollowUpRecordsResponseModel =
          await _groupMemberFollowUpRecordsService
              .updateGroupMembersFollowUpRecords(
        data: {
          'recordId': recordId.value,
          'groupId': groupId.value,
          'groupMemberId': groupMemberId.value,
          'grade_of_memorization': gradeOfMemorizeController.text,
          'grade_of_review': gradeOfReviewController.text,
          'attendance_status_id':
              selectedAttendanceStatusId.value?.id.toString(),
          'note': noteController.text,
        },
      );

      isEdited(false);

      return updateGroupMembersFollowUpRecordsResponseModel;
    } catch (error) {
      debugPrint("Error updateGroupMemberFollowUpRecords: $error");

      return UpdateGroupMembersFollowUpRecordsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $error",
      );
    } finally {
      isLoading(false);
      isSubmitting(false);
    }
  }

  Future<DeleteGroupMembersFollowUpRecordsResponseModel>
      deleteGroupMemberFollowUpRecords() async {
    debugPrint(" ----> deleteGroupMemberFollowUpRecords");

    isSubmitting(true);

    isLoading(true);
    try {
      DeleteGroupMembersFollowUpRecordsResponseModel
          deleteGroupMembersFollowUpRecordsResponseModel =
          await _groupMemberFollowUpRecordsService
              .deleteGroupMembersFollowUpRecords(
        data: {
          'recordId': recordId.value,
          'groupId': groupId.value,
          'groupMemberId': groupMemberId.value,
        },
      );

      isEdited(false);

      return deleteGroupMembersFollowUpRecordsResponseModel;
    } catch (error) {
      debugPrint(
          "Error deleteGroupMembersFollowUpRecordsResponseModel: $error");

      return DeleteGroupMembersFollowUpRecordsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $error",
      );
    } finally {
      isLoading(false);
      isSubmitting(false);
    }
  }

  void navigateToGroupMemberScreen() {
    Get.back(
      result: true,
    );
  }
}
