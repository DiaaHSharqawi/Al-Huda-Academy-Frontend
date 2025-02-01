import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_current_groups_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/participant/participant_groups_response_model.dart';

class ParticipantCurrentGroupsController extends GetxController {
  final ParticipantCurrentGroupsService _participantCurrentGroupsService;

  ParticipantCurrentGroupsController(
    this._participantCurrentGroupsService,
  );

  var isLoading = false.obs;

  var participantGroupsList = <ParticipantGroup>[].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      debugPrint("SupervisorCurrentGroupsController onInit");

      queryParams['page'] = currentPage.value;
      queryParams['limit'] = limit.value;

      await fetchparticipantGroups();

      debounceSearchController();
    } catch (e) {
      debugPrint("Error during onInit: $e");
    }
  }

  void debounceSearchController() {
    debounce(
      searchQuery,
      (_) async {
        debugPrint("Debounced query triggered: ${searchQuery.value}");
        clearFilterQueryParams();
        queryParams['groupName'] = searchQuery.value;
        await fetchparticipantGroups();
      },
      time: const Duration(milliseconds: 1000),
    );
  }

  var queryParams = <String, dynamic>{}.obs;

  var sortOrder = SortOrder.notSelected.obs;

  var currentPage = 1.obs;
  var limit = 3.obs;

  var totalPages = 1.obs;
  var totalRecords = 0.obs;

  var searchQuery = ''.obs;

  var supervisorId = "".obs;

  TextEditingController searchController = TextEditingController();

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  void clearFilterQueryParams() {
    debugPrint(
        "------------------------------------- clearFilterQueryParams -------------------------------------");

    queryParams.clear();

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = limit.value;

    participantGroupsList.clear();
  }

  Map<String, dynamic> buildFilterQueryParams() {
    debugPrint("buildFilterQueryParams -------------------------------------");

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = limit.value;

    debugPrint(queryParams.toString());

    participantGroupsList.clear();

    return queryParams;
  }

  Future<void> fetchparticipantGroups() async {
    debugPrint(
        "------------------------------------- fetchparticipantGroups -------------------------------------");

    participantGroupsList.clear();

    isLoading(true);

    try {
      var participantGroupsResponse =
          await _participantCurrentGroupsService.fetchParticipantGroups(
        queryParams,
      );
      debugPrint("participantGroupsResponse");
      debugPrint(participantGroupsResponse.toString());

      if (participantGroupsResponse.statusCode == 200) {
        debugPrint("status code is 200 ");

        debugPrint("participantGroupsResponse.participantGroups");
        debugPrint(participantGroupsResponse.participantGroups.toString());
        debugPrint("participantGroupsResponse.participantGroupsMetaData");
        debugPrint(
            participantGroupsResponse.participantGroupsMetaData.toString());

        participantGroupsList
            .addAll(participantGroupsResponse.participantGroups);

        totalPages.value =
            participantGroupsResponse.participantGroupsMetaData!.totalPages!;

        totalRecords.value =
            participantGroupsResponse.participantGroupsMetaData!.totalRecords!;
      } else {
        totalPages.value = 0;
        totalRecords.value = 0;
      }
    } catch (e) {
      debugPrint("Error fetching participant groups: $e");
      participantGroupsList.clear();
      totalPages.value = 0;
      totalRecords.value = 0;
    } finally {
      isLoading(false);
    }
  }

  void navigateToParticipantGroupDashboardScreen(String groupId) {
    debugPrint("Navigate to group details screen");

    debugPrint("Group ID: $groupId");

    Get.toNamed(
      AppRoutes.participantGroupDashboard,
      arguments: groupId,
    );
  }
}
