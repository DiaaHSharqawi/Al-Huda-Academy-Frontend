import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class LoginService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final loginRoute = "$alHudaBaseURL${AppRoutes.login}";

  Future<UserModel?> login(String email, String password) async {
    final url = Uri.parse(loginRoute);
    debugPrint("$url");
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint(data.toString());
      if (data['success']) {
        return UserModel.fromJson(data['userData']);
      }
    } else {
      throw Exception("Failed to login");
    }
    return null;
  }
}
