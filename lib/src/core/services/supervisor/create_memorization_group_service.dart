import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/days_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/participant_level_response_model.dart';

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
    try {
      debugPrint("---->");
      debugPrint(
        createModelMap['selectedDays'].toString(),
      );
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
          'capacity': createModelMap['groupCapacity'],
          'start_time': createModelMap['startTime'],
          'end_time': createModelMap['endTime'],
          'days': createModelMap['selectedDays'],
          'group_status': 'pending',
          'supervisor_id': appService.user.value!.getMemberId(),
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
}
