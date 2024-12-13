import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:http/http.dart' as http;

class CreateMemorizationGroupService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final createNewMemorizationGroup =
      "$alHudaBaseURL/memorization-group/create";

  var appService = Get.find<AppService>();

  Future<Map<String, dynamic>> createANewMemorizationGroup(
      Object createModel) async {
    // Implement the logic to create a memorization group
    // For example, you might want to call an API or save to a database

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
          'supervisor_id': appService.user.value!.getEmail,
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
}
