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

  static String? validateGroupCapacity(String? capacity) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك أدخل عدد 'الطلاب المسموح بهم' في المجموعة",
      ),
      FormBuilderValidators.integer(
        errorText: "من فضلك أدخل عدد صحيح",
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

  static String? validateGroupDays(List<String> days) {
    debugPrint("Days--->: ${days.runtimeType}");
    debugPrint(days.toString());
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر أيام المجموعة",
      ),
      FormBuilderValidators.minLength(
        1,
        errorText: "من فضلك اختر يوم واحد على الأقل",
      ),
    ])(days.isNotEmpty ? days.join(', ') : null);
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
      debugPrint(values['selectedDays']!);

      final selectedDays = values['selectedDays'];

      var formattedDays = selectedDays
          ?.splitMapJoin(
            RegExp(r'\d+'),
            onMatch: (m) => m.group(0)!,
            onNonMatch: (n) => n,
          )
          .replaceAll('[', '')
          .replaceAll(']', '');

      debugPrint("Selected days: $formattedDays");

      final daysError = validateGroupDays(formattedDays!.split(', '));

      if (daysError != null) errors['selectedDays'] = daysError;
    }

    debugPrint(errors.toString());
    return errors.isNotEmpty ? errors : null;
  }
}
