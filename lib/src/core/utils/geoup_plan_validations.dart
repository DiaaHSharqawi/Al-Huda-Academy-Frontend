import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class GeoupPlanValidations {
  static String? validateDayDate(String? value) {
    if (value == null) {
      return "يجب ان تختار تاريخ يوم الخطة";
    }
    return FormBuilderValidators.required(
      errorText: "يجب ان تختار تاريخ يوم الخطة",
    )(value);
  }

  static Map<String, String?>? validateAll(Map<String, String?> values) {
    debugPrint("validateAll");
    debugPrint(values.toString());
    Map<String, String?> errors = {};

    debugPrint("dayDate");
    debugPrint(values['dayDate']);

    if (values['dayDate'] != null) {
      final dayDateError = validateDayDate(values['dayDate']);
      if (dayDateError != null) errors['dayDate'] = dayDateError;
    }

    debugPrint(errors.toString());
    return errors.isNotEmpty ? errors : null;
  }
}
