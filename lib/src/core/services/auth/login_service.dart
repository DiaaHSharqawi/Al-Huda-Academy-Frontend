import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/login_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class LoginService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final loginRoute = "$alHudaBaseURL${AppRoutes.login}";

  var appService = Get.find<AppService>();

  Future<LoginResponse?> login(String email, String password) async {
    final url = Uri.parse(loginRoute);
    debugPrint("$url");
    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['success']) {
        debugPrint("Login successful");
        final user = UserModel.fromJson(data['userData']);
        return LoginResponse(
          statusCode: response.statusCode,
          success: true,
          message: data['message'],
          user: user,
          accessToken: data['accessToken'],
          refreshToken: data['refreshToken'],
        );
      } else {
        debugPrint("Login failed: ${data['message']}");
        return LoginResponse(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
          user: null,
          accessToken: null,
          refreshToken: null,
        );
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return LoginResponse(
          statusCode: 500,
          message:
              "An error occurred while logging in. Please check your internet connection and try again.",
          success: false);
    }
  }
}
