import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response/register_response_data.dart';

class RegisterService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final registerRoute = "$alHudaBaseURL${AppRoutes.register}";
  var appService = Get.find<AppService>();
/*
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
          'statusCode': response.statusCode,
          success: jsonResponse['success'] ?? false,
          message: jsonResponse['message'] ?? '',
          data: registerResponseData,
        );
      } else {
        return RegisterResponse(
          'statusCode': response.statusCode,
          success: jsonResponse['success'] ?? false,
          message: jsonResponse['message'] ?? '',
          data: null,
        );
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }
*/
  Future<Object> isUserExist(String email) async {
    try {
      String emailRoute = "$alHudaBaseURL/users/user";
      String? lang = appService.languageStorage.read('language');

      var uri =
          Uri.parse(emailRoute).replace(queryParameters: {'email': email});

      var request = http.Request('GET', uri);

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Accept-Language'] = lang ?? 'en';

      debugPrint("Email: $email");

      var response = await request.send();
      final responseData = await http.Response.fromStream(response);
      debugPrint(responseData.body);

      return {
        'statusCode': response.statusCode,
        'success': json.decode(responseData.body)['success'],
        'message': json.decode(responseData.body)['message'],
      };
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Future<Object> registerParticipant(Map<String, dynamic> model) async {
    try {
      String registerParticipantRoute =
          "$alHudaBaseURL${AppRoutes.registerParticipant}";

      String? lang = appService.languageStorage.read('language');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(registerParticipantRoute),
      );

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Accept-Language'] = lang ?? 'en';
      debugPrint("-------------------");
      debugPrint(
          'fullName: ${model['fullName']}, email: ${model['email']}, password: ${model['password']}, dateOfBirth: ${model['dateOfBirth']}, phone: ${model['phone']}, city: ${model['city']}, country: ${model['country']}, gender: ${model['gender']}, numberOfMemorizedSurahs: ${model['numberOfMemorizedSurahs']}, numberOfMemorizedParts: ${model['numberOfMemorizedParts']}, details: ${model['details']}');
      var fields = {
        'fullName': model['fullName'].toString(),
        'email': model['email'].toString(),
        'password': model['password'].toString(),
        'dateOfBirth': model['dateOfBirth'].toString(),
        'phone': model['phone'].toString(),
        'city': model['city'].toString(),
        'country': model['country'].toString(),
        'gender': model['gender'].toString(),
        'numberOfMemorizedSurahs': model['numberOfMemorizedSurahs'].toString(),
        'numberOfMemorizedParts': model['numberOfMemorizedParts'].toString(),
        'details': model['details'].toString(),
      };
      request.fields.addAll(fields);

      if (model['profileImage'] != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'profileImage',
          model['profileImage'],
          filename: 'profileImage.png',
        ));
      }

      var response = await request.send();
      final responseData = await http.Response.fromStream(response);
      final Map<String, dynamic> jsonResponse = json.decode(responseData.body);

      debugPrint("----------------");
      debugPrint(jsonResponse.toString());
      if (response.statusCode == 201) {
        final registerResponseData =
            RegisterResponseData.fromJson(jsonResponse['data']);

        return {
          'statusCode': response.statusCode,
          'success': jsonResponse['success'] ?? false,
          'message': jsonResponse['message'] ?? '',
          'data': registerResponseData,
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'success': jsonResponse['success'] ?? false,
          'message': jsonResponse['message'] ?? '',
          'data': null,
        };
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Future<Object> registerSupervisor(Map<String, dynamic> model) async {
    try {
      String registerSupervisorRoute =
          "$alHudaBaseURL${AppRoutes.registerSupervisor}";

      String? lang = appService.languageStorage.read('language');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(registerSupervisorRoute),
      );

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Accept-Language'] = lang ?? 'en';
      debugPrint("-------------------");
      debugPrint(
          'fullName: ${model['fullName']}, email: ${model['email']}, password: ${model['password']}, dateOfBirth: ${model['dateOfBirth']}, phone: ${model['phone']}, city: ${model['city']}, country: ${model['country']}, gender: ${model['gender']}, numberOfMemorizedSurahs: ${model['numberOfMemorizedSurahs']}, numberOfMemorizedParts: ${model['numberOfMemorizedParts']}, details: ${model['details']}');
      var fields = {
        'fullName': model['fullName'].toString(),
        'email': model['email'].toString(),
        'password': model['password'].toString(),
        'dateOfBirth': model['dateOfBirth'].toString(),
        'phone': model['phone'].toString(),
        'city': model['city'].toString(),
        'country': model['country'].toString(),
        'gender': model['gender'].toString(),
        'numberOfMemorizedSurahs': model['numberOfMemorizedSurahs'].toString(),
        'numberOfMemorizedParts': model['numberOfMemorizedParts'].toString(),
        'details': model['details'].toString(),
      };
      request.fields.addAll(fields);

      if (model['profileImage'] != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'profileImage',
          model['profileImage'],
          filename: 'profileImage.png',
        ));
      }
      debugPrint("Certificate images: ${model['certificatesImages']}");
      if (model['certificatesImages'] != null) {
        for (var i = 0; i < model['certificatesImages'].length; i++) {
          debugPrint("Certificate image $i:}");
          request.files.add(http.MultipartFile.fromBytes(
            'certificatesImages',
            model['certificatesImages'][i],
            filename: 'certificatesImages$i.png',
          ));
        }
      }

      var response = await request.send();
      final responseData = await http.Response.fromStream(response);
      final Map<String, dynamic> jsonResponse = json.decode(responseData.body);

      debugPrint("----------------");
      debugPrint(jsonResponse.toString());
      if (response.statusCode == 201) {
        final registerResponseData =
            RegisterResponseData.fromJson(jsonResponse['data']);

        return {
          'statusCode': response.statusCode,
          'success': jsonResponse['success'] ?? false,
          'message': jsonResponse['message'] ?? '',
          'data': registerResponseData,
        };
      } else {
        return {
          'statusCode': response.statusCode,
          'success': jsonResponse['success'] ?? false,
          'message': jsonResponse['message'] ?? '',
          'data': null,
        };
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }
}
