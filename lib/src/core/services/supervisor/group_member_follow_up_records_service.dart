import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/attendance_status/attendance_status_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/group_member_follow_up_records_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupMemberFollowUpRecordsService extends BaseGetxService {
  Future<GroupMemberFollowUpRecordsResponseModel>
      fetchGroupMemberFollowUpRecords(
          {required String groupId, required String groupMemberId}) async {
    debugPrint("fetchGroupMemberFollowUpRecords Service");

    debugPrint("groupId: $groupId");
    debugPrint("groupMemberId: $groupMemberId");

    String groupMemberFollowUpRecordsRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/members/$groupMemberId/follow-up-records";

    final url = Uri.parse(groupMemberFollowUpRecordsRoute);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      debugPrint("Final URL: $url");

      debugPrint("Token: ${await super.getToken()}");

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
        message: "Error: $e",
        groupMemberFollowUpRecordsMetadata: null,
        groupMemberFollowUpRecords: null,
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
}
