import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';

class AuthValidations {
  static String? validateEmail(String? email) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: LoginScreenLanguageConstants.userIdentifierRequired.tr,
      ),
      FormBuilderValidators.email(
          errorText: LoginScreenLanguageConstants.enterAValidEmail.tr),
    ])(email);
  }

  static String? validatePassword(String? password) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
          errorText: LoginScreenLanguageConstants.userPasswordRequired.tr),
      FormBuilderValidators.minLength(6,
          errorText: LoginScreenLanguageConstants.enterAValidPassword.tr)
    ])(password);
  }

  static String? validatePhoneNumber(String? phone) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "!رقم الهاتف مطلوب"),
      FormBuilderValidators.match(
        RegExp(r'^\+?[0-9]{10,15}$'),
        errorText: "من فضلك ادخل رقم هاتف صحيح",
      ),
    ])(phone);
  }

  static String? validateCountry(String? country) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "من فضلك ادخل دولتك",
      ),
      FormBuilderValidators.minLength(2,
          errorText: "اسم الدولة يجب ان يكون اكثر من حرفين"),
    ])(country);
  }

  static String? validateCity(String? city) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "من فضلك ادخل مدينتك"),
      FormBuilderValidators.minLength(2,
          errorText: "اسم المدينة يجب ان يكون اكثر من حرفين"),
    ])(city);
  }

  static String? validateFullName(String? fullName) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "من فضلك ادخل اسمك الكامل"),
      FormBuilderValidators.minLength(2,
          errorText: "اسمك الكامل يجب ان يكون اكثر من حرفين"),
    ])(fullName);
  }

  static String? validateAge(String? age) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "من فضلك ادخل عمرك"),
      FormBuilderValidators.integer(
          errorText: "العمر يجب أن يكون عددًا صحيحًا"),
      FormBuilderValidators.min(6, errorText: "العمر يجب أن يكون أكبر من 6"),
      FormBuilderValidators.max(100, errorText: "العمر يجب أن يكون أقل من 100"),
    ])(age);
  }

  static Map<String, String?>? validateAll(Map<String, String?> values) {
    Map<String, String?> errors = {};

    if (values['email'] != null) {
      final emailError = validateEmail(values['email']);
      if (emailError != null) errors['email'] = emailError;
    }

    if (values['password'] != null) {
      final passwordError = validatePassword(values['password']);
      if (passwordError != null) errors['password'] = passwordError;
    }

    if (values['phone'] != null) {
      final phoneError = validatePhoneNumber(values['phone']);
      if (phoneError != null) errors['phone'] = phoneError;
    }

    if (values['country'] != null) {
      final countryError = validateCountry(values['country']);
      if (countryError != null) errors['country'] = countryError;
    }

    if (values['city'] != null) {
      final cityError = validateCity(values['city']);
      if (cityError != null) errors['city'] = cityError;
    }

    if (values['fullName'] != null) {
      final fullNameError = validateFullName(values['fullName']);
      if (fullNameError != null) errors['fullName'] = fullNameError;
    }

    if (values['age'] != null) {
      final ageError = validateAge(values['age']);
      if (ageError != null) errors['age'] = ageError;
    }

    return errors.isNotEmpty ? errors : null;
  }
}
