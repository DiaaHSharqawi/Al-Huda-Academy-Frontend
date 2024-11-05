import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/forget_password_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/reset_password_response.dart';

class ResetPasswordService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final sendPasswordResetCodeRoute =
      "$alHudaBaseURL${AppRoutes.sendPasswordResetCode}";
  var appService = Get.find<AppService>();

  Future<ForgetPasswordResponse?> forgetPassword(String email) async {
    final url = Uri.parse(sendPasswordResetCodeRoute);
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
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success']) {
          debugPrint("Password reset code sent");
          return ForgetPasswordResponse(
            statusCode: response.statusCode,
            success: true,
            message: data['message'],
          );
        } else {
          debugPrint("Password reset request failed: ${data['message']}");
          return ForgetPasswordResponse(
              statusCode: response.statusCode,
              success: false,
              message: data['message']);
        }
      } else {
        debugPrint("HTTP error: ${response.statusCode}");
        return ForgetPasswordResponse(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
        );
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return ForgetPasswordResponse(
          statusCode: 500,
          success: false,
          message:
              "An error occurred while requesting the password reset. Please check your internet connection and try again.");
    }
  }

  Future<ResetPasswordResponse> resetPassword(
      String email, String password, String verificationCode) async {
    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");
    try {
      final url = Uri.parse("$alHudaBaseURL${AppRoutes.resetPassword}");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
        body: {
          'email': email,
          'newPassword': password,
          'verificationCode': verificationCode,
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint("Password reset successful");
        return ResetPasswordResponse(
          statusCode: response.statusCode,
          success: true,
          message: data['message'],
        );
      } else {
        return ResetPasswordResponse(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
        );
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return ResetPasswordResponse(
        statusCode: 500,
        message:
            "An error occurred while resetting the password. Please try again.",
        success: false,
      );
    }
  }
}
