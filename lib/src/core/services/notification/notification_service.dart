import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/notifications/notifications_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService extends BaseGetxService {
  Future<NotificationsResponseModel> fetchUserNotification(
      Map<String, dynamic> filter) async {
    String notificationsRoute = "${super.getAlHudaBaseURL}/notifications";

    final url = Uri.parse(notificationsRoute);
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

      NotificationsResponseModel notificationsResponseModel =
          NotificationsResponseModel.fromJson(data, response.statusCode);

      debugPrint("Data: $data");

      debugPrint("notificationsResponseModel: $notificationsResponseModel");

      return notificationsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return NotificationsResponseModel(
        statusCode: 500,
        message: "Error in fetch participantGroupsResponseModel",
        success: null,
        meta: null,
        userNotifications: [],
      );
    }
  }
}
