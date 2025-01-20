import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_weekly_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/group_plan_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor_group_days/supervisor_group_days_response_model.dart';

class SupervisorGroupWeeklyPlanService extends BaseGetxService {
  Future<GroupPlanResponseModel> fetchGroupPlans(
    String groupId,
    Map<String, dynamic> filter,
  ) async {
    String supervisorGroupsRoutes =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-plan";

    final url = Uri.parse(supervisorGroupsRoutes);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    debugPrint("Filter: ${filter.toString()}");
    try {
      final queryParameters =
          filter.map((key, value) => MapEntry(key, value.toString()));

      debugPrint("Query Parameters: $queryParameters");
      debugPrint("Final URL: ${url.replace(queryParameters: queryParameters)}");

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

      GroupPlanResponseModel groupPlanResponseModel =
          GroupPlanResponseModel.fromJson(data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint("groupPlanResponseModel: $groupPlanResponseModel");

      return groupPlanResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return GroupPlanResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $e",
        groupPlan: [],
        groupPlanMetaData: null,
      );
    }
  }

  Future<CreateGroupWeeklyPlanResponseModel> createGroupWeeklyPlan(
    String groupId,
    String nextWeekNumber,
    DateTime startWeekDayDate,
  ) async {
    debugPrint("groupId: $groupId");
    debugPrint("nextWeekNumber: $nextWeekNumber");

    String createGroupWeeklyPlanRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-plan/create";

    final url = Uri.parse(createGroupWeeklyPlanRoute);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      debugPrint("Final URL: $url");

      debugPrint("Token: ${await super.getToken()}");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
          'Authorization': (await super.getToken()).toString(),
        },
        body: {
          "weekNumber": nextWeekNumber,
          "startWeekDayDate": startWeekDayDate.toIso8601String(),
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      CreateGroupWeeklyPlanResponseModel createGroupWeeklyPlanResponseModel =
          CreateGroupWeeklyPlanResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "createGroupWeeklyPlanResponseModel: $createGroupWeeklyPlanResponseModel");

      return createGroupWeeklyPlanResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return CreateGroupWeeklyPlanResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $e",
      );
    }
  }

  Future<List<SupervisorGroupDay>> getGroupDaysList(String groupId) async {
    final url = Uri.parse(
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-days");

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
      SupervisorGroupDaysResponseModel supervisorGroupDaysResponseModel =
          SupervisorGroupDaysResponseModel.fromJson(data, response.statusCode);

      debugPrint("*-*-*-*-*-");
      debugPrint(supervisorGroupDaysResponseModel.toString());

      debugPrint("Data: $data");
      if (data['success']) {
        debugPrint("supervisorGroupDaysResponseModel list: ${data['data']}");
        return supervisorGroupDaysResponseModel.supervisorGroupDays;
      } else {
        debugPrint(
            "Failed to get supervisorGroupDaysResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }
}
