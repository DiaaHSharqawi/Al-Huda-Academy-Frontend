import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_search_memorization_group_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/Languages/languages_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/gender_search_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_content_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_search_filter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/supervisor_langugue_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_goal_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_search_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/teaching_methods_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/surahs/surahs.dart';

class ParticipantSearchMemorizationGroupController extends GetxController {
  var isLoading = false.obs;

  final surahs = <Surah>[].obs;

  final List<Juza> juzas = [];

  final List<Gender> genders = [];

  final List<GroupGoal> groupGoals = [];

  final List<Language> groupLanguages = [];

  final List<TeachingMethod> teachingMethods = [];

  var memorizationGroups = RxList<GroupSearchModel>();

  final ScrollController scrollController = ScrollController();

  var isFilterApplied = false.obs;

  var currentPage = 1.obs;
  var limit = 10.obs;

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  var queryParams = <String, dynamic>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    debugPrint("onInit");

    try {
      isLoading.value = true;

      queryParams.value = {
        'page': currentPage.value,
        'limit': limit.value,
      };
      await getSurahList();
      await getJuzaList();
      await getGenderList();
      await getGroupGoalList();
      await getGroupLanguagesList();
      await getTeachingMethodsList();

      await fetchMemorizationGroup();
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }

    debounce(
      searchQuery,
      (_) {
        if (searchQuery.value.isEmpty) {
          memorizationGroups.clear();
          currentPage.value = 1;
        }

        debugPrint("Debounced query triggered: ${searchQuery.value}");
        buildFilterQueryParams();
        fetchMemorizationGroup();
      },
      time: const Duration(milliseconds: 1200),
    );
  }

  var selectedGender = GenderSearchFiltter.notSelected.obs;
  var selectedGenderId = 0.obs;

  var selectedGroupObjective = GroupObjectiveSearchFiltter.all.obs;

  var selectedSupervisorLanguage = SupervisorLangugueFilter.all.obs;

  var selectedGroupContent = GroupContentFilter.all.obs;

  TextEditingController searchController = TextEditingController();

  var searchQuery = ''.obs;

  var selectedSurahs = <Surah>[].obs;

  var selectedJuzzas = [].obs;

  final ParticipantSearchMemorizationGroupService
      _participantSearchMemorizationGroupService;
  ParticipantSearchMemorizationGroupController(
      this._participantSearchMemorizationGroupService);

  Future<void> fetchMemorizationGroup() async {
    try {
      isLoading(true);
      memorizationGroups.clear();

      debugPrint("fetchMemorizationGroup");
      debugPrint("queryParams");
      debugPrint(queryParams.toString());

      GroupSearchResponseModel groupSearchResponseModel =
          await _participantSearchMemorizationGroupService
              .fetchMemorizationGroup(queryParams);

      if (groupSearchResponseModel.statusCode == 200 &&
          groupSearchResponseModel.groupSearchModels.isNotEmpty) {
        debugPrint("groupSearchResponseModel");
        debugPrint(groupSearchResponseModel.groupSearchModels.first.toString());

        memorizationGroups.addAll(groupSearchResponseModel.groupSearchModels);

        debugPrint("memorizationGroups*****");
        debugPrint(memorizationGroups.toString());

        debugPrint(memorizationGroups.length.toString());

        totalPages.value = groupSearchResponseModel.metaData!.totalPages!;

        totalMemorizationGroups =
            groupSearchResponseModel.metaData!.totalNumberOfMemorizationGroup!;
      } else if (groupSearchResponseModel.statusCode == 404) {
        memorizationGroups.clear();
        currentPage.value = 1;
      }
    } catch (e) {
      debugPrint('Error fetching memorization groups: $e');
    } finally {
      isLoading(false);
    }
  }

  var isMoreDataLoading = false.obs;

  var totalPages = 1.obs;
  late int totalMemorizationGroups;

  Future<void> getSurahList() async {
    var surahs =
        await _participantSearchMemorizationGroupService.getSurahList();
    debugPrint("controller");
    debugPrint(surahs.firstOrNull.toString());
    if (surahs.isNotEmpty) {
      this.surahs.addAll(surahs);
    }
  }

  Future<void> getJuzaList() async {
    var juzas = await _participantSearchMemorizationGroupService.getJuzaList();
    debugPrint("juzas");
    debugPrint(juzas.toString());
    if (juzas.isNotEmpty) {
      this.juzas.addAll(juzas);
    }
  }

  Future<void> getGenderList() async {
    var genders =
        await _participantSearchMemorizationGroupService.getGenderList();
    debugPrint("genders");
    debugPrint(genders.toString());
    if (genders.isNotEmpty) {
      this.genders.addAll(genders);
    }
  }

  Future<void> getGroupGoalList() async {
    var groupGoalsResponse =
        await _participantSearchMemorizationGroupService.getGroupGoalList();
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

  Future<void> getGroupLanguagesList() async {
    var groupLanguagesResponse =
        await _participantSearchMemorizationGroupService
            .getGroupLanguagesList();

    debugPrint("groupLanguagesResponse");
    debugPrint(groupLanguagesResponse.toString());
    if (groupLanguagesResponse.isNotEmpty) {
      debugPrint("added groupLanguagesResponse");
      debugPrint(groupLanguagesResponse.toString());
      groupLanguages.addAll(groupLanguagesResponse);
    }
  }

  Future<void> getTeachingMethodsList() async {
    var teachingMethodsResponse =
        await _participantSearchMemorizationGroupService
            .getTeachingMethodsList();

    debugPrint("teachingMethodsResponse");
    debugPrint(teachingMethodsResponse.toString());

    if (teachingMethodsResponse.isNotEmpty) {
      debugPrint("added teachingMethodsResponse");
      debugPrint(teachingMethodsResponse.toString());

      teachingMethods.addAll(teachingMethodsResponse);
    }
  }

  Map<String, dynamic> buildFilterQueryParams() {
    isFilterApplied.value = true;
    // queryParams.clear();
    // clearFilterQueryParams();

    currentPage.value = 1;
    limit.value = 10;

    if (searchController.text.isNotEmpty) {
      queryParams['groupName'] = searchController.text;
    }

    if (selectedGender.value != GenderSearchFiltter.notSelected) {
      debugPrint("selectedGender: ${selectedGender.value}");

      final gender = genders.firstWhereOrNull(
        (gender) => gender.nameEn == selectedGender.value.name,
      );
      debugPrint("selected  $gender");
      if (gender != null) {
        queryParams['gender_id'] = gender.id;
      }
    }

    if (selectedGroupObjective.value != GroupObjectiveSearchFiltter.all) {
      int? groupGoalId = groupGoals
          .firstWhere((element) =>
              element.groupGoalEng == selectedGroupObjective.value.name)
          .id;

      if (groupGoalId != null) {
        queryParams['group_goal_id'] = groupGoalId;
      }

      debugPrint("selectedGroupObjective: ${selectedGroupObjective.value}");
    }

    if (selectedSupervisorLanguage.value != SupervisorLangugueFilter.all) {
      int? languageId = groupLanguages
          .firstWhere((element) =>
              element.nameEn == selectedSupervisorLanguage.value.name)
          .id;

      if (languageId != null) {
        queryParams['language_id'] = languageId;
      }
    }

    if (selectedGroupContent.value != GroupContentFilter.all) {
      debugPrint("selectedGroupContent: ${selectedGroupContent.value}");

      debugPrint("teaching method id ");
      String teachingMethodId = teachingMethods
          .firstWhere((element) =>
              element.methodNameEnglish == selectedGroupContent.value.name)
          .id
          .toString();
      debugPrint(teachingMethodId);

      if (teachingMethodId == "3") {
        queryParams['teaching_method_id'] = teachingMethodId.toString();
        if (selectedJuzzas.isNotEmpty) {
          queryParams['juza_ids'] = selectedJuzzas.map((j) => j.id).toList();
        }
      } else if (teachingMethodId == "4") {
        queryParams['teaching_method_id'] = teachingMethodId.toString();
        if (selectedSurahs.isNotEmpty) {
          queryParams['surah_ids'] = selectedSurahs.map((s) => s.id).toList();
        }
      } else {
        queryParams['teaching_method_id'] = teachingMethodId.toString();
        queryParams['extract_ids'] = [];
      }
    }

    debugPrint(queryParams.toString());

    memorizationGroups.clear();
    debugPrint(memorizationGroups.toString());

    return queryParams;
  }

  void clearFilterQueryParams() {
    // Gender clear
    selectedGender.value = GenderSearchFiltter.both;
    selectedGenderId.value = 0;

    selectedGender.value = GenderSearchFiltter.notSelected;
    selectedGroupObjective.value = GroupObjectiveSearchFiltter.all;
    selectedSupervisorLanguage.value = SupervisorLangugueFilter.all;
    selectedGroupContent.value = GroupContentFilter.all;
    //  selectedPartOfQuranType.value = SelectedPartOfQuranFiltter.surahs;
    selectedSurahs.clear();
    selectedJuzzas.clear();
  }

  void navigateToGroupDetailsScreen(String groupId) {
    debugPrint("groupId when called: $groupId");
    Get.toNamed(
      AppRoutes.participantSearchedGroupDetails,
      arguments: groupId,
    );
  }
}
