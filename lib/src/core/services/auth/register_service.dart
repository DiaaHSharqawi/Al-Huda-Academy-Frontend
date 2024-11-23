import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response/register_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response/register_response_data.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/register_model.dart';

class RegisterService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final registerRoute = "$alHudaBaseURL${AppRoutes.register}";
  var appService = Get.find<AppService>();
  Future<RegisterResponse> registerUser(RegisterModel model) async {
    try {
      String? lang = appService.languageStorage.read('language');

      var request = http.MultipartRequest('POST', Uri.parse(registerRoute));

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Accept-Language'] = lang ?? 'en';

      var fields = {
        'fullName': model.fullName,
        'email': model.email,
        'password': model.password,
        'phone': model.phone,
        'city': model.city,
        'country': model.country,
        'gender': model.gender,
        'age': model.age,
      };

      request.fields.addAll(fields);

      if (model.profileImage != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'profileImage',
          model.profileImage!,
          filename: 'profileImage.png',
        ));
      }

      var response = await request.send();
      final responseData = await http.Response.fromStream(response);
      debugPrint(responseData.body);
      final Map<String, dynamic> jsonResponse = json.decode(responseData.body);
      debugPrint("----------------");
      debugPrint(jsonResponse.toString());
      if (response.statusCode == 201) {
        final registerResponseData =
            RegisterResponseData.fromJson(jsonResponse['data']);

        return RegisterResponse(
          statusCode: response.statusCode,
          success: jsonResponse['success'] ?? false,
          message: jsonResponse['message'] ?? '',
          data: registerResponseData,
        );
      } else {
        return RegisterResponse(
          statusCode: response.statusCode,
          success: jsonResponse['success'] ?? false,
          message: jsonResponse['message'] ?? '',
          data: null,
        );
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }
}
