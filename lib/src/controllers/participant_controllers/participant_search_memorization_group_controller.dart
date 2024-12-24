import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_search_memorization_group_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/gender_search_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_content_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_search_filter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/selected_part_of_quran_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/supervisor_langugue_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_search_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/surahs/surahs.dart';

class ParticipantSearchMemorizationGroupController extends GetxController {
  var isLoading = false.obs;

  final surahs = <Surah>[].obs;

  final List<Juza> juzas = [];

  var memorizationGroups = RxList<GroupSearchModel>();

  final ScrollController scrollController = ScrollController();

  var isFilterApplied = false.obs;

  var page = 1.obs;
  var limit = 10.obs;

  var queryParams = <String, dynamic>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    debugPrint("onInit");

    try {
      isLoading.value = true;

      await getSurahList();
      await getJuzaList();

      queryParams.value = {
        'page': page.value,
        'limit': limit.value,
      };
      await getSurahList();
      await getJuzaList();
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
          page.value = 1;
        }

        debugPrint("Debounced query triggered: ${searchQuery.value}");
        buildFilterQueryParams();
        fetchMemorizationGroup();
      },
      time: const Duration(milliseconds: 1200),
    );
  }

  var selectedGender = GenderSearchFiltter.notSelected.obs;

  var selectedGroupObjective = GroupObjectiveSearchFiltter.all.obs;

  var selectedSupervisorLanguage = SupervisorLangugueFilter.all.obs;

  var selectedGroupContent = GroupContentFilter.allOfQuran.obs;

  TextEditingController searchController = TextEditingController();

  var searchQuery = ''.obs;

  var selectedSurahs = <Surah>[].obs;

  var selectedJuzzas = [].obs;

  var selectedPartOfQuranType = SelectedPartOfQuranFiltter.notSelected.obs;

  var selectedStudentLevelRange = const RangeValues(0, 3).obs;

  final ParticipantSearchMemorizationGroupService
      _participantSearchMemorizationGroupService;
  ParticipantSearchMemorizationGroupController(
      this._participantSearchMemorizationGroupService) {
    scrollController.addListener(scrollListener);
  }

  var selectedStudentLevel = 0.obs;

  Future<void> fetchMemorizationGroup() async {
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

      totalPages = groupSearchResponseModel.metaData!.totalPages!;

      totalMemorizationGroups =
          groupSearchResponseModel.metaData!.totalNumberOfMemorizationGroup!;
    } else if (groupSearchResponseModel.statusCode == 404) {
      memorizationGroups.clear();
      page.value = 1;
    }
  }

  var isMoreDataLoading = false.obs;

  late int totalPages;
  late int totalMemorizationGroups;

  Future<void> scrollListener() async {
    debugPrint("scrollListener");
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await loadMoreData();
    }
  }

  Future<void> loadMoreData() async {
    debugPrint("load more .............................");
    debugPrint("${isMoreDataLoading.value}");
    debugPrint("cuurent page value : ${page.value}");
    debugPrint("totalPages : $totalPages");
    if (memorizationGroups.length < totalMemorizationGroups) {
      isMoreDataLoading.value = true;
      debugPrint("page.value <= totalPages : ${page.value <= totalPages}");
      scrollController.jumpTo(scrollController.position.pixels + 1);

      if (page.value <= totalPages) {
        page.value += 1;
        queryParams.update('page', (value) => page.value,
            ifAbsent: () => page.value);

        await fetchMemorizationGroup().then((_) {
          debugPrint("page value  become a: ${page.value}");

          double savedScrollPosition = scrollController.position.pixels;
          scrollController.jumpTo(savedScrollPosition + 1);
        });
      }
    }
  }

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
    if (surahs.isNotEmpty) {
      this.juzas.addAll(juzas);
    }
  }

  Map<String, dynamic> buildFilterQueryParams() {
    isFilterApplied.value = true;
    // queryParams.clear();
    // clearFilterQueryParams();

    page.value = 1;
    limit.value = 10;

    if (searchController.text.isNotEmpty) {
      queryParams['groupName'] = searchController.text;
    }

    if (selectedGender.value != GenderSearchFiltter.notSelected) {
      debugPrint("selectedGender: ${selectedGender.value}");

      queryParams['participants_gender'] = selectedGender.value.name == "male"
          ? "ذكور".toString()
          : "إناث".toString();
    }

    if (selectedGroupObjective.value != GroupObjectiveSearchFiltter.all) {
      queryParams['group_goal'] =
          selectedGroupObjective.value.name == "memorization"
              ? "تحفيظ".toString()
              : selectedGroupObjective.value.name == "recitation"
                  ? "تلاوة".toString()
                  : "مراجعة".toString();
    }

    if (selectedSupervisorLanguage.value != SupervisorLangugueFilter.all) {
      queryParams['supervisorLanguage'] = selectedSupervisorLanguage.value.name;
    }

    if (selectedGroupContent.value != GroupContentFilter.allOfQuran) {
      debugPrint("selectedGroupContent: ${selectedGroupContent.value}");
      if (selectedGroupContent.value == GroupContentFilter.partOfQuran) {
        debugPrint("selectedPartOfQuranType: ${selectedPartOfQuranType.value}");
        if (selectedPartOfQuranType.value ==
                SelectedPartOfQuranFiltter.surahs &&
            selectedSurahs.isNotEmpty) {
          queryParams['surahs'] =
              selectedSurahs.map((surah) => surah.id).toList();
        }

        if (selectedPartOfQuranType.value == SelectedPartOfQuranFiltter.juzs &&
            selectedJuzzas.isNotEmpty) {
          queryParams['juza'] = selectedJuzzas.map((juza) => juza.id).toList();
        }
      }
    }

    if (selectedStudentLevelRange.value.start != 0 ||
        selectedStudentLevelRange.value.end != 2) {
      if (selectedStudentLevelRange.value.start == 0 &&
          selectedStudentLevelRange.value.end == 0) {
        queryParams['participants_level'] = "junior";
      } else if (selectedStudentLevelRange.value.start == 1 &&
          selectedStudentLevelRange.value.end == 1) {
        queryParams['participants_level'] = "average";
      } else if (selectedStudentLevelRange.value.start == 2 &&
          selectedStudentLevelRange.value.end == 2) {
        queryParams['participants_level'] = "advanced";
      } else if (selectedStudentLevelRange.value.start == 0 &&
          selectedStudentLevelRange.value.end == 1) {
        queryParams['participants_level'] = "junior-average";
      } else if (selectedStudentLevelRange.value.start == 1 &&
          selectedStudentLevelRange.value.end == 2) {
        queryParams['participants_level'] = "average-advanced";
      }
    }

    debugPrint(queryParams.toString());

/*
    if (selectedSupervisorLanguage != null &&
        selectedSupervisorLanguage != SupervisorLangugueFilter.all) {
      queryParams['supervisorLanguage'] = selectedSupervisorLanguage.name;
    }

    if (selectedGroupContent != null) {
      queryParams['groupContent'] = selectedGroupContent.name;

      if (selectedGroupContent == GroupContentFilter.partOfQuran) {
        queryParams['partOfQuranType'] = selectedPartOfQuranType?.name;

        if (selectedPartOfQuranType == SelectedPartOfQuranFiltter.surahs &&
            selectedSurahs.isNotEmpty) {
          queryParams['surahs'] = selectedSurahs.map((s) => s.id).toList();
        }

        if (selectedPartOfQuranType == SelectedPartOfQuranFiltter.juzs &&
            selectedJuzzas.isNotEmpty) {
          queryParams['juzzas'] = selectedJuzzas.map((j) => j.id).toList();
        }
      }
    }

    if (selectedStudentLevelRange.start != 0 ||
        selectedStudentLevelRange.end != 2) {
      queryParams['minLevel'] = selectedStudentLevelRange.start;
      queryParams['maxLevel'] = selectedStudentLevelRange.end;
    }
*/
    memorizationGroups.clear();
    debugPrint(memorizationGroups.toString());

    return queryParams;
  }

  void clearFilterQueryParams() {
    selectedGender.value = GenderSearchFiltter.both;
    selectedGender.value = GenderSearchFiltter.notSelected;
    selectedGroupObjective.value = GroupObjectiveSearchFiltter.all;
    selectedSupervisorLanguage.value = SupervisorLangugueFilter.all;
    selectedGroupContent.value = GroupContentFilter.all;
    selectedPartOfQuranType.value = SelectedPartOfQuranFiltter.surahs;
    selectedSurahs.clear();
    selectedJuzzas.clear();
    selectedStudentLevelRange.value = const RangeValues(0, 2);
  }

  void navigateToGroupDetailsScreen(String groupId) {
    debugPrint("groupId when called: $groupId");
    Get.toNamed(
      AppRoutes.participantSearchedGroupDetails,
      arguments: groupId,
    );
  }
}
