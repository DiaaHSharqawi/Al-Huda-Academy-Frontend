import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/supervisor_groups_meeting_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SupervisorMeetingDashboardService extends BaseGetxService {
  Future<SupervisorGroupsMeetingResponseModel> fetchSupervisorGroupsMeeting(
      Map<String, dynamic> filter) async {
    String supervisorGroupsMeetingRoutes =
        "${super.getAlHudaBaseURL}/supervisor/meetings/groups";

    final url = Uri.parse(supervisorGroupsMeetingRoutes);
    debugPrint("$url");

    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    debugPrint("Filter: ${filter.toString()}");
    try {
      final queryParameters =
          filter.map((key, value) => MapEntry(key, value.toString()));

      debugPrint("Query Parameters: $queryParameters");
      debugPrint("Final URL: ${url.replace(queryParameters: queryParameters)}");

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

      SupervisorGroupsMeetingResponseModel
          supervisorGroupsMeetingResponseModel =
          SupervisorGroupsMeetingResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "supervisorGroupsMeetingResponseModel: $supervisorGroupsMeetingResponseModel");

      return supervisorGroupsMeetingResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return SupervisorGroupsMeetingResponseModel(
        statusCode: 500,
        success: false,
        message: "Error in fetchSupervisorGroupsMeeting Service",
        supervisorGroupsMetaData: null,
        supervisorGroups: [],
      );
    }
  }
}
