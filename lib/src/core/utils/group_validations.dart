import 'dart:convert';

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

  static String? validateGroupObjective(String? selectedGroupObjectiveId) {
    debugPrint("selectedGroupObjectiveId: $selectedGroupObjectiveId");
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر هدف المجموعة",
      ),
      FormBuilderValidators.integer(
        errorText: "من فضلك أدخل هدف صحيح",
      ),
    ])(selectedGroupObjectiveId);
  }

  static String? validateTeachingMethodId(String? teachingMethodId) {
    debugPrint("teachingMethodId: $teachingMethodId");
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر  محتوى التدريس",
      ),
      FormBuilderValidators.integer(
        errorText: "من فضلك أدخل محتوى التدريس  تدريس ",
      ),
    ])(teachingMethodId);
  }

  static String? validateGroupCompletionRateId(String? groupCompletionRateId) {
    debugPrint("groupCompletionRateId: $groupCompletionRateId");
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر معدل إتمام المجموعة",
      ),
      FormBuilderValidators.integer(
        errorText: "من فضلك أدخل معدل إتمام صحيح",
      ),
    ])(groupCompletionRateId);
  }

  static String? validateSupervisorId(String? supervisorId) {
    debugPrint("supervisorId: $supervisorId");
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر مشرف المجموعة",
      ),
      FormBuilderValidators.integer(
        errorText: "من فضلك أدخل معرف مشرف صحيح",
      ),
    ])(supervisorId);
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

  static String? validateAyatForSurahs(String? ayatForSurahs) {
    debugPrint("X: $ayatForSurahs");
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر آيات من القرآن",
      ),
      (value) {
        if (value == null) {
          return "من فضلك اختر آيات من القرآن";
        }
        debugPrint("value : $value");
        Map<String, dynamic> ayatMap = jsonDecode(value as String);
        for (var entry in ayatMap.entries) {
          if (!RegExp(r'^\d+$').hasMatch(entry.key)) {
            return "من فضلك أدخل رقم سورة صحيح";
          }
          if (entry.value is! String ||
              !RegExp(r'^(\d+-\d+,)*\d+-\d+$').hasMatch(entry.value)) {
            return "من فضلك أدخل آيات صحيحة بالشكل الصحيح (مثال: 1-5,10-15)";
          }
        }
        return null;
      }
    ])(ayatForSurahs);
  }

  static String? validateAyat(String? ayah, int maxAyat) {
    debugPrint("ayah: $ayah");
    return FormBuilderValidators.compose([
      // Ensure the field is not empty
      FormBuilderValidators.required(
        errorText: "من فضلك اختر آيات من القرآن",
      ),
      (value) {
        if (value == null) {
          return "من فضلك اختر آيات من القرآن";
        }
        debugPrint("value : $value");

        // Check the format of the input
        if (ayah is! String ||
            !RegExp(r'^(\d+-\d+,)*\d+-\d+$').hasMatch(ayah)) {
          return "من فضلك أدخل آيات صحيحة بالشكل الصحيح (مثال: 1-5,10-15)";
        }

        // Validate ranges
        final ranges = ayah.split(',');
        for (var range in ranges) {
          final parts = range.split('-');
          final start = int.tryParse(parts[0]);
          final end = int.tryParse(parts[1]);

          if (start == null || end == null || start > end) {
            return "النطاق غير صحيح: $range";
          }

          if (start < 1 || end > maxAyat) {
            return "النطاق ($range) يتجاوز عدد الآيات ($maxAyat) المتاحة في السورة.";
          }
        }

        return null; // Input is valid
      }
    ])(ayah);
  }

  static String? validateSurahIds(String? surahIds) {
    debugPrint("surahIds: $surahIds");
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر آيات من القرآن",
      ),
      (value) {
        if (value == null) {
          return "من فضلك اختر آيات من القرآن";
        }
        List<String> surahList =
            List<String>.from(jsonDecode(value.toString()));
        if (surahList.isEmpty) {
          return "من فضلك اختر سور ";
        }
        debugPrint("surahList: $surahList");
        for (var surah in surahList) {
          int? surahId = int.tryParse(surah);
          if (surahId == null || surahId < 1 || surahId > 114) {
            return "من فضلك اختر سور بين 1 و 114 فقط";
          }
        }
        return null;
      }
    ])(surahIds);
  }

  static String? validateJuzaIds(String? juzIds) {
    debugPrint("juzIds: $juzIds");
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك اختر أجزاء من القرآن",
      ),
      (value) {
        if (value == null) {
          return "من فضلك اختر أجزاء من القرآن";
        }
        List<String> juzList = List<String>.from(jsonDecode(value.toString()));
        if (juzList.isEmpty) {
          return "من فضلك اختر أجزاء";
        }
        debugPrint("juzList: $juzList");
        for (var juz in juzList) {
          int? juzId = int.tryParse(juz);
          if (juzId == null || juzId < 1 || juzId > 30) {
            return "من فضلك اختر أجزاء بين 1 و 30 فقط";
          }
        }
        return null;
      }
    ])(juzIds);
  }

  static String? validateGroupDays(List<int> days) {
    debugPrint("Days--->: $days");
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
    debugPrint("validateAll");
    debugPrint(values.toString());
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

    if (values['selectedGroupObjectiveId'] != null) {
      final groupGoalError =
          validateGroupObjective(values['selectedGroupObjectiveId']);
      if (groupGoalError != null) {
        errors['selectedGroupObjectiveId'] = groupGoalError;
      }
    }
    if (values['supervisorId'] != null) {
      final supervisorIdError = validateSupervisorId(values['supervisorId']);
      if (supervisorIdError != null) errors['supervisorId'] = supervisorIdError;
    }
    if (values['teachingMehodId'] != null) {
      final teachingMethodError =
          validateTeachingMethodId(values['teachingMehodId']);
      if (teachingMethodError != null) {
        errors['teachingMehodId'] = teachingMethodError;
      }
    }
    if (values['extracts'] != null) {
      debugPrint("Extracts VALIDATION : ${values['extracts'].runtimeType}");

      final extractsError = validateAyatForSurahs(values['extracts']!);
      if (extractsError != null) {
        errors['extracts'] = (extractsError);
      }
    }
    if (values['surah_ids'] != null) {
      debugPrint("Surahs_ids VALIDATION : ${values['surah_ids']}");
      final surahIdsError = validateSurahIds(values['surah_ids']);
      if (surahIdsError != null) {
        errors['surah_ids'] = surahIdsError;
      }
    }
    if (values['juza_ids'] != null) {
      debugPrint("Juza_ids VALIDATION : ${values['juza_ids']}");
      final juzaIdsError = validateJuzaIds(values['juza_ids']);
      if (juzaIdsError != null) {
        errors['juza_ids'] = juzaIdsError;
      }
    }

    if (values['group_completion_rate_id'] != null) {
      final groupCompletionRateError =
          validateGroupCompletionRateId(values['group_completion_rate_id']);
      if (groupCompletionRateError != null) {
        errors['group_completion_rate_id'] = groupCompletionRateError;
      }
    }

    debugPrint(errors.toString());
    return errors.isNotEmpty ? errors : null;
  }
}
