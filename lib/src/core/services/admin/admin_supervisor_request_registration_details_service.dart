import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/account_statuses/account_statuses_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/accept_supervisor_request_registration_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/reject_supervisor_request_registration_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/supervisor_request_registration_details_response_model.dart';

class AdminSupervisorRequestRegistrationDetailsService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';

  var appService = Get.find<AppService>();
  Future<SupervisorRequestRegistrationDetailsResponseModel>
      fetchSupervisorRequestsRegistrationDetails(String supervisorId) async {
    debugPrint("supervisorId in service : $supervisorId");

    String supervisorRequestsRegistrationDetailsRoute =
        "$alHudaBaseURL/admin/supervisor/requests/registration/pending/$supervisorId";

    debugPrint(
      "supervisorRequestsRegistrationDetailsRoute : $supervisorRequestsRegistrationDetailsRoute",
    );

    final url = Uri.parse(supervisorRequestsRegistrationDetailsRoute);
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
      debugPrint("Data: $data");

      SupervisorRequestRegistrationDetailsResponseModel
          supervisorRequestRegistrationDetailsResponseModel =
          SupervisorRequestRegistrationDetailsResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "supervisorRequestRegistrationDetailsResponseModel: $supervisorRequestRegistrationDetailsResponseModel");

      return supervisorRequestRegistrationDetailsResponseModel;
    } catch (e) {
      debugPrint("Error in fetchSupervisorRequestsRegistrationDetails: $e");
      return SupervisorRequestRegistrationDetailsResponseModel(
        statusCode: 500,
        success: false,
        message: "Failed to get memorization group list",
        supervisorRequestRegistrationDetails: null,
      );
    }
  }

  Future<List<AccountStatus>> getAccountStatusList() async {
    final url = Uri.parse("$alHudaBaseURL/account-status");
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
      AccountStatusesResponseModel accountStatusesResponseModel =
          AccountStatusesResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(accountStatusesResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("accountStatusesResponseModel list: ${data['data']}");
        return accountStatusesResponseModel.accountStatuses;
      } else {
        debugPrint(
            "Failed to get accountStatusesResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<AcceptSupervisorRequestRegistrationResponseModel>
      acceptSupervisorRequestRegistration(
    String supervisorId,
    String accountStatusId,
  ) async {
    debugPrint("accept Supervisor Request Registration");

    String acceptSupervisorRequestRegistrationRoute =
        "$alHudaBaseURL/admin/supervisor/requests/registration/pending/$supervisorId/accept";
    String? lang = appService.languageStorage.read('language');

    try {
      final url = Uri.parse(acceptSupervisorRequestRegistrationRoute);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
        body: {
          'accountStatusId': accountStatusId,
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint("Supervisor request registration accepted successfully");
        return AcceptSupervisorRequestRegistrationResponseModel(
          statusCode: response.statusCode,
          success: true,
          message: data['message'],
        );
      } else {
        return AcceptSupervisorRequestRegistrationResponseModel(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
        );
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return AcceptSupervisorRequestRegistrationResponseModel(
        statusCode: 500,
        message:
            "An error occurred while resetting the password. Please try again.",
        success: false,
      );
    }
  }

  Future<RejectSupervisorRequestRegistrationResponseModel>
      rejectSupervisorRequestRegistration(
    String supervisorId,
    String accountStatusId,
  ) async {
    debugPrint("reject Supervisor Request Registration");

    String rejectSupervisorRequestRegistrationRoute =
        "$alHudaBaseURL/admin/supervisor/requests/registration/pending/$supervisorId/reject";
    String? lang = appService.languageStorage.read('language');

    try {
      final url = Uri.parse(rejectSupervisorRequestRegistrationRoute);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
        body: {
          'accountStatusId': accountStatusId,
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint("Supervisor request registration rejected successfully");
        return RejectSupervisorRequestRegistrationResponseModel(
          statusCode: response.statusCode,
          success: true,
          message: data['message'],
        );
      } else {
        return RejectSupervisorRequestRegistrationResponseModel(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
        );
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return RejectSupervisorRequestRegistrationResponseModel(
        statusCode: 500,
        message:
            "An error occurred while resetting the password. Please try again.",
        success: false,
      );
    }
  }
}
