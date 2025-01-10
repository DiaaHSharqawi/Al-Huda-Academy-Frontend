import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_current_groups_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_status/group_status_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/supervisor_groups_response_model.dart';

class SupervisorCurrentGroupsController extends GetxController {
  final SupervisorCurrentGroupsService _supervisorCurrentGroupsService;
  SupervisorCurrentGroupsController(this._supervisorCurrentGroupsService);

  @override
  void onInit() async {
    super.onInit();
    try {
      debugPrint("SupervisorCurrentGroupsController onInit");
      var appService = Get.find<AppService>();

      supervisorId.value = appService.user.value!.getMemberId();
      await getGroupStatusList();

      await fetchSupervisorGroups();

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
        await fetchSupervisorGroups();
      },
      time: const Duration(milliseconds: 1000),
    );
  }

  var isLoading = false.obs;

  var queryParams = <String, dynamic>{}.obs;

  var supervisorGroupsList = <SupervisorGroup>[].obs;

  var sortOrder = SortOrder.notSelected.obs;

  var currentPage = 1.obs;
  var limit = 3.obs;

  var totalPages = 1.obs;
  var totalRecords = 0.obs;

  var searchQuery = ''.obs;

  var supervisorId = "".obs;

  TextEditingController searchController = TextEditingController();

  final List<GroupStatus> groupStatus = [];

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  void clearFilterQueryParams() {
    debugPrint(
        "------------------------------------- clearFilterQueryParams -------------------------------------");

    queryParams.clear();

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = limit.value;

    supervisorGroupsList.clear();
  }

  Map<String, dynamic> buildFilterQueryParams() {
    debugPrint("buildFilterQueryParams -------------------------------------");

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = limit.value;

    debugPrint(queryParams.toString());

    supervisorGroupsList.clear();

    return queryParams;
  }

  Future<void> fetchSupervisorGroups() async {
    debugPrint("fetchSupervisorGroups -------------------------------------");

    supervisorGroupsList.clear();

    isLoading(true);

    String activeStatusId = groupStatus
        .firstWhere((element) => element.statusNameEn == "active")
        .id
        .toString();

    debugPrint("activeStatusId");
    debugPrint(activeStatusId);

    debugPrint("supervisorId.value");
    debugPrint(supervisorId.value);

    try {
      var supervisorGroupsResponse =
          await _supervisorCurrentGroupsService.fetchSupervisorGroups(
        supervisorId.value,
        activeStatusId,
        queryParams,
      );
      debugPrint("supervisorGroupsResponse");
      debugPrint(supervisorGroupsResponse.toString());

      if (supervisorGroupsResponse.statusCode == 200) {
        debugPrint("status code is 200 ");

        supervisorGroupsList
            .addAll(supervisorGroupsResponse.supervisorGroupsList);

        totalPages.value =
            supervisorGroupsResponse.supervisorGroupsMetaData!.totalPages!;

        totalRecords.value =
            supervisorGroupsResponse.supervisorGroupsMetaData!.totalRecords!;
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

  Future<void> getGroupStatusList() async {
    var getGroupStatusResponse =
        await _supervisorCurrentGroupsService.getGroupStatusList();
    debugPrint("getGroupStatusResponse");
    debugPrint(getGroupStatusResponse.toString());
    if (getGroupStatusResponse.isNotEmpty) {
      groupStatus.addAll(getGroupStatusResponse);
    }
  }
}
