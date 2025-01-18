import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response/register_response_data.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/quran_memorizing_amount/quran_memorizing_amount_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/roles/role_response_model.dart';

class RegisterService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';
  static final registerRoute = "$alHudaBaseURL${AppRoutes.register}";
  var appService = Get.find<AppService>();

  Future<List<Juza>> getJuzaList() async {
    final url = Uri.parse("$alHudaBaseURL/quran/juzas");
    debugPrint("$url");
    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);
      JuzaResponse juzaResponse = JuzaResponse.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(juzaResponse.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("juzaa list: ${data['data']}");
        return juzaResponse.juzas;
      } else {
        debugPrint("Failed to get surah list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<Gender>> getGenderList() async {
    final url = Uri.parse("$alHudaBaseURL/gender");
    debugPrint("$url");
    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);
      GenderResponseModel genderResponseModel =
          GenderResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(genderResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("gender list: ${data['data']}");
        return genderResponseModel.genders;
      } else {
        debugPrint("Failed to get gender list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<Role>> getRoleList() async {
    final url = Uri.parse("$alHudaBaseURL/roles");
    debugPrint("$url");
    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      RoleResponseModel roleResponseModel = RoleResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(roleResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("roleResponseModel list: ${data['data']}");
        return roleResponseModel.roles;
      } else {
        debugPrint("Failed to get roleResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<List<QuranMemorizingAmount>> getQuranMemorizingAmountList() async {
    final url = Uri.parse("$alHudaBaseURL/quran-memorizing-amount");
    debugPrint("$url");

    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      QuranMemorizingAmountResponseModel quranMemorizingAmountResponseModel =
          QuranMemorizingAmountResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(quranMemorizingAmountResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("quranMemorizingAmountResponseModel list: ${data['data']}");
        return quranMemorizingAmountResponseModel.quranMemorizingAmount;
      } else {
        debugPrint(
            "Failed to get quranMemorizingAmountResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }

  Future<Object> isUserExist(String email) async {
    try {
      String getUserRoute = "$alHudaBaseURL/users/user";
      String? lang = appService.languageStorage.read('language');

      var uri = Uri.parse(getUserRoute);

      var request = http.Request('GET', uri);
      request.body = json.encode({'email': email});

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

      debugPrint("model['juza_ids'] type: ${model['juza_ids'].runtimeType}");

      request.headers['Accept'] = 'application/json';
      request.headers['Accept-Language'] = lang ?? 'en';

      var fields = <String, dynamic>{
        'fullName': model['fullName'].toString(),
        'email': model['email'].toString(),
        'password': model['password'].toString(),
        'dateOfBirth': model['dateOfBirth'].toString(),
        'phone': model['phone'].toString(),
        'city': model['city'].toString(),
        'country': model['country'].toString(),
        'gender_id': model['gender_id'].toString(),
        'details': model['details'].toString(),
        'quranMemorizingAmountsId':
            model['quranMemorizingAmountsId'].toString(),
        'selectedMemorizingOption': model['selectedMemorizingOption'],
      };

      debugPrint(" model['juza_ids']) : ${model['juza_ids']}");
      if (model['juza_ids'] != null && model['juza_ids'] is List<int>) {
        for (int i = 0; i < model['juza_ids'].length; i++) {
          int id = model['juza_ids'][i];
          debugPrint("id: $id");

          request.fields['juza_ids[$i]'] = id.toString();
        }
      }
      debugPrint("fields: $fields");

      debugPrint('juza_ids: ${fields['juza_ids']},');

      debugPrint('juza_ids: ${fields['juza_ids']},');

      request.fields.addAll(fields.map((key, value) {
        return MapEntry(key, value);
      }));

      // Add profile image if provided
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

      var fields = {
        'fullName': model['fullName'].toString(),
        'email': model['email'].toString(),
        'password': model['password'].toString(),
        'dateOfBirth': model['dateOfBirth'].toString(),
        'phone': model['phone'].toString(),
        'city': model['city'].toString(),
        'country': model['country'].toString(),
        'gender_id': model['gender_id'].toString(),
        'details': model['details'].toString(),
        'selectedMemorizingOption':
            model['selectedMemorizingOption'].toString(),
      };

      debugPrint(" model['juza_ids']) : ${model['juza_ids']}");
      if (model['juza_ids'] != null && model['juza_ids'] is List<int>) {
        for (int i = 0; i < model['juza_ids'].length; i++) {
          int id = model['juza_ids'][i];
          debugPrint("id: $id");

          request.fields['juza_ids[$i]'] = id.toString();
        }
      }

      debugPrint(request.fields.toString());

      request.fields.addAll(fields.map((key, value) {
        return MapEntry(key, value);
      }));

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
