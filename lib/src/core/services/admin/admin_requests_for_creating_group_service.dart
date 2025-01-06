import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/admin_requests_for_creating_groups_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_goal_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/participant_level_response_model.dart';

class AdminRequestsForCreatingGroupService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final requestsForCreatingGroups =
      "$alHudaBaseURL/admin/groups/requests/pending";

  var appService = Get.find<AppService>();

  Future<List<Gender>> getGenderList() async {
    final url = Uri.parse("$alHudaBaseURL/gender");
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
      GenderResponseModel genderResponseModel =
          GenderResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(genderResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("gender list: ${data['data']}");
        return genderResponseModel.genders;
      } else {
        debugPrint("Failed to get gender list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<ParticipantLevel>> getParticipantLevelList() async {
    final url = Uri.parse("$alHudaBaseURL/participant-level");
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

      ParticipantLevelResponseModel participantLevelResponseModel =
          ParticipantLevelResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(participantLevelResponseModel.toString());

      debugPrint("Data: $data");
      if (data['success']) {
        debugPrint(
            "participantLevelResponseModel  list: ${participantLevelResponseModel.participantLevels}");
        return participantLevelResponseModel.participantLevels;
      } else {
        debugPrint(
            "Failed to get participantLevelResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<GroupGoal>> getGroupGoalList() async {
    final url = Uri.parse("$alHudaBaseURL/group-goal");
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
      GroupGoalResponseModel groupGoalResponseModel =
          GroupGoalResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(groupGoalResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("groupGoals list: ${groupGoalResponseModel.groupGoals}");
        return groupGoalResponseModel.groupGoals;
      } else {
        debugPrint("Failed to get groupGoals list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<AdminRequestsForCreatingGroupsResponseModel>
      fetchRequestsForCreatingGroup(Map<String, dynamic> filter) async {
    String requestsForCreatingGroup =
        "$alHudaBaseURL/admin/groups/requests/pending";
    final url = Uri.parse(requestsForCreatingGroup);
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
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      AdminRequestsForCreatingGroupsResponseModel
          adminRequestsForCreatingGroupsResponseModel =
          AdminRequestsForCreatingGroupsResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "adminRequestsForCreatingGroupsResponseModel: $adminRequestsForCreatingGroupsResponseModel");

      return adminRequestsForCreatingGroupsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return AdminRequestsForCreatingGroupsResponseModel(
        statusCode: 500,
        success: false,
        metaData: null,
        requestsForCreatingGroupsModels: [],
      );
    }
  }
}
