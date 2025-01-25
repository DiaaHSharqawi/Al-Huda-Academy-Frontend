import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/participant/participant_groups_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParticipantCurrentGroupsService extends BaseGetxService {
  Future<ParticipantGroupsResponseModel> fetchParticipantGroups(
      Map<String, dynamic> filter) async {
    String participantGroupsRoutes =
        "${super.getAlHudaBaseURL}/participant/groups";

    final url = Uri.parse(participantGroupsRoutes);
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

      ParticipantGroupsResponseModel participantGroupsResponseModel =
          ParticipantGroupsResponseModel.fromJson(data, response.statusCode);

      debugPrint("Data: $data");

      debugPrint(
          "participantGroupsResponseModel: $participantGroupsResponseModel");

      return participantGroupsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return ParticipantGroupsResponseModel(
        statusCode: 500,
        message: "Error in fetch participantGroupsResponseModel",
        participantGroups: [],
        participantGroupsMetaData: null,
      );
    }
  }
}
