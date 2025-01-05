import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_requests_for_creating_group_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/admin_requests_for_creating_groups_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/gender_search_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_search_filter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_goal_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/participant_level_response_model.dart';

class AdminRequestsForCreatingGroupController extends GetxController {
  final AdminRequestsForCreatingGroupService
      _adminRequestsForCreatingGroupService;

  void navigateToRequestsForCreatingGroupScreen() {
    Get.toNamed(AppRoutes.adminRequestedGroupDetails);
  }

  AdminRequestsForCreatingGroupController(
      this._adminRequestsForCreatingGroupService);

  var isFilterApplied = false.obs;
  var searchQuery = ''.obs;

  TextEditingController searchController = TextEditingController();

  var queryParams = <String, dynamic>{}.obs;

  final List<Gender> genders = [];
  var selectedGender = GenderSearchFiltter.notSelected.obs;
  var selectedGenderId = ''.obs;

  final List<ParticipantLevel> participantLevels = [];
  var selectedParticipantLevels = Rx<RangeValues>(const RangeValues(1, 2));
  var selectedParticipantLevelId = ''.obs;

  final List<GroupGoal> groupGoals = [];
  var selectedGroupObjective = GroupObjectiveSearchFiltter.all.obs;
  var selectedGroupObjectiveId = ''.obs;

  var requestsForCreatingGroupsModelsList = RxList<RequestsForCreatingGroup>();

  var limit = 3.obs;
  var totalPages = 0.obs;
  int totalRequestsForCreatingGroups = 0;

  var sortOrder = SortOrder.notSelected.obs;

  var currentPage = 1.obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading(true);

      await getGenderList();
      setSelectedGenderId();

      await getGroupGoalList();
      setSelectedGoalId();

      await getParticipantLevelList();
      setParticipantLevelId();

      queryParams.value = {
        'page': currentPage.value,
        'limit': limit.value,
      };
      totalPages.value = 0;
      totalRequestsForCreatingGroups = 0;

      await fetchRequestsForCreatingGroup();
    } catch (e) {
      debugPrint('Error fetching gender list: ${e.toString()}');
    } finally {
      isLoading(false);
    }

    debounce(
      searchQuery,
      (_) {
        if (searchQuery.value.isEmpty) {
          requestsForCreatingGroupsModelsList.clear();
          currentPage.value = 1;
        }

        debugPrint("Debounced query triggered: ${searchQuery.value}");
        buildFilterQueryParams();
        fetchRequestsForCreatingGroup();
      },
      time: const Duration(milliseconds: 1200),
    );
  }

  void navigateToRequestsForCreatingGroupDetails(String id) {
    Get.toNamed(AppRoutes.adminRequestedGroupDetails, arguments: id);
  }

  void setParticipantLevelId() {
    final levelMap = {
      1: "junior",
      2: "average",
      3: "advanced",
      1.5: "junior-average",
      2.5: "average-advanced",
    };

    final start = selectedParticipantLevels.value.start;
    final end = selectedParticipantLevels.value.end;

    debugPrint("start: $start, end: $end");
    int? levelId;

    if (start == end) {
      levelId = participantLevels
          .firstWhere((level) => level.participantLevelEn == levelMap[start])
          .id;
    } else {
      //  debugPrint("levelMap[(start + end) ]: ${[(start + end) / 2]}");
      // debugPrint("levelMap[(start + end) / 2]: ${levelMap[(start + end) / 2]}");
      ParticipantLevel? level = participantLevels.firstWhere(
          (level) => level.participantLevelEn == levelMap[(start + end) / 2]);

      //debugPrint("level *****: $level");

      levelId = level.id;
    }

    selectedParticipantLevelId.value = levelId.toString();
  }

  void setSelectedGenderId() {
    debugPrint("setSelectedGenderId: ${selectedGender.value}");

    final gender = genders.firstWhereOrNull(
      (gender) => gender.nameEn == selectedGender.value.name,
    );
    debugPrint("gender *****: $gender");
    if (gender != null) {
      selectedGenderId.value = gender.id.toString();
    }
  }

  void setSelectedGoalId() {
    final goal = groupGoals.firstWhereOrNull(
      (goal) => goal.groupGoalEng == selectedGroupObjective.value.name,
    );

    debugPrint("goal *****: $goal");
    if (goal != null) {
      selectedGroupObjectiveId.value = goal.id.toString();
    }
  }

  Map<String, dynamic> buildFilterQueryParams() {
    debugPrint("buildFilterQueryParams -------------------------------------");

    isFilterApplied.value = true;

    currentPage.value = 1;
    limit.value = 10;

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = limit.value;

    debugPrint("searchController.text: ${searchController.text}");
    debugPrint("selectedGender: ${selectedGender.value}");
    debugPrint("selectedGroupObjective: ${selectedGroupObjective.value}");
    debugPrint("selectedParticipantLevels: ${selectedParticipantLevels.value}");

    if (searchController.text.isNotEmpty) {
      queryParams['groupName'] = searchController.text;
    }

    if (selectedGender.value != GenderSearchFiltter.notSelected) {
      debugPrint("selectedGenderId: ${selectedGenderId.value}");

      setSelectedGenderId();
      queryParams['gender_id'] = selectedGenderId;
    }

    if (selectedGroupObjective.value != GroupObjectiveSearchFiltter.all) {
      setSelectedGoalId();
      queryParams['group_goal_id'] = selectedGroupObjectiveId.value;

      debugPrint("selectedGroupObjective: ${selectedGroupObjective.value}");
    }

    if (((selectedParticipantLevels.value.start != 1 ||
            selectedParticipantLevels.value.end != 3) &&
        isFilterApplied.value)) {
      setParticipantLevelId();

      debugPrint(
          "selectedParticipantLevelId: ${selectedParticipantLevelId.value}");
      queryParams['participants_level_id'] = selectedParticipantLevelId.value;
    }

    if (sortOrder.value != SortOrder.notSelected) {
      queryParams['sortOrder'] =
          sortOrder.value == SortOrder.ascending ? 'asc' : 'desc';
    }

    debugPrint(queryParams.toString());

    requestsForCreatingGroupsModelsList.clear();
    //debugPrint(memorizationGroups.toString());

    return queryParams;
  }

  void clearFilterQueryParams() {
    // Gender clear
    selectedGender.value = GenderSearchFiltter.both;
    selectedGenderId.value = "";

    selectedGender.value = GenderSearchFiltter.notSelected;
    selectedGroupObjective.value = GroupObjectiveSearchFiltter.all;

    selectedParticipantLevels.value = const RangeValues(1, 3);
    selectedParticipantLevelId.value = "";

    sortOrder.value = SortOrder.notSelected;

    searchController.clear();
    queryParams.clear();
    requestsForCreatingGroupsModelsList.clear();

    currentPage.value = 1;
    limit.value = 10;
  }

  Future<void> getGenderList() async {
    var gendersResponse =
        await _adminRequestsForCreatingGroupService.getGenderList();
    debugPrint("gendgendersResponseers");
    debugPrint(gendersResponse.toString());
    if (gendersResponse.isNotEmpty) {
      genders.addAll(gendersResponse);
    }
  }

  Future<void> getParticipantLevelList() async {
    var participantLevelResponse =
        await _adminRequestsForCreatingGroupService.getParticipantLevelList();
    debugPrint("participantLevelResponse");
    debugPrint(participantLevelResponse.toString());
    if (participantLevelResponse.isNotEmpty) {
      debugPrint("added participantLevelResponse");
      debugPrint(participantLevelResponse.toString());
      participantLevels.addAll(participantLevelResponse);
    }
  }

  Future<void> getGroupGoalList() async {
    var groupGoalsResponse =
        await _adminRequestsForCreatingGroupService.getGroupGoalList();
    debugPrint("groupGoalsResponse");
    debugPrint(groupGoalsResponse.toString());
    if (groupGoalsResponse.isNotEmpty) {
      debugPrint("added groupGoalsResponse");
      debugPrint(groupGoalsResponse.toString());

      groupGoals.addAll(groupGoalsResponse);

      debugPrint("groupGoals***");
      debugPrint(groupGoals.toString());
    }
  }

  Future<void> fetchRequestsForCreatingGroup() async {
    try {
      isLoading(true);

      requestsForCreatingGroupsModelsList.clear();

      debugPrint("fetchRequestsForCreatingGroup");

      debugPrint("queryParams");
      debugPrint(queryParams.toString());

      AdminRequestsForCreatingGroupsResponseModel
          adminRequestsForCreatingGroupsResponseModel =
          await _adminRequestsForCreatingGroupService
              .fetchRequestsForCreatingGroup(queryParams);

      if (adminRequestsForCreatingGroupsResponseModel.statusCode == 200 &&
          adminRequestsForCreatingGroupsResponseModel
              .requestsForCreatingGroupsModels.isNotEmpty) {
        debugPrint("adminRequestsForCreatingGroupsResponseModel");
        debugPrint(adminRequestsForCreatingGroupsResponseModel
            .requestsForCreatingGroupsModels.first
            .toString());

        requestsForCreatingGroupsModelsList.addAll(
          adminRequestsForCreatingGroupsResponseModel
              .requestsForCreatingGroupsModels,
        );

        debugPrint("requestsForCreatingGroupsModelsList*****");
        debugPrint(requestsForCreatingGroupsModelsList.toString());

        debugPrint(requestsForCreatingGroupsModelsList.length.toString());

        totalPages.value =
            adminRequestsForCreatingGroupsResponseModel.metaData!.totalPages!;

        totalRequestsForCreatingGroups =
            adminRequestsForCreatingGroupsResponseModel
                .metaData!.totalNumberOfRequestsForCreatingGroups!;
      } else if (adminRequestsForCreatingGroupsResponseModel.statusCode ==
          404) {
        requestsForCreatingGroupsModelsList.clear();
      }
    } catch (e) {
      debugPrint('Error fetching requests for creating group: $e');
    } finally {
      isLoading(false);
    }
  }
}
