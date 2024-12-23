import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/login_response/login_response_data.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/login_response/login_response.dart';

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
      ).timeout(const Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint("Data: $data");
      if (data['success']) {
        debugPrint("Login successful");
        debugPrint("Login data: ${data['data']}");
        final loginMessage = LoginResponseData.fromJson(data['data']);
        if (loginMessage.accessToken != null) {
          await appService.saveToken(loginMessage.accessToken!);
          await appService.loadUserFromToken();
        } else {
          debugPrint("Access token is null");
        }
        debugPrint("Login successful: ${data['message']}");
        return LoginResponse(
          statusCode: response.statusCode,
          success: true,
          message: data['message'],
          data: loginMessage,
        );
      } else {
        debugPrint("Login failed: ${data['message']}");

        return LoginResponse(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
        );
      }
    } on SocketException {
      debugPrint("No Internet connection");
      return LoginResponse(
        statusCode: 503,
        message:
            "No Internet connection. Please check your connection and try again.",
        success: false,
      );
    } on HttpException {
      debugPrint("Couldn't find the server");
      return LoginResponse(
        statusCode: 404,
        message: "Couldn't find the server. Please try again later.",
        success: false,
      );
    } on TimeoutException {
      debugPrint("Connection timeout");
      return LoginResponse(
        statusCode: 408,
        message: "Connection timeout. Please try again later.",
        success: false,
      );
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return LoginResponse(
        statusCode: 500,
        message:
            "An error occurred while logging in. Please check your internet connection and try again.",
        success: false,
      );
    }
  }
}
