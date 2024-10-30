import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/login_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class LoginService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final loginRoute = "$alHudaBaseURL${AppRoutes.login}";

  Future<LoginResponse?> login(String email, String password) async {
    final url = Uri.parse(loginRoute);
    debugPrint("$url");

    try {
      final response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['success']) {
          debugPrint("Login successful");
          final user = UserModel.fromJson(data['userData']);
          return LoginResponse(
              user: user, message: data['message'], success: true);
        } else {
          debugPrint("Login failed: ${data['message']}");
          return LoginResponse(message: data['message'], success: false);
        }
      } else {
        debugPrint("HTTP error: ${response.statusCode}");
        return LoginResponse(message: data['message'], success: false);
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return LoginResponse(
          message:
              "An error occurred while logging in. Please check your internet connection and try again.",
          success: false);
    }
  }
}
