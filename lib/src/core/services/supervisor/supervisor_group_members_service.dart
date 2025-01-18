import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/services/base_getx_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_membership_response_model.dart';
import 'package:http/http.dart' as http;

class SupervisorGroupMembersService extends BaseGetxService {
  Future<GroupMembersResponseModel> fetchGroupMembers(
    String groupId,
    Map<String, dynamic> filter,
  ) async {
    String supervisorGroupsRoutes =
        "${super.getAlHudaBaseURL}/supervisor/groups/$groupId/members";

    final url = Uri.parse(supervisorGroupsRoutes);
    debugPrint("$url");

    String? lang = super.getAppService.languageStorage.read('language');
    debugPrint("lang device : $lang");

    debugPrint("Filter: ${filter.toString()}");
    try {
      final queryParameters =
          filter.map((key, value) => MapEntry(key, value.toString()));

      debugPrint("Query Parameters: $queryParameters");
      debugPrint("Final URL: ${url.replace(queryParameters: queryParameters)}");

      debugPrint("Token: ${await super.getToken()}");

      final response = await http.get(
        url.replace(queryParameters: queryParameters),
        headers: <String, String>{
          'Accept-Language': lang ?? 'en',
          'Authorization': (await super.getToken()).toString(),
        },
      ).timeout(const Duration(seconds: 10));
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      GroupMembersResponseModel groupMembershipResponseModel =
          GroupMembersResponseModel.fromJson(data, response.statusCode);

      debugPrint("Data: $data");
      debugPrint("groupMembershipResponseModel: $groupMembershipResponseModel");

      return groupMembershipResponseModel;
    } catch (e) {
      debugPrint("Error: $e");
      return GroupMembersResponseModel(
        statusCode: 500,
        message: "Error: $e",
        groupMembersMetaData: null,
        success: null,
        groupMembers: [],
      );
    }
  }
}
