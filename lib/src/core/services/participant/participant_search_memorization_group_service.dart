import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/Languages/languages_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_goal_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_search_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/teaching_methods_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/surahs/surahs.dart';

class ParticipantSearchMemorizationGroupService extends BaseGetxService {
  Future<GroupSearchResponseModel> fetchMemorizationGroup(
      Map<String, dynamic> filter) async {
    final searchMemorizationGroupRoute =
        "${super.getAlHudaBaseURL}/memorization-group/";

    final url = Uri.parse(searchMemorizationGroupRoute);
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
          'Authorization': (await super.getToken())!,
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);
      GroupSearchResponseModel groupSearchResponseModel =
          GroupSearchResponseModel.fromJson(data, response.statusCode);
      debugPrint("Data: $data");
      debugPrint("GroupSearchResponseModel: $groupSearchResponseModel");

      return groupSearchResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return GroupSearchResponseModel(
        statusCode: 500,
        success: false,
        message: "Failed to get memorization group list",
        metaData: null,
        groupSearchModels: [],
      );
    }
  }

  Future<List<Surah>> getSurahList() async {
    final url = Uri.parse("${super.getAlHudaBaseURL}/quran/surahs");
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
      SurahResponse surah = SurahResponse.fromJson(data);
      debugPrint("*-*-*-*-*-");
      debugPrint(surah.toString());

      debugPrint("Data: $data");
      if (data['success']) {
        debugPrint("Surah list: ${data['data']}");
        return surah.surahs;
      } else {
        debugPrint("Failed to get surah list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<Juza>> getJuzaList() async {
    final url = Uri.parse("${super.getAlHudaBaseURL}/quran/juzas");
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
      JuzaResponse juzaResponse = JuzaResponse.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(juzaResponse.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("juzaa list: ${data['data']}");
        return juzaResponse.juzas;
      } else {
        debugPrint("Failed to get surah list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<GroupGoal>> getGroupGoalList() async {
    final url = Uri.parse("${super.getAlHudaBaseURL}/group-goal");
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

  Future<List<Language>> getGroupLanguagesList() async {
    final url = Uri.parse("${super.getAlHudaBaseURL}/language");
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
      LanguagesResponseModel languagesResponseModel =
          LanguagesResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(languagesResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint(
            "languagesResponseModel  list: ${languagesResponseModel.languages}");
        return languagesResponseModel.languages;
      } else {
        debugPrint(
            "Failed to get languagesResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<TeachingMethod>> getTeachingMethodsList() async {
    final url = Uri.parse("${super.getAlHudaBaseURL}/teaching-methods");
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
      TeachingMethodsResponseModel teachingMethodsResponseModel =
          TeachingMethodsResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(teachingMethodsResponseModel.toString());

      debugPrint("Data: $data");
      if (data['success']) {
        debugPrint(
            "teachingMethodsResponseModel  list: ${teachingMethodsResponseModel.teachingMethods}");
        return teachingMethodsResponseModel.teachingMethods;
      } else {
        debugPrint(
            "Failed to get teachingMethodsResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }
}
