import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/meeting_services/supervisor_meeting_dashboard_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/supervisor_groups_meeting_response_model.dart';

class SupervisorMeetingDashboardController extends GetxController {
  final SupervisorMeetingDashboardService _supervisorMeetingDashboardService;

  SupervisorMeetingDashboardController(this._supervisorMeetingDashboardService);

  var isLoading = false.obs;

  var queryParams = <String, dynamic>{}.obs;

  var supervisorGroupsList = <SupervisorGroup>[].obs;

  TextEditingController searchController = TextEditingController();

  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var totalRecords = 0.obs;
  var limit = 3.obs;

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  var sortOrder = SortOrder.notSelected.obs;

  var isFilterApplied = false.obs;

  var searchQuery = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isLoading(true);
      debounceSearchController();
      await fetchSupervisorGroupsMeeting();
    } catch (e) {
      debugPrint(
          "Error during onInit SupervisorMeetingDashboardController : $e");
    } finally {
      isLoading(false);
    }
  }

  String formatTime(String time) {
    DateTime dateTime = DateFormat("HH:mm").parse(time);

    String formattedTime = DateFormat('hh:mm a', 'ar').format(dateTime);

    formattedTime =
        formattedTime.replaceAll('AM', 'صباحاً').replaceAll('PM', 'مساءً');

    return formattedTime;
  }

  void debounceSearchController() {
    debounce(
      searchQuery,
      (_) async {
        debugPrint("Debounced query triggered: ${searchQuery.value}");
        clearFilterQueryParams();
        queryParams['groupName'] = searchQuery.value;
        await fetchSupervisorGroupsMeeting();
      },
      time: const Duration(milliseconds: 1000),
    );
  }

  Map<String, dynamic> buildFilterQueryParams() {
    debugPrint("buildFilterQueryParams -------------------------------------");

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = totalRecords.value;

    if (searchQuery.value.isNotEmpty) {
      queryParams['fullName'] = searchQuery.value;
    }
    if (sortOrder.value != SortOrder.notSelected) {
      queryParams['sortOrder'] =
          sortOrder.value == SortOrder.ascending ? 'asc' : 'desc';
    }

    debugPrint(queryParams.toString());

    supervisorGroupsList.clear();

    return queryParams;
  }

  void clearFilterQueryParams() {
    debugPrint(
        "------------------------------------- clearFilterQueryParams -------------------------------------");

    isFilterApplied.value = false;

    sortOrder.value = SortOrder.notSelected;

    totalPages.value = 1;
    totalRecords.value = 0;
    currentPage.value = 1;

    queryParams.clear();

    supervisorGroupsList.clear();
  }

  Future<void> fetchSupervisorGroupsMeeting() async {
    debugPrint(
        "------------------------------------- fetchSupervisorGroupsMeeting -------------------------------------");

    supervisorGroupsList.clear();

    isLoading(true);

    try {
      var supervisorGroupsResponse =
          await _supervisorMeetingDashboardService.fetchSupervisorGroupsMeeting(
        queryParams,
      );
      debugPrint("supervisorGroupsResponse");
      debugPrint(supervisorGroupsResponse.toString());

      if (supervisorGroupsResponse.statusCode == 200) {
        debugPrint("status code is 200 ");

        debugPrint("supervisorGroupsResponse.supervisorGroups");

        debugPrint(supervisorGroupsResponse.toJson().toString());

        supervisorGroupsList.addAll(supervisorGroupsResponse.supervisorGroups);

        debugPrint("supervisorGroupsList*****");

        debugPrint(supervisorGroupsList.toString());

        totalPages.value =
            supervisorGroupsResponse.supervisorGroupsMetaData?.totalPages ?? 1;

        currentPage.value =
            supervisorGroupsResponse.supervisorGroupsMetaData?.currentPage ?? 1;

        totalRecords.value =
            supervisorGroupsResponse.supervisorGroupsMetaData?.totalRecords ??
                0;
      } else {
        totalPages.value = 0;
        totalRecords.value = 0;
      }
    } catch (e) {
      debugPrint("Error fetching supervisor groups: $e");
      supervisorGroupsList.clear();
      totalPages.value = 0;
      totalRecords.value = 0;
    } finally {
      isLoading(false);
    }
  }
}
