import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/group_dashboard_response_model.dart';

class SupervisorGroupDashboardService extends GetxService {
  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';

  var appService = Get.find<AppService>();

  Future<GroupDashboardResponseModel> fetchSupervisorGroupDashboard(
      String groupId, Map<String, dynamic> filter) async {
    String supervisorDashboardRoute =
        "$alHudaBaseURL/supervisor/groups/$groupId/dashboard";

    final url = Uri.parse(supervisorDashboardRoute);
    debugPrint("$url");

    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    debugPrint("Filter: ${filter.toString()}");
    try {
      final queryParameters =
          filter.map((key, value) => MapEntry(key, value.toString()));

      debugPrint("Query Parameters: $queryParameters");
      debugPrint("Final URL: ${url.replace(queryParameters: queryParameters)}");

      final response = await http.get(
        url.replace(queryParameters: queryParameters),
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
          'Authorization': appService.getToken().toString(),
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      GroupDashboardResponseModel groupDashboardResponseModel =
          GroupDashboardResponseModel.fromJson(data, response.statusCode);
      debugPrint("Data: $data");
      debugPrint("groupDashboardResponseModel: $groupDashboardResponseModel");

      return groupDashboardResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return GroupDashboardResponseModel(
        statusCode: 500,
        success: false,
        message: 'Error in fetchSupervisorGroupDashboard',
        groupDashboard: null,
      );
    }
  }

  /*
  
  Future<SupervisorGroupsResponseModel> fetchSupervisorGroups(
      String supervisorId,
      String groupStatusId,
      Map<String, dynamic> filter) async {
    String supervisorGroupsRoutes = "$alHudaBaseURL/supervisor/groups";

    final url = Uri.parse(supervisorGroupsRoutes);
    debugPrint("$url");

    String? lang = appService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    debugPrint("Filter: ${filter.toString()}");
    try {
      final queryParameters =
          filter.map((key, value) => MapEntry(key, value.toString()));

      debugPrint("Query Parameters: $queryParameters");
      debugPrint("Final URL: ${url.replace(queryParameters: queryParameters)}");

      debugPrint("supervisorId: $supervisorId");
      debugPrint("groupStatusId: $groupStatusId");

      final response = await http
          .post(
            url.replace(queryParameters: queryParameters),
            headers: <String, String>{
              'Accept-Language': lang ?? 'en',
            },
            body: ({
              "supervisorId": supervisorId.toString(),
              "groupStatusId": groupStatusId.toString(),
            }),
          )
          .timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      SupervisorGroupsResponseModel supervisorGroupsResponseModel =
          SupervisorGroupsResponseModel.fromJson(data, response.statusCode);
      debugPrint("Data: $data");
      debugPrint(
          "supervisorGroupsResponseModel: $supervisorGroupsResponseModel");

      return supervisorGroupsResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return SupervisorGroupsResponseModel(
        statusCode: 500,
        success: false,
        message: "Error in fetchSupervisorGroups",
        supervisorGroupsList: [],
        supervisorGroupsMetaData: null,
      );
    }
  }

  Future<List<GroupStatus>> getGroupStatusList() async {
    final url = Uri.parse("$alHudaBaseURL/group-status");
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
      GroupStatusResponseModel groupStatusResponseModel =
          GroupStatusResponseModel.fromJson(data);

      debugPrint("*-*-*-*-*-");
      debugPrint(groupStatusResponseModel.toString());
      debugPrint("Data: $data");

      if (data['success']) {
        debugPrint("groupStatusResponseModel list: ${data['data']}");
        return groupStatusResponseModel.groupStatus;
      } else {
        debugPrint(
            "Failed to get groupStatusResponseModel list: ${data['message']}");
        return [];
      }
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }
   */
}
