import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/memorization_group_details_response_model.dart';

class ParticipantSearchedGroupDetailsService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';

  var appService = Get.find<AppService>();
  Future<MemorizationGroupDetailsResponseModel> fetchMemorizationGroupDetails(
      String id) async {
    debugPrint("id in service : ${id.runtimeType}");

    String memorizationGroupDetailsRoute =
        "$alHudaBaseURL/memorization-group/id";
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
}
