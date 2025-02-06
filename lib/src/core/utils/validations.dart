import "package:flutter/material.dart";
import "package:form_builder_validators/form_builder_validators.dart";

class Validations {
  static String? validateSelectedQuranMemorizingAmountId(
      String? selectedQuranMemorizingAmountId) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "يجب ان تختار مقدار الحفظ يومياً",
      ),
      FormBuilderValidators.between(
        0,
        30,
        errorText: "يجب ان يكون عدد الأجزاء بين 0 و 30",
      ),
    ])(selectedQuranMemorizingAmountId != null
        ? num.tryParse(selectedQuranMemorizingAmountId)
        : null);
  }

  static String? validateNumberOfPartsMemorized(String? partsMemorized) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.numeric(
        errorText: 'يجب ان يكون عدد الأجزاء التي تحفظها عدداً صحيحاً',
      ),
      FormBuilderValidators.required(
        errorText: "يجب ان تدخل عدد الأجزاء التي تحفظها",
      ),
      FormBuilderValidators.between(0, 30,
          errorText: "يجب ان يكون عدد الأجزاء بين 0 و 30"),
    ])(partsMemorized != null ? num.tryParse(partsMemorized) : null);
  }

  static String? validateNumberOfSurahsMemorized(String? surahsMemorized) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.numeric(
        errorText: 'يجب ان يكون عدد سور القران الكريم التي تحفظها عدداً صحيحاً',
      ),
      FormBuilderValidators.required(
        errorText: "يجب ان تدخل عدد السور التي تحفظها",
      ),
      FormBuilderValidators.between(0, 114,
          errorText: "يجب ان يكون عدد السور بين 0 و 114"),
    ])(surahsMemorized != null ? num.tryParse(surahsMemorized) : null);
  }

  static String? validateAnyDetails(String? details) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "يجب ان تدخل التفاصيل",
      ),
    ])(details);
  }

  static String? validateGradeOfReview(String? gradeOfReview) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "يجب ان تختار درجة المراجعة",
      ),
      FormBuilderValidators.numeric(
        errorText: 'يجب ان تكون درجة المراجعة عدداً صحيحاً',
      ),
      FormBuilderValidators.between(0, 100,
          errorText: "يجب ان تكون درجة المراجعة بين 0 و 100"),
    ])(gradeOfReview != null ? num.tryParse(gradeOfReview) : null);
  }

  static String? validateAttendanceStatusId(String? attendanceStatusId) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "يجب ان تختار حالة الحضور",
      ),
      (value) {
        if (value == '') {
          return "يجب ان تختار حالة الحضور";
        }
        return null;
      }
    ])(attendanceStatusId);
  }

  static String? validateGradeOfMemorize(String? gradeOfMemorize) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "يجب ان تختار درجة الحفظ",
      ),
      FormBuilderValidators.numeric(
        errorText: 'يجب ان تكون درجة الحفظ عدداً صحيحاً',
      ),
      FormBuilderValidators.between(0, 100,
          errorText: "يجب ان تكون درجة الحفظ بين 0 و 100"),
    ])(gradeOfMemorize != null ? num.tryParse(gradeOfMemorize) : null);
  }

  static Map<String, String?>? validateAll(Map<String, String?> values) {
    Map<String, String?> errors = {};

    debugPrint("Values: $values");

    if (values['partsMemorized'] != null) {
      final partsMemorizedError =
          validateNumberOfPartsMemorized(values['partsMemorized']);
      if (partsMemorizedError != null) {
        errors['partsMemorizedError'] = partsMemorizedError;
      }
    }

    if (values['suurahsMemorized'] != null) {
      final suurahsMemorizedError =
          validateNumberOfSurahsMemorized(values['suurahsMemorized']);
      if (suurahsMemorizedError != null) {
        errors['password'] = suurahsMemorizedError;
      }
    }
    if (values['details'] != null) {
      final detailsError = validateAnyDetails(values['details']);
      if (detailsError != null) {
        errors['details'] = detailsError;
      }
    }
    if (values['selectedQuranMemorizingAmountId'] != null) {
      final selectedQuranMemorizingAmountIdError =
          validateSelectedQuranMemorizingAmountId(
              values['selectedQuranMemorizingAmountId']);

      if (selectedQuranMemorizingAmountIdError != null) {
        errors['selectedQuranMemorizingAmountId'] =
            selectedQuranMemorizingAmountIdError;
      }
    }

    if (values['gradeOfReview'] != null) {
      debugPrint("Grade of review validate : ${values['gradeOfReview']}");

      final gradeError = validateGradeOfReview(values['gradeOfReview']);
      if (gradeError != null) {
        errors['gradeOfReview'] = gradeError;
      }
    }

    if (values['gradeOfMemorize'] != null) {
      final gradeError = validateGradeOfMemorize(values['gradeOfMemorize']);
      if (gradeError != null) {
        errors['gradeOfMemorize'] = gradeError;
      }
    }

    if (values['attendanceStatusId'] != null) {
      final attendanceStatusIdError =
          validateAttendanceStatusId(values['attendanceStatusId']);
      if (attendanceStatusIdError != null) {
        errors['attendanceStatusId'] = attendanceStatusIdError;
      }
    }

    return errors.isNotEmpty ? errors : null;
  }
}
