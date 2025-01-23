import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/data/model/group_content/group_content_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_plan_response_model.dart';
import 'dart:convert';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor_group_days/supervisor_group_days_response_model.dart';

class SupervisorCreateGroupPlanService extends BaseGetxService {
  Future<CreateGroupPlanResponseModel> createGroupPlan(
    String groupId,
    DateTime dayDate,
  ) async {
    debugPrint("groupId: $groupId");
    debugPrint("dayDate: $dayDate");

    String createGroupPlanRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-plan/create";

    final url = Uri.parse(createGroupPlanRoute);
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
          "dayDate": dayDate.toIso8601String(),
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      CreateGroupPlanResponseModel createGroupPlanResponseModel =
          CreateGroupPlanResponseModel.fromJson(data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint("createGroupPlanResponseModel: $createGroupPlanResponseModel");

      return createGroupPlanResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return CreateGroupPlanResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $e",
      );
    }
  }

  Future<List<SupervisorGroupDay>> getGroupDaysList(String groupId) async {
    final url = Uri.parse(
      "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-days",
    );

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

  Future<List<GroupContent>> getGroupContent(String groupId) async {
    final url = Uri.parse(
      "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/content",
    );
    debugPrint("$url");

    String? lang = appService.languageStorage.read('language');

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
      GroupContentResponseModel groupContentResponseModel =
          GroupContentResponseModel.fromJson(data);

      debugPrint("Data: $data");
      debugPrint("groupContentResponseModel: $groupContentResponseModel");

      if (groupContentResponseModel.success == true) {
        return groupContentResponseModel.groupContent;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }
}
