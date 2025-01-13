import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/days_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_goal_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/teaching_methods_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/surahs/surahs.dart';

class CreateMemorizationGroupService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final createNewMemorizationGroup =
      "$alHudaBaseURL/memorization-group/create";

  var appService = Get.find<AppService>();

  Future<Map<String, dynamic>> createANewMemorizationGroup(
      Object createModel) async {
    final url = Uri.parse(
      createNewMemorizationGroup,
    );

    final Map<String, dynamic> createModelMap =
        createModel as Map<String, dynamic>;

    final surahIds = createModelMap['surah_ids'];

    debugPrint("surahIds: ${surahIds.runtimeType}");
    if (surahIds != null && surahIds is! List<int>) {
      throw Exception("surah_ids must be a list of integers.");
    }
    try {
      debugPrint("---->");
      debugPrint(createModelMap.toString());

      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language':
              appService.languageStorage.read('language') ?? 'en',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'groupName': createModelMap['groupName'],
          'group_description': createModelMap['groupDescription'],
          'capacity': (createModelMap['capacity']),
          'start_time': createModelMap['start_time'].toString(),
          'end_time': createModelMap['end_time'].toString(),
          'days': createModelMap['days'],
          'supervisor_id': appService.user.value!.getMemberId(),
          'participants_gender_id': createModelMap['participants_gender_id'],
          'group_goal_id': createModelMap['group_goal_id'],
          'teaching_method_id': createModelMap['teaching_method_id'],
          'surah_ids': createModelMap['surah_ids'],
          'juza_ids': createModelMap['juza_ids'],
          'extracts': createModelMap['extracts'],
        }),
      );

      debugPrint(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 200) {
        if (data['success']) {
          return {
            'statusCode': response.statusCode,
            'success': true,
            'message': data['message'],
          };
        } else {
          return {
            'statusCode': response.statusCode,
            'success': false,
            'message': data['message'],
          };
        }
      } else {
        return {
          'statusCode': response.statusCode,
          'success': false,
          'message': data['message'],
        };
      }
    } catch (e) {
      debugPrint('Error: $e');
      return {
        'statusCode': 500,
        'success': false,
        'message': 'حدث خطأ ما',
      };
    }
  }

  Future<Map<String, dynamic>> getGroupByGroupName(String groupName) async {
    final url = Uri.parse(
      "$alHudaBaseURL/memorization-group/get-by-name",
    );
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language':
              appService.languageStorage.read('language') ?? 'en',
        },
        body: {
          'groupName': groupName,
        },
      ).timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['success']) {
          debugPrint("Group: ${data['data']}");
          return {
            'statusCode': response.statusCode,
            'success': true,
            'message': data['message'],
            'group': data['data'],
          };
        } else {
          debugPrint("Failed to get group: ${data['message']}");
          return {
            'statusCode': response.statusCode,
            'success': false,
            'message': data['message'],
          };
        }
      } else {
        debugPrint("Failed to get group: ${data['message']}");
        return {
          'statusCode': response.statusCode,
          'success': false,
          'message': data['message'],
        };
      }
    } catch (e) {
      debugPrint("Error: $e");
      return {
        'statusCode': 500,
        'success': false,
        'message': 'حدث خطأ ما',
      };
    }
  }

  Future<List<Day>> getDaysList() async {
    final url = Uri.parse("$alHudaBaseURL/days");
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
      DaysResponseModel daysResponseModel = DaysResponseModel.fromJson(data);
      debugPrint("*-*-*-*-*-");
      debugPrint(daysResponseModel.toString());

      debugPrint("Data: $data");
      if (data['success']) {
        debugPrint("daysResponseModel list: ${data['data']}");
        return daysResponseModel.days;
      } else {
        debugPrint("Failed to get daysResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<Gender>> getGendersList() async {
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

  Future<List<TeachingMethod>> getTeachingMethodsList() async {
    final url = Uri.parse("$alHudaBaseURL/teaching-methods");
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

  Future<List<Surah>> getSurahList() async {
    final url = Uri.parse("$alHudaBaseURL/quran/surahs");
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
    final url = Uri.parse("$alHudaBaseURL/quran/juzas");
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
}
