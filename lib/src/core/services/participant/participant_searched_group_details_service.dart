import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/memorization_group_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/participant/send_request_to_join_group_response_model.dart';

class ParticipantSearchedGroupDetailsService extends BaseGetxService {
  Future<MemorizationGroupDetailsResponseModel> fetchMemorizationGroupDetails(
      String id) async {
    debugPrint("id in service : ${id.runtimeType}");

    String memorizationGroupDetailsRoute =
        "${super.getAlHudaBaseURL}/memorization-group/id";
    memorizationGroupDetailsRoute = "$memorizationGroupDetailsRoute/$id";

    debugPrint(
        "memorizationGroupDetailsRoute : $memorizationGroupDetailsRoute");

    final url = Uri.parse(memorizationGroupDetailsRoute);
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

      MemorizationGroupDetailsResponseModel
          memorizationGroupDetailsResponseModel =
          MemorizationGroupDetailsResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "memorizationGroupDetailsResponseModel: $memorizationGroupDetailsResponseModel");

      return memorizationGroupDetailsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return MemorizationGroupDetailsResponseModel(
        statusCode: 500,
        success: false,
        message: "Failed to get memorization group list",
        memorizationGroup: null,
      );
    }
  }

  Future<SendRequestToJoinGroupResponseModel> sendRequestToJoinGroup(
      String groupId) async {
    String sendRequestToJoinGroupRoute =
        "${super.getAlHudaBaseURL}/participant/groups/$groupId/send-request-to-join-group";

    debugPrint("sendRequestToJoinGroupRoute : $sendRequestToJoinGroupRoute");

    final url = Uri.parse(sendRequestToJoinGroupRoute);
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

      SendRequestToJoinGroupResponseModel sendRequestToJoinGroupResponseModel =
          SendRequestToJoinGroupResponseModel.fromJson(
              data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint(
          "sendRequestToJoinGroupResponseModel: $sendRequestToJoinGroupResponseModel");

      return sendRequestToJoinGroupResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return SendRequestToJoinGroupResponseModel(
        statusCode: 500,
        success: false,
        message: "Failed to get memorization group list",
      );
    }
  }
}
