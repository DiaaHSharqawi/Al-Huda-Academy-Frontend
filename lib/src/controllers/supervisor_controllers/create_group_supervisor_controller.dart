import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/create_memorization_group_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/group_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_content_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_search_filter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/supervisor_gender_group_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/days_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_goal_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/participant_level_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/teaching_methods_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/surahs/surahs.dart';

class CreateGroupSupervisorController extends GetxController {
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
    } catch (e) {
      debugPrint('Error fetching data list: $e');
    } finally {
      isLoading(false);
    }
  }

  CreateGroupSupervisorController(this._createMemorizationGroupService);

  var isSubmitting = false.obs;
  var isLoading = false.obs;

  var selectedLevel = 'notSelected'.obs;

  final TextEditingController groupNameController = TextEditingController();

  final TextEditingController groupDescriptionController =
      TextEditingController();

  final TextEditingController groupCapacityController = TextEditingController();

  var selectedStartTime = Rx<TimeOfDay>(TimeOfDay.now());
  get getSelectedTime => selectedStartTime.value;

  var selectedEndTime = Rx<TimeOfDay>(TimeOfDay.now());
  get getSelectedEndTime => selectedEndTime.value;

  final List<Day> days = [];

  final List<Gender> genders = [];

  final List<ParticipantLevel> participantLevels = [];

  var selectedParticipantLevels = Rx<RangeValues>(const RangeValues(0, 2));

  final RxList<String> selectedDays = <String>[].obs;

  var selectedGender = SupervisorGenderGroupEnum.notSelected.obs;

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
      debugPrint("levelMap[(start + end) ]: ${[(start + end) / 2]}");
      debugPrint("levelMap[(start + end) / 2]: ${levelMap[(start + end) / 2]}");
      ParticipantLevel? level = participantLevels.firstWhere(
          (level) => level.participantLevelEn == levelMap[(start + end) / 2]);

      debugPrint("level *****: $level");

      levelId = level.id;
    }

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
      'groupLevelId': levelId.toString(),
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
  /* Future<Map<String, dynamic>> createANewMemorizationGroup() async {
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

    /*  final errors = GroupValidations.validateAll({
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
    }*/

    try {
      isLoading(true);

      Object createANewMemorizationGroupResponse =
          await _createMemorizationGroupService.createANewMemorizationGroup({
        'groupName': groupNameController.text,
        'groupDescription': groupDescriptionController.text,
        'groupCapacity': groupCapacityController.text,
        'startTime':
            selectedStartTime.value.format(Get.context!).split(' ').first,
        'endTime': selectedEndTime.value.format(Get.context!).split(' ').first,
        'selectedDays': selectedDays,
      });

      return createANewMemorizationGroupResponse as Map<String, dynamic>;
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
  }*/

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

  final List<TeachingMethod> teachingMethods = [];
  var selectedGroupContent = GroupContentFilter.all.obs;
  var selectedGroupObjective = GroupObjectiveSearchFiltter.all.obs;

  final List<Surah> surahs = [];
  var selectedSurahs = <Surah>[].obs;

  final List<Juza> juzas = [];
  var selectedJuzzas = [].obs;

  var ayatForSurahs = [].obs;

  final List<GroupGoal> groupGoals = [];

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
}
