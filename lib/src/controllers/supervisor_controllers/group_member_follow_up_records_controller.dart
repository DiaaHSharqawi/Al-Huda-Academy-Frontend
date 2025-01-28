import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/group_member_follow_up_records_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/attendance_status/attendance_status_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/group_member_follow_up_records_response_model.dart';

class GroupMemberFollowUpRecordsController extends GetxController {
  final GroupMemberFollowUpRecordsService _groupMemberFollowUpRecordsService;

  GroupMemberFollowUpRecordsController(this._groupMemberFollowUpRecordsService);

  var isLoading = false.obs;

  var selectedDate = Rx<DateTime?>(
    DateTime.now(),
  );

  var groupId = "".obs;
  var groupMemberId = "".obs;

  var totalFollowUpRecords = 0.obs;
  var totalGroupPlans = 0.obs;

  var newestDayDate = Rxn<DateTime>();

  var previousNavigationDate = Rxn<DateTime>();
  var nextNavigationDate = Rxn<DateTime>();

  final List<AttendanceStatus> attendanceStatusList = [];
  var selectedAttendanceStatusId = Rxn<AttendanceStatus>();

  var isSubmitting = false.obs;

  TextEditingController gradeOfReviewController = TextEditingController();

  TextEditingController gradeOfMemorizeController = TextEditingController();

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

      await fetchGroupMemberFollowUpRecords();
    } catch (error) {
      debugPrint("Error during initialization: $error");
    } finally {
      isLoading(false);
    }
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
      );

      debugPrint(
          "Group Member Follow Up Records ---> : $groupMemberFollowUpRecordsResponseModel");

      if (groupMemberFollowUpRecordsResponseModel.statusCode == 200) {
        groupMemberFollowUpRecords(
            groupMemberFollowUpRecordsResponseModel.groupMemberFollowUpRecords);

        debugPrint(
            "Group Member Follow Up Records: ${groupMemberFollowUpRecords.value}");

        totalFollowUpRecords(groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecordsMetadata?.totalFollowUpRecords);

        debugPrint("Total Follow Up Records: ${totalFollowUpRecords.value}");

        totalGroupPlans(groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecordsMetadata?.totalGroupPlans!);

        debugPrint("Total Group Plans: ${totalGroupPlans.value}");

        previousNavigationDate(groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecordsMetadata!.navigation?.previous);

        debugPrint("Previous Navigation Date: ${previousNavigationDate.value}");

        nextNavigationDate(groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecordsMetadata?.navigation?.next);

        debugPrint("Next Navigation Date: ${nextNavigationDate.value}");

        selectedDate(groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecordsMetadata?.newestDayDate);

        debugPrint("Newest Day Date: ${newestDayDate.value}");

        var matchingStatus = attendanceStatusList.firstWhere((status) =>
            status.id ==
            groupMemberFollowUpRecordsResponseModel
                .groupMemberFollowUpRecords?.attendanceStatus?.id);

        debugPrint("Matching Status: $matchingStatus");

        selectedAttendanceStatusId(matchingStatus);

        gradeOfReviewController.text = groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecords!.gradeOfReview
            .toString();

        gradeOfMemorizeController.text = groupMemberFollowUpRecordsResponseModel
            .groupMemberFollowUpRecords!.gradeOfMemorization
            .toString();
      } else {
        groupMemberFollowUpRecords(null);
      }
    } catch (error) {
      debugPrint("Error: $error");
      groupMemberFollowUpRecords(null);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAttendanceStatusList() async {
    var attendanceStatusListResponse =
        await _groupMemberFollowUpRecordsService.getAttendanceStatusList();

    debugPrint("attendanceStatusListResponse");
    debugPrint(attendanceStatusListResponse.toString());

    if (attendanceStatusListResponse.isNotEmpty) {
      attendanceStatusList.addAll(attendanceStatusListResponse);
    }
  }
}
