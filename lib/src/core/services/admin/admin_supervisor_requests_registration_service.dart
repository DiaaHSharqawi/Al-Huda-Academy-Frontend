import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/supervisor_requests_registration_response_model.dart';

class AdminSupervisorRequestsRegistrationService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';

  var appService = Get.find<AppService>();

  Future<SupervisorRequestsRegistrationResponseModel>
      fetchSupervisorRequestsRegistration(Map<String, dynamic> filter) async {
    String supervisorRequestsRegistrationURL =
        "$alHudaBaseURL/admin/supervisor/requests/pending";

    final url = Uri.parse(supervisorRequestsRegistrationURL);
    final queryParameters = filter.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );

    debugPrint("URL: $url");
    debugPrint("Query Parameters: $queryParameters");

    debugPrint(
        "url.replace(queryParameters: queryParameters) : ${url.replace(queryParameters: queryParameters)}");

    debugPrint(supervisorRequestsRegistrationURL);
    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");
    try {
      final response = await http.get(
        url.replace(queryParameters: queryParameters),
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);
      int statusCode = response.statusCode;

      debugPrint("Data: $data");
      debugPrint("statusCode: $statusCode");

      SupervisorRequestsRegistrationResponseModel
          supervisorRequestsRegistrationResponseModel =
          SupervisorRequestsRegistrationResponseModel.fromJson(
              data, statusCode);

      debugPrint("*-*-*-*-*-");
      debugPrint(supervisorRequestsRegistrationResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint(
            "gendsupervisorRequestsRegistrationer list: ${data['data']}");
        return supervisorRequestsRegistrationResponseModel;
      } else {
        debugPrint(
            "Failed to get gendsupervisorRequestsRegistrationer list: ${data['message']}");
        return SupervisorRequestsRegistrationResponseModel(
          statusCode: statusCode,
          success: false,
          message: data['message'],
          supervisorRequestsRegistrationList: [],
          supervisorRequestsRegistrationMetaData: null,
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      return SupervisorRequestsRegistrationResponseModel(
        statusCode: 500,
        success: false,
        message: "Error: $e",
        supervisorRequestsRegistrationList: [],
        supervisorRequestsRegistrationMetaData: null,
      );
    }
  }
}
