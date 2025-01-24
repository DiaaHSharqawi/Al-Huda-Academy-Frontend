import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_content/group_content_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/delete_group_plan_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/edit_group_plan_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/group_plan_details_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moltqa_al_quran_frontend/src/data/model/supervisor_group_days/supervisor_group_days_response_model.dart';

class SupervisorGroupPlanDetailsService extends BaseGetxService {
  Future<GroupPlanDetailsResponseModel> fetchGroupPlanDetails(
      String groupId, String planId) async {
    debugPrint("groupId in service : $groupId");
    debugPrint("planId in service : $planId");

    String groupPlanDetailsRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-plan/$planId";

    debugPrint("groupPlanDetailsRoute : $groupPlanDetailsRoute");

    final url = Uri.parse(groupPlanDetailsRoute);
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
      debugPrint("Data: $data");

      GroupPlanDetailsResponseModel groupPlanDetailsResponseModel =
          GroupPlanDetailsResponseModel.fromJson(data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "groupPlanDetailsResponseModel: $groupPlanDetailsResponseModel");

      return groupPlanDetailsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return GroupPlanDetailsResponseModel(
        statusCode: 500,
        success: false,
        message: "Failed to get group plan details",
        groupPlanDetails: null,
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
        debugPrint("supervisorGroupDaysResponseModel list: ${data['message']}");
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

  Future<EditGroupPlanDetailsResponseModel> editGroupPlan(
    String groupId,
    String groupPlanId,
    DateTime dayDate,
    List contentToMemorize,
    List contentToReview,
    String note,
  ) async {
    debugPrint("groupId: $groupId");
    debugPrint("dayDate: $dayDate");

    String editGroupPlanRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-plan/$groupPlanId/update";

    final url = Uri.parse(editGroupPlanRoute);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      debugPrint("Final URL: $url");

      debugPrint("Token: ${await super.getToken()}");

      final response = await http
          .put(
            url,
            headers: <String, String>{
              'Accept-Language': lang ?? 'en',
              'Authorization': (await super.getToken()).toString(),
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "dayDate": dayDate.toIso8601String().split("T")[0],
              "contentToMemorize": contentToMemorize,
              "contentToReview": contentToReview,
              "note": note,
            }),
          )
          .timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      EditGroupPlanDetailsResponseModel editGroupPlanDetailsResponseModel =
          EditGroupPlanDetailsResponseModel.fromJson(data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "editGroupPlanDetailsResponseModel: $editGroupPlanDetailsResponseModel");

      return editGroupPlanDetailsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return EditGroupPlanDetailsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $e",
      );
    }
  }

  Future<DeleteGroupPlanDetailsResponseModel> deleteGroupPlan(
    String groupId,
    String groupPlanId,
  ) async {
    debugPrint("groupId: $groupId");
    debugPrint("dayDate: $groupPlanId");

    String deleteGroupPlanRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/group-plan/$groupPlanId/delete";

    final url = Uri.parse(deleteGroupPlanRoute);
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

      final Map<String, dynamic> data = json.decode(response.body);

      DeleteGroupPlanDetailsResponseModel deleteGroupPlanDetailsResponseModel =
          DeleteGroupPlanDetailsResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "deleteGroupPlanDetailsResponseModel: $deleteGroupPlanDetailsResponseModel");

      return deleteGroupPlanDetailsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return DeleteGroupPlanDetailsResponseModel(
        success: false,
        statusCode: 500,
        message: "Error: $e",
      );
    }
  }
}
