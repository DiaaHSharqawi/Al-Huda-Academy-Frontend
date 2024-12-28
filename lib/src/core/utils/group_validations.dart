import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class GroupValidations {
  static String? validateGroupName(String? groupName) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك أدخل اسم المجموعة",
      ),
      FormBuilderValidators.minLength(
        2,
        errorText: "اسم المجموعة يجب أن يكون على الأقل حرفين",
      ),
    ])(groupName);
  }

  static String? validateGroupLevel(String? groupLevelId) {
    debugPrint("groupLevelId: $groupLevelId");
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر مستوى المجموعة",
      ),
      FormBuilderValidators.integer(
        errorText: "من فضلك أدخل مستوى صحيح",
      ),
      FormBuilderValidators.min(
        1,
        errorText: "مستوى المجموعة يجب أن يكون بين 1 و 5",
      ),
      FormBuilderValidators.max(
        5,
        errorText: "مستوى المجموعة يجب أن يكون بين 1 و 5",
      ),
    ])(groupLevelId);
  }

  static String? validateGroupGender(String? groupGender) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر نوع جنس المجموعة",
      ),
      (value) {
        if (value != 'male' && value != 'female') {
          return "من فضلك اختر نوع جنس المجموعة";
        }
        return null;
      },
    ])(groupGender);
  }

  static String? validateGroupCapacity(String? capacity) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك أدخل عدد 'الطلاب المسموح بهم' في المجموعة",
      ),
      FormBuilderValidators.integer(
        errorText: "من فضلك أدخل عدد مجموعة صحيح",
      ),
      FormBuilderValidators.min(
        1,
        errorText: "عدد الطلاب المسموح بهم في المجموعة يجب أن يكون أكبر من صفر",
      ),
      FormBuilderValidators.max(
        12,
        errorText: "عدد الطلاب المسموح بهم في المجموعة يجب أن يكون أقل من 12",
      ),
    ])(capacity);
  }

  static String? validateGroupDescription(String? description) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك أدخل وصف المجموعة",
      ),
      FormBuilderValidators.minLength(
        8,
        errorText: "وصف المجموعة يجب أن يكون على الأقل 8 حروف",
      ),
    ])(description);
  }

  static String? validateGroupStartTime(String? startTime) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر وقت بداية المجموعة",
      ),
      FormBuilderValidators.time(
        errorText: "من فضلك اختر وقت صحيح",
      ),
    ])(startTime);
  }

  static String? validateGroupEndTime(String? endTime) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر وقت نهاية المجموعة",
      ),
      FormBuilderValidators.time(
        errorText: "من فضلك اختر وقت صحيح",
      ),
    ])(endTime);
  }

  static String? validateGroupDays(List<int> days) {
    debugPrint("Days--->: ${days}");
    debugPrint(days.toString());
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر أيام المجموعة",
      ),
      FormBuilderValidators.minLength(
        1,
        errorText: "من فضلك اختر يوم واحد على الأقل",
      ),
      (value) {
        if (days.any((day) => day < 1 || day > 7)) {
          return "من فضلك اختر أيام من 1 إلى 7 فقط";
        }
        return null;
      },
    ])(days);
  }

  static Map<String, String?>? validateAll(Map<String, String?> values) {
    Map<String, String?> errors = {};

    if (values['groupName'] != null) {
      final groupNameError = validateGroupName(values['groupName']);
      if (groupNameError != null) errors['groupName'] = groupNameError;
    }

    if (values['groupCapacity'] != null) {
      final groupCapacityError = validateGroupCapacity(values['groupCapacity']);
      if (groupCapacityError != null) {
        errors['groupCapacity'] = groupCapacityError;
      }
    }
    if (values['groupDescription'] != null) {
      final groupDescriptionError =
          validateGroupDescription(values['groupDescription']);
      if (groupDescriptionError != null) {
        errors['groupDescription'] = groupDescriptionError;
      }
    }
    if (values['selectedStartTime'] != null) {
      final startTimeError =
          validateGroupStartTime(values['selectedStartTime']);
      if (startTimeError != null) errors['selectedStartTime'] = startTimeError;
    }
    if (values['selectedEndTime'] != null) {
      final endTimeError = validateGroupEndTime(values['selectedEndTime']);
      if (endTimeError != null) errors['selectedEndTime'] = endTimeError;
    }
    if (values['selectedDays'] != null) {
      debugPrint("Selected days: ${values['selectedDays'].runtimeType}");

      final selectedDaysList = RegExp(r'\d+')
          .allMatches(values['selectedDays']!)
          .map((match) => int.parse(match.group(0)!))
          .toList();

      debugPrint("Selected days:-->  $selectedDaysList");

      final daysError = validateGroupDays(selectedDaysList);

      if (daysError != null) errors['selectedDays'] = daysError;
    }
    if (values['groupGender'] != null) {
      final groupGenderError = validateGroupGender(values['groupGender']);
      if (groupGenderError != null) errors['groupGender'] = groupGenderError;
    }
    if (values['groupLevel'] != null) {
      final groupLevelError = validateGroupLevel(values['groupLevelId']);
      if (groupLevelError != null) errors['groupLevelId'] = groupLevelError;
    }

    debugPrint(errors.toString());
    return errors.isNotEmpty ? errors : null;
  }
}
