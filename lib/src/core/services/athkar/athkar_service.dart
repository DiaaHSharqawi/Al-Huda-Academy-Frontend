import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkars/athkars_response.dart';

class AthkarService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  var appService = Get.find<AppService>();
  Future<AthkarResponse?> fetchAthkar(String categoryId) async {
    debugPrint("Fetching Athkar  service");
    final athkarCategoriesRoute =
        "$alHudaBaseURL${AppRoutes.athkar}/$categoryId";
    final url = Uri.parse(athkarCategoriesRoute);
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept-Language': 'ar',
        },
      );
      debugPrint("fetching athkars Response body: ${response.body}");

      if (response.statusCode == 200) {
        debugPrint('Response body ----------------: ${response.body}',
            wrapWidth: 1024);
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return AthkarResponse.fromJson(jsonResponse, response.statusCode);
      } else {
        debugPrint(response.body);
        debugPrint(
            'Failed to load athkar. Status code: ${response.statusCode}');
        AthkarResponse athkarResponse = AthkarResponse(
          success: false,
          statusCode: response.statusCode,
          message: null,
          responseMessage: "Failed to load athkar",
        );
        return athkarResponse;
      }
    } catch (e) {
      debugPrint("Error fetching Athkar: $e");
      return null;
    }
  }
}
