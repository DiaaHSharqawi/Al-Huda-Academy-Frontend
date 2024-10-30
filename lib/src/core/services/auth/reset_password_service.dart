import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/forget_password_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/reset_password_response.dart';

class ResetPasswordService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final sendPasswordResetCodeRoute =
      "$alHudaBaseURL${AppRoutes.sendPasswordResetCode}";

  Future<ForgetPasswordResponse?> forgetPassword(String email) async {
    final url = Uri.parse(sendPasswordResetCodeRoute);
    debugPrint("$url");

    try {
      final response = await http.post(url, body: {
        'email': email,
      });

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success']) {
          debugPrint("Password reset code sent");
          return ForgetPasswordResponse(
              message: data['message'], success: true);
        } else {
          debugPrint("Password reset request failed: ${data['message']}");
          return ForgetPasswordResponse(
              message: data['message'], success: false);
        }
      } else {
        debugPrint("HTTP error: ${response.statusCode}");
        return ForgetPasswordResponse(message: data['message'], success: false);
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return ForgetPasswordResponse(
          message:
              "An error occurred while requesting the password reset. Please check your internet connection and try again.",
          success: false);
    }
  }

  Future<ResetPasswordResponse> resetPassword(
      String email, String password, String verificationCode) async {
    try {
      final url = Uri.parse("$alHudaBaseURL${AppRoutes.resetPassword}");
      final response = await http.post(url, body: {
        'email': email,
        'newPassword': password,
        'verificationCode': verificationCode,
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['success']) {
          debugPrint("Password reset successful");
          return ResetPasswordResponse(message: data['message'], success: true);
        } else {
          debugPrint("Password reset failed: ${data['message']}");
          return ResetPasswordResponse(
              message: data['message'], success: false);
        }
      } else {
        debugPrint("--> HTTP error: ${response.statusCode} ${response.body}");
        return ResetPasswordResponse(message: data['message'], success: false);
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return ResetPasswordResponse(
          message:
              "An error occurred while resetting the password. Please check your internet connection and try again.",
          success: false);
    }
  }
}
