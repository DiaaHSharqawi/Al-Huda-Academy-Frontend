import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/accept_supervisor_group_join_request_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/reject_supervisor_group_join_request_response_model.dart';
import 'dart:convert';

import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/supervisor_group_join_requests_response_model.dart';

class SupervisorGroupJoinRequestService extends BaseGetxService {
  Future<SupervisorGroupJoinRequestsResponseModel> fetchGroupJoinRequests(
      String groupId, Map<String, dynamic> filter) async {
    String supervisorGroupsRoutes =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/join-requests";

    final url = Uri.parse(supervisorGroupsRoutes);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    debugPrint("Filter: ${filter.toString()}");
    try {
      final queryParameters =
          filter.map((key, value) => MapEntry(key, value.toString()));

      debugPrint("Query Parameters: $queryParameters");
      debugPrint("Final URL: ${url.replace(queryParameters: queryParameters)}");

      debugPrint("Token: ${await super.getToken()}");

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

      SupervisorGroupJoinRequestsResponseModel
          supervisorGroupJoinRequestsResponseModel =
          SupervisorGroupJoinRequestsResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "supervisorGroupJoinRequestsResponseModel: $supervisorGroupJoinRequestsResponseModel");

      return supervisorGroupJoinRequestsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return SupervisorGroupJoinRequestsResponseModel(
        statusCode: 500,
        success: false,
        message: "Error in fetch supervisorGroupJoinRequestsResponseModel",
        groupJoinRequests: [],
        groupJoinRequestsMetaData: null,
      );
    }
  }

  Future<AcceptSupervisorGroupJoinRequestResponseModel> acceptGroupJoinRequest(
      String groupId, String participantId) async {
    String acceptSupervisorGroupJoinRequestRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/join-requests/$participantId/accept";

    debugPrint(
        "acceptSupervisorGroupJoinRequestRoute : $acceptSupervisorGroupJoinRequestRoute");

    final url = Uri.parse(acceptSupervisorGroupJoinRequestRoute);
    debugPrint("$url");
    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
          'Authorization': (await super.getToken())!, // participant token
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint("Data: $data");

      AcceptSupervisorGroupJoinRequestResponseModel
          acceptSupervisorGroupJoinRequestResponseModel =
          AcceptSupervisorGroupJoinRequestResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "acceptSupervisorGroupJoinRequestResponseModel: $acceptSupervisorGroupJoinRequestResponseModel");

      return acceptSupervisorGroupJoinRequestResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return AcceptSupervisorGroupJoinRequestResponseModel(
        statusCode: 500,
        success: false,
        message: "Failed to accept supervisor group join request",
      );
    }
  }

  Future<RejectSupervisorGroupJoinRequestResponseModel> rejectGroupJoinRequest(
      String groupId, String participantId) async {
    String rejectSupervisorGroupJoinRequestRoute =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/join-requests/$participantId/reject";

    debugPrint(
        "rejectSupervisorGroupJoinRequestRoute : $rejectSupervisorGroupJoinRequestRoute");

    final url = Uri.parse(rejectSupervisorGroupJoinRequestRoute);
    debugPrint("$url");
    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
          'Authorization': (await super.getToken())!, // participant token
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint("Data: $data");

      RejectSupervisorGroupJoinRequestResponseModel
          rejectSupervisorGroupJoinRequestResponseModel =
          RejectSupervisorGroupJoinRequestResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "rejectSupervisorGroupJoinRequestResponseModel: $rejectSupervisorGroupJoinRequestResponseModel");

      return rejectSupervisorGroupJoinRequestResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return RejectSupervisorGroupJoinRequestResponseModel(
        statusCode: 500,
        success: false,
        message: "Failed to accept supervisor group join request",
      );
    }
  }
}
