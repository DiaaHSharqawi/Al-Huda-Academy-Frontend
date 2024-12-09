import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkar_categories/athkar_categories_response.dart';

class AthkarCategoriesService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';

  var appService = Get.find<AppService>();

  Future<AthkarCategoriesResponse?> fetchAthkarCategories(
      page, limit, query) async {
    debugPrint("Page: $page, Limit: $limit");
    debugPrint("Fetching Athkar Categories service");
    final athkarCategoriesRoute =
        "$alHudaBaseURL${AppRoutes.athkarCategories}?page=$page&limit=$limit&categoryName=$query";
    final url = Uri.parse(athkarCategoriesRoute);
    debugPrint("------> url :  $url");

    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept-Language': 'ar',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Response status: ${response.statusCode}');

        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return AthkarCategoriesResponse.fromJson(
            jsonResponse, response.statusCode);
      } else {
        debugPrint(response.body);
        debugPrint(
            'Failed to load athkar categories. Status code: ${response.statusCode}');

        AthkarCategoriesResponse athkarCategoriesModel =
            AthkarCategoriesResponse(
          success: false,
          statusCode: response.statusCode,
          message: null,
          responseMessage: "Failed to load athkar categories",
        );
        return athkarCategoriesModel;
      }
    } catch (e) {
      debugPrint("Error fetching athkar categories: $e");
      AthkarCategoriesResponse athkarCategoriesModel = AthkarCategoriesResponse(
        success: false,
        statusCode: 500,
        message: null,
        responseMessage: "Error fetching athkar categories",
      );
      return athkarCategoriesModel;
    }
  }
}
