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

  static Map<String, String?>? validateAll(Map<String, String?> values) {
    Map<String, String?> errors = {};

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

    return errors.isNotEmpty ? errors : null;
  }
}
