import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/create_memorization_group_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/group_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_content_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/supervisor_gender_group_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/days_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_goal_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/participant_level_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/teaching_methods_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/surahs/surahs.dart';

class SupervisorCreateGroupController extends GetxController {
  final CreateMemorizationGroupService _createMemorizationGroupService;

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading(true);

      await getDaysList();
      await getGendersList();
      await getParticipantLevelList();
      await getTeachingMethodsList();
      await getSurahList();
      await getJuzaList();
      await getGroupGoalList();

      final appService = Get.find<AppService>();
      supervisorId.value = appService.user.value!.getMemberId();
    } catch (e) {
      debugPrint('Error fetching data list: $e');
    } finally {
      isLoading(false);
    }
  }

  SupervisorCreateGroupController(this._createMemorizationGroupService);

  var supervisorId = "".obs;

  var isSubmitting = false.obs;
  var isLoading = false.obs;

  final TextEditingController groupNameController = TextEditingController();

  final TextEditingController groupDescriptionController =
      TextEditingController();

  final TextEditingController groupCapacityController = TextEditingController();

  var selectedStartTime = Rx<TimeOfDay>(TimeOfDay.now());
  get getSelectedTime => selectedStartTime.value;

  var selectedEndTime =
      Rx<TimeOfDay>(TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1));
  get getSelectedEndTime => selectedEndTime.value;

  final List<Day> days = [];

  final List<Gender> genders = [];

  final List<ParticipantLevel> participantLevels = [];
  var selectedParticipantLevels = Rx<RangeValues>(const RangeValues(0, 2));
  var selectedParticipantLevelId = "".obs;

  final RxList<String> selectedDays = <String>[].obs;

  var selectedGender = SupervisorGenderGroupEnum.notSelected.obs;
  var selectedGenderId = "".obs;

  final List<TeachingMethod> teachingMethods = [];
  var selectedTeachingMethod = GroupTeachingMethodEnum.all.obs;
  var selectedTeachingMethodId = "".obs;

  var selectedGroupObjective = GroupObjectiveEnum.all.obs;
  var selectedGroupObjectiveId = "".obs;

  final List<Surah> surahs = [];
  var selectedSurahs = <Surah>[].obs;

  final List<Juza> juzas = [];
  var selectedJuzzas = [].obs;

  var ayatForSurahs = [{}].obs;
  Map<int, TextEditingController> textControllers = {};

  final List<GroupGoal> groupGoals = [];

  String getStartTime() {
    return selectedStartTime.value
        .toString()
        .substring(10, selectedStartTime.value.toString().length - 1);
  }

  String getEndTime() {
    return selectedEndTime.value
        .toString()
        .substring(10, selectedEndTime.value.toString().length - 1);
  }

  void setSelectedTeachingMethodId() {
    selectedSurahs.clear();
    selectedJuzzas.clear();
    ayatForSurahs.clear();

    selectedTeachingMethodId.value = teachingMethods
        .firstWhere((teachingMethod) =>
            teachingMethod.methodNameEnglish ==
            selectedTeachingMethod.value.name)
        .id
        .toString();
  }

  Future<Map<String, dynamic>> createANewMemorizationGroup() async {
    debugPrint('Creating a new memorization group');
    String startTime = getStartTime();
    String endTime = getEndTime();
    debugPrint('startTime: $startTime, endTime: $endTime');

    if (selectedTeachingMethodId.value == "1" && selectedSurahs.isEmpty) {
      selectedSurahs.addAll(surahs);
    } else if (selectedTeachingMethodId.value == "2" &&
        selectedJuzzas.isEmpty) {
      selectedJuzzas.addAll(juzas);
    } else if (selectedTeachingMethodId.value == "5") {
      // debugPrint()
      debugPrint("ayat for surahs");
      for (var element in ayatForSurahs) {
        debugPrint("element");
        debugPrint(element.toString());
        if (textControllers.containsKey(element['surah_id'])) {
          debugPrint(
              "Text Controller Value: ${textControllers[element['surah_id']]!.text}");
        }
      }
    }

    isSubmitting(true);

    debugPrint("ayatForSurahs-->");
    debugPrint(textControllers.map((key, value) {
      return MapEntry(key, value.text);
    }).toString());

    debugPrint(
      ayatForSurahs
          .map((ayat) => {'surah_id': ayat['surah_id'], 'ayat': ayat['ayat']})
          .toList()
          .toString(),
    );

    final errors = GroupValidations.validateAll({
      'groupName': groupNameController.text,
      'groupDescription': groupDescriptionController.text,
      'groupCapacity': groupCapacityController.text,
      'selectedStartTime': startTime,
      'selectedEndTime': endTime,
      'selectedDays': selectedDays.toList().toString(),
      'groupGender': selectedGender.value.name,
      'groupLevelId': selectedParticipantLevelId.value, // p level
      'selectedGroupObjectiveId': selectedGroupObjectiveId.value,
      'teachingMehodId': selectedTeachingMethodId.value,
      'extracts': selectedTeachingMethodId.value == "5"
          ? jsonEncode(
              textControllers.map(
                (key, value) {
                  return MapEntry(
                    key.toString(),
                    value.text,
                  );
                },
              ),
            )
          : null,
      'selectedSurahIds': selectedTeachingMethodId.value == "1" ||
              selectedTeachingMethodId.value == "4"
          ? jsonEncode(
              selectedSurahs.map((surah) => surah.id.toString()).toList())
          : null,
      "juza_ids": selectedTeachingMethodId.value == "2" ||
              selectedTeachingMethodId.value == "3"
          ? jsonEncode(
              selectedJuzzas.map((juza) => juza.id.toString()).toList(),
            )
          : null,

      //
    });

    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");

      return {
        'statusCode': 422,
        'success': false,
        'message': errors.values.join(', ').toString(),
      };
    }

    try {
      isLoading(true);
      debugPrint("hiiiii");

      debugPrint(selectedSurahs
          .map((surah) => surah.id.toString())
          .toList()
          .toString());
      Object createANewMemorizationGroupResponse =
          await _createMemorizationGroupService.createANewMemorizationGroup({
        'groupName': groupNameController.text,
        'groupDescription': groupDescriptionController.text,
        'capacity': int.parse(groupCapacityController.text),
        'start_time': startTime,
        'end_time': endTime,
        'days': selectedDays.toList(),
        'supervisor_id': supervisorId,
        'participants_gender_id': selectedGenderId.value,
        'participants_level_id': selectedParticipantLevelId.value, // p level
        'group_goal_id': selectedGroupObjectiveId.value,
        'teaching_method_id': selectedTeachingMethodId.value,
        'surah_ids': (selectedTeachingMethodId.value == "1" ||
                selectedTeachingMethodId.value == "4")
            ? selectedSurahs
                .map((surah) => int.parse(surah.id.toString()))
                .toList()
            : null,
        'juza_ids': selectedTeachingMethodId.value == "2" ||
                selectedTeachingMethodId.value == "3"
            ? selectedJuzzas
                .map((juza) => int.parse(juza.id.toString()))
                .toList()
            : null,
        'extracts': selectedTeachingMethodId.value == "5"
            ? textControllers.entries.map((entry) {
                return {
                  "surah_id": entry.key.toString(), // Convert key to String
                  "ayat": entry.value.text // Get the text from the controller
                };
              }).toList()
            : null,
      });
      return createANewMemorizationGroupResponse as Map<String, dynamic>;

      /* return {
        "statusCode": 200,
        "success": true,
        "message": "تم التحقق من البيانات بنجاح"
      };*/
    } catch (e) {
      debugPrint(e.toString());
      return {
        'statusCode': 500,
        'success': false,
        'message': 'حدث خطأ ما',
      };
    } finally {
      isSubmitting(false);
      isLoading(false);
    }
  }

  Map<String, Object> validateGroupDetails() {
    String startTime = selectedStartTime.value
        .toString()
        .substring(10, selectedStartTime.value.toString().length - 1);

    debugPrint('startTime: $startTime');

    String endTime = selectedEndTime.value
        .toString()
        .substring(10, selectedEndTime.value.toString().length - 1);

    debugPrint('endTime: $endTime');

    isSubmitting(true);

    final errors = GroupValidations.validateAll({
      'groupName': groupNameController.text,
      'groupDescription': groupDescriptionController.text,
      'groupCapacity': groupCapacityController.text,
      'selectedStartTime': startTime,
      'selectedEndTime': endTime,
      'selectedDays': selectedDays.toList().toString(),
    });

    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");

      return {
        'statusCode': 422,
        'success': false,
        'message': errors.values.join(', ').toString(),
      };
    } else {
      return {
        'statusCode': 200,
        'success': true,
        'message': 'تم التحقق من البيانات بنجاح',
      };
    }
  }

  void setSelectedLevelId() {
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

  Future<Map<String, dynamic>> getGroupByGroupName() async {
    debugPrint('Creating a new memorization group');
    String startTime = selectedStartTime.value
        .toString()
        .substring(10, selectedStartTime.value.toString().length - 1);

    debugPrint('startTime: $startTime');

    String endTime = selectedEndTime.value
        .toString()
        .substring(10, selectedEndTime.value.toString().length - 1);

    debugPrint('endTime: $endTime');

    isSubmitting(true);

    debugPrint('Creating a new memorization group');

    final errors = GroupValidations.validateAll({
      'groupName': groupNameController.text,
      'groupDescription': groupDescriptionController.text,
      'groupCapacity': groupCapacityController.text,
      'selectedStartTime': startTime,
      'selectedEndTime': endTime,
      'selectedDays': selectedDays.toList().toString(),
      'groupGender': selectedGender.value.name,
      'groupLevelId': selectedParticipantLevelId.value,
      'selectedGroupObjectiveId': selectedGroupObjectiveId.value,
    });

    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");

      return {
        'statusCode': 422,
        'success': false,
        'message': errors.values.join(', ').toString(),
      };
    }

    try {
      isLoading(true);

      Object validateGroupNameResponse =
          await _createMemorizationGroupService.getGroupByGroupName(
        groupNameController.text,
      );

      var responseMap = validateGroupNameResponse as Map<String, dynamic>;
      return responseMap;
    } catch (e) {
      debugPrint(e.toString());
      return {
        'statusCode': 500,
        'success': false,
        'message': 'حدث خطأ ما, $e',
      };
    } finally {
      isSubmitting(false);
      isLoading(false);
    }
  }

  Future<void> getDaysList() async {
    var daysResponse = await _createMemorizationGroupService.getDaysList();
    debugPrint("controller");
    debugPrint(daysResponse.firstOrNull.toString());
    if (daysResponse.isNotEmpty) {
      days.addAll(daysResponse);
    }
  }

  Future<void> getGendersList() async {
    var gendersResponse =
        await _createMemorizationGroupService.getGendersList();
    if (gendersResponse.isNotEmpty) {
      genders.addAll(gendersResponse);
    }
  }

  Future<void> getParticipantLevelList() async {
    var participantLevelResponse =
        await _createMemorizationGroupService.getParticipantLevelList();
    if (participantLevelResponse.isNotEmpty) {
      participantLevels.addAll(participantLevelResponse);
    }
  }

  Future<void> getTeachingMethodsList() async {
    var teachingMethodsResponse =
        await _createMemorizationGroupService.getTeachingMethodsList();
    if (teachingMethodsResponse.isNotEmpty) {
      teachingMethods.addAll(teachingMethodsResponse);
    }
  }

  Future<void> getSurahList() async {
    var surahs = await _createMemorizationGroupService.getSurahList();
    debugPrint("controller");
    debugPrint(surahs.firstOrNull.toString());
    if (surahs.isNotEmpty) {
      this.surahs.addAll(surahs);
    }
  }

  Future<void> getJuzaList() async {
    var juzas = await _createMemorizationGroupService.getJuzaList();
    debugPrint("juzas");
    debugPrint(juzas.toString());
    if (juzas.isNotEmpty) {
      this.juzas.addAll(juzas);
    }
  }

  Future<void> getGroupGoalList() async {
    var groupGoalsResponse =
        await _createMemorizationGroupService.getGroupGoalList();
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

  void navigateToSuperVisorHomeScreen() {
    Get.toNamed(AppRoutes.supervisorHomeScreen);
  }

  void navigateToCreateMemorizationGroupContentScreen() {
    Get.toNamed(AppRoutes.supervisorCreateMemorizationGroupContentScreen);
  }

  void navigateToSupervisorDashboardScreen() {
    Get.offAllNamed(AppRoutes.supervisorGroupDashboard);
  }
}
