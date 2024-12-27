import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/create_memorization_group_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/group_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/days_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/participant_level_response_model.dart';

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
    } catch (e) {
      debugPrint('Error fetching data list: $e');
    } finally {
      isLoading(false);
    }
  }

  CreateGroupSupervisorController(this._createMemorizationGroupService);

  var isSubmitting = false.obs;
  var isLoading = false.obs;

  var selectedGender = Rx<Gender?>(null);
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

  Future<Map<String, dynamic>> createANewMemorizationGroup() async {
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
    }

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

  void navigateToSuperVisorHomeScreen() {
    Get.toNamed(AppRoutes.supervisorHomeScreen);
  }
}
