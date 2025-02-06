import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/attendance_status/attendance_status_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/create_group_members_follow_up_records_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/delete_group_members_follow_up_records_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/group_member_follow_up_records_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/update_group_members_follow_up_records_response_model.dart';
import 'dart:convert';

import 'package:moltqa_al_quran_frontend/src/data/model/group_plan_dates/group_plan_dates_response_model.dart';

class GroupMemberFollowUpRecordsService extends BaseGetxService {
  Future<GroupMemberFollowUpRecordsResponseModel>
      fetchGroupMemberFollowUpRecords(
          {required String groupId,
          required String groupMemberId,
          required Map<String, dynamic> filter}) async {
    debugPrint("fetchGroupMemberFollowUpRecords Service");

    debugPrint("groupId: $groupId");
    debugPrint("groupMemberId: $groupMemberId");

    String groupMemberFollowUpRecordsRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/members/$groupMemberId/follow-up-records";

    final url = Uri.parse(groupMemberFollowUpRecordsRoute);

    final queryParameters =
        filter.map((key, value) => MapEntry(key, value.toString()));

    debugPrint("Query Parameters: $queryParameters");
    debugPrint("Final URL: ${url.replace(queryParameters: queryParameters)}");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      debugPrint("Final URL: $url");

      debugPrint("Token: ${await super.getToken()}");

      final response = await http.get(
        url.replace(queryParameters: queryParameters),
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
          'Authorization': (await super.getToken()).toString(),
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      GroupMemberFollowUpRecordsResponseModel
          groupMemberFollowUpRecordsResponseModel =
          GroupMemberFollowUpRecordsResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "groupMemberFollowUpRecordsResponseModel: $groupMemberFollowUpRecordsResponseModel");

      return groupMemberFollowUpRecordsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return GroupMemberFollowUpRecordsResponseModel(
        success: null,
        statusCode: 500,
        groupPlan: null,
        message: "Error: $e",
        groupMemberFollowUpRecordsMetadata: null,
        groupMemberFollowUpRecords: null,
      );
    }
  }

  Future<CreateGroupMembersFollowUpRecordsResponseModel>
      createGroupMembersFollowUpRecords(
          {required Map<String, dynamic> data}) async {
    String groupId = data['groupId'];

    String groupMemberId = data['groupMemberId'];

    String createGroupMembersFollowUpRecordsRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/members/$groupMemberId/follow-up-records/create";

    final url = Uri.parse(createGroupMembersFollowUpRecordsRoute);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      debugPrint("Final URL: $url");

      debugPrint("Token: ${await super.getToken()}");

      final response = await http
          .post(
            url,
            headers: <String, String>{
              'Accept-Language': lang ?? 'en',
              'Authorization': (await super.getToken()).toString(),
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "group_plan_id": data['group_plan_id'].toString(),
              "grade_of_memorization":
                  double.parse(data['grade_of_memorization'].toString()),
              "grade_of_review":
                  double.parse(data['grade_of_review'].toString()),
              "attendance_status_id": data['attendance_status_id'].toString(),
              "note": data['note'].toString(),
            }),
          )
          .timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> responseData = json.decode(response.body);

      CreateGroupMembersFollowUpRecordsResponseModel
          createGroupMembersFollowUpRecordsResponseModel =
          CreateGroupMembersFollowUpRecordsResponseModel.fromJson(
              responseData, response.statusCode);

      debugPrint("Data: $responseData");
      debugPrint(
          "createGroupMembersFollowUpRecordsResponseModel: $createGroupMembersFollowUpRecordsResponseModel");

      return createGroupMembersFollowUpRecordsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return CreateGroupMembersFollowUpRecordsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $e",
      );
    }
  }

  Future<UpdateGroupMembersFollowUpRecordsResponseModel>
      updateGroupMembersFollowUpRecords(
          {required Map<String, dynamic> data}) async {
    String groupId = data['groupId'];

    String recordId = data['recordId'];

    String groupMemberId = data['groupMemberId'];

    debugPrint("groupId: $groupId");
    debugPrint("groupMemberId: $groupMemberId");

    String updateGroupMembersFollowUpRecordsRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/members/$groupMemberId/follow-up-records/$recordId/update";

    final url = Uri.parse(updateGroupMembersFollowUpRecordsRoute);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      debugPrint("Final URL: $url");

      debugPrint("Token: ${await super.getToken()}");

      final response = await http
          .patch(
            url,
            headers: <String, String>{
              'Accept-Language': lang ?? 'en',
              'Authorization': (await super.getToken()).toString(),
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "grade_of_memorization":
                  double.parse(data['grade_of_memorization'].toString()),
              "grade_of_review":
                  double.parse(data['grade_of_review'].toString()),
              "attendance_status_id": data['attendance_status_id'].toString(),
              "note": data['note'].toString(),
            }),
          )
          .timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> responseData = json.decode(response.body);

      UpdateGroupMembersFollowUpRecordsResponseModel
          updateGroupMembersFollowUpRecordsResponseModel =
          UpdateGroupMembersFollowUpRecordsResponseModel.fromJson(
              responseData, response.statusCode);

      debugPrint("Data: $responseData");
      debugPrint(
          "UpdateGroupMembersFollowUpRecordsResponseModel: $UpdateGroupMembersFollowUpRecordsResponseModel");

      return updateGroupMembersFollowUpRecordsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return UpdateGroupMembersFollowUpRecordsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $e",
      );
    }
  }

  Future<DeleteGroupMembersFollowUpRecordsResponseModel>
      deleteGroupMembersFollowUpRecords(
          {required Map<String, dynamic> data}) async {
    String groupId = data['groupId'];

    String recordId = data['recordId'];

    String groupMemberId = data['groupMemberId'];

    debugPrint("groupId: $groupId");
    debugPrint("groupMemberId: $groupMemberId");

    String deleteGroupMembersFollowUpRecordsRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/members/$groupMemberId/follow-up-records/$recordId/delete";

    final url = Uri.parse(deleteGroupMembersFollowUpRecordsRoute);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      debugPrint("Final URL: $url");

      debugPrint("Token: ${await super.getToken()}");

      final response = await http.delete(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
          'Authorization': (await super.getToken()).toString(),
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> responseData = json.decode(response.body);

      DeleteGroupMembersFollowUpRecordsResponseModel
          deleteGroupMembersFollowUpRecordsResponseModel =
          DeleteGroupMembersFollowUpRecordsResponseModel.fromJson(
              responseData, response.statusCode);

      debugPrint("Data: $responseData");
      debugPrint(
          "deleteGroupMembersFollowUpRecordsResponseModel: $deleteGroupMembersFollowUpRecordsResponseModel");

      return deleteGroupMembersFollowUpRecordsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return DeleteGroupMembersFollowUpRecordsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $e",
      );
    }
  }

  Future<List<AttendanceStatus>> getAttendanceStatusList() async {
    final url = Uri.parse("${super.getAlHudaBaseURL}/attendance-status");

    debugPrint("$url");

    String? lang = appService.languageStorage.read('language');

    debugPrint("lang device : $lang");

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);
      AttendanceStatusResponseModel attendanceStatusResponseModel =
          AttendanceStatusResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(attendanceStatusResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("attendanceStatus  list: ${data['data']}");
        return attendanceStatusResponseModel.attendanceStatus;
      } else {
        debugPrint("Failed to get attendanceStatus list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<GroupPlanDate>> groupPlanDatesList(String groupId) async {
    final url = Uri.parse(
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-plan/dates");

    debugPrint("$url");

    String? lang = appService.languageStorage.read('language');

    debugPrint("lang device : $lang");

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
          'Authorization': (await super.getToken()).toString(),
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      GroupPlanDatesResponseModel groupPlanDatesResponseModel =
          GroupPlanDatesResponseModel.fromJson(data, response.statusCode);

      debugPrint("*-*-*-*-*-");
      debugPrint(groupPlanDatesResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        return groupPlanDatesResponseModel.groupPlanDates;
      } else {
        debugPrint("Failed to get groupPlanDates list:");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }
}
