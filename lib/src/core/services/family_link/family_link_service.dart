import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/get_childs_by_parent_id_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/send_child_verification_code_family_link_response.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/verify_child_verification_code_family_link_response.dart';

class FamilyLinkService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final sendChildVerificationCode =
      "$alHudaBaseURL/family-link/send-child-verification-code";

  static final verifyChildVerificationCode =
      "$alHudaBaseURL/family-link/verify-child-verification-code";

  var appService = Get.find<AppService>();

  Future<SendChildVerificationCodeFamilyLinkResponse?>
      sendChildVerificationCodeFamilyLink(
          String senderUserId, String childEmail) async {
    debugPrint('senderUserId: $senderUserId');
    debugPrint('childEmail: $childEmail');
    final url = Uri.parse(sendChildVerificationCode);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language':
              appService.languageStorage.read('language') ?? 'en',
        },
        body: {
          'senderIdentifier': senderUserId,
          'reciverIdentifier': childEmail,
        },
      );

      debugPrint(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 200) {
        if (data['success']) {
          debugPrint("Family link verification code sent successfully");
          return SendChildVerificationCodeFamilyLinkResponse(
            statusCode: response.statusCode,
            success: true,
            message: data['message'],
          );
        } else {
          debugPrint("Family link verification code:  ${data['message']}");
          return SendChildVerificationCodeFamilyLinkResponse(
              statusCode: response.statusCode,
              success: false,
              message: data['message']);
        }
      } else {
        debugPrint(
            "Failed to send child verification code: ${response.statusCode}");
        return SendChildVerificationCodeFamilyLinkResponse(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      return SendChildVerificationCodeFamilyLinkResponse(
        statusCode: 500,
        success: false,
        message: 'حدث خطأ ما',
      );
    }
  }

  Future<VerifyChildVerificationCodeFamilyLinkResponse?>
      verifyChildVerificationCodeFamilyLink(String senderUserId,
          String childEmail, String verificationCode) async {
    debugPrint('verifyChildVerificationCodeFamilyLink');
    final url = Uri.parse(verifyChildVerificationCode);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Accept-Language':
              appService.languageStorage.read('language') ?? 'en',
        },
        body: {
          'senderIdentifier': senderUserId,
          'receiverIdentifier': childEmail,
          'verificationCode': verificationCode,
        },
      );

      debugPrint(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 200) {
        if (data['success']) {
          debugPrint("family link done succefuly");
          return VerifyChildVerificationCodeFamilyLinkResponse(
            statusCode: response.statusCode,
            success: true,
            message: data['message'],
          );
        } else {
          debugPrint("Family link msg verification code:  ${data['message']}");
          return VerifyChildVerificationCodeFamilyLinkResponse(
              statusCode: response.statusCode,
              success: false,
              message: data['message']);
        }
      } else {
        debugPrint(
            "Failed to send child verification code: ${response.statusCode}");
        return VerifyChildVerificationCodeFamilyLinkResponse(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
        );
      }
    } catch (error) {
      debugPrint('Error: $error');
      return VerifyChildVerificationCodeFamilyLinkResponse(
        statusCode: 500,
        success: false,
        message: 'حدث خطأ ما',
      );
    }
  }

  Future<GetChildsByUserIdResponse?> getChildrenByParentId(
      String parentId) async {
    debugPrint('getChildrenByParentId');
    final url = Uri.parse("$alHudaBaseURL/family-link/childs");
    try {
      final response = await http.get(
        url.replace(queryParameters: {'parentId': parentId}),
        headers: <String, String>{
          'Accept-Language':
              appService.languageStorage.read('language') ?? 'en',
        },
      );

      debugPrint(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (response.statusCode == 200) {
        if (data['success']) {
          debugPrint("data : ${data['FamilyLink']}");
          return GetChildsByUserIdResponse.fromJson(data, response.statusCode);
        } else {
          debugPrint("data if not success:  ${data['message']}");
          return GetChildsByUserIdResponse(
            statusCode: response.statusCode,
            success: false,
            message: data['message'],
            familyLink: null,
          );
        }
      } else {
        debugPrint(
            "Failed to send child verification code: ${response.statusCode}");
        return GetChildsByUserIdResponse(
          statusCode: response.statusCode,
          success: false,
          message: data['message'],
          familyLink: null,
        );
      }
    } catch (error) {
      debugPrint('Error: $error');
      return GetChildsByUserIdResponse(
        statusCode: 500,
        success: false,
        familyLink: null,
        message: 'حدث خطأ ما',
      );
    }
  }
}
