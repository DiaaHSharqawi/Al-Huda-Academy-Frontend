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
      FormBuilderValidators.minLength(
        6,
        errorText: LoginScreenLanguageConstants.enterAValidPassword.tr,
      )
    ])(password);
  }

  static String? validatePhoneNumber(String? phone) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: AuthValidationsLanguageConstants.phoneNumberIsRequired.tr,
      ),
      FormBuilderValidators.match(
        RegExp(r'^\+?[0-9]{10,15}$'),
        errorText: AuthValidationsLanguageConstants.enterValidPhoneNumber.tr,
      ),
    ])(phone);
  }

  static String? validateCountry(String? country) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: AuthValidationsLanguageConstants.enterCountry.tr,
      ),
      FormBuilderValidators.minLength(
        2,
        errorText: AuthValidationsLanguageConstants.countryMinLength.tr,
      ),
    ])(country);
  }

  static String? validateCity(String? city) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: AuthValidationsLanguageConstants.enterACity.tr,
      ),
      FormBuilderValidators.minLength(
        2,
        errorText: AuthValidationsLanguageConstants.cityNameMinLength.tr,
      ),
    ])(city);
  }

  static String? validateFullName(String? fullName) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: AuthValidationsLanguageConstants.enterFullName.tr,
      ),
      FormBuilderValidators.minLength(
        2,
        errorText: AuthValidationsLanguageConstants.enterFullNameMinLength.tr,
      ),
    ])(fullName);
  }

  static String? validateAge(String? age) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: AuthValidationsLanguageConstants.enterAge.tr,
      ),
      FormBuilderValidators.integer(
        errorText: AuthValidationsLanguageConstants.ageMustBeInteger.tr,
      ),
      FormBuilderValidators.min(
        6,
        errorText: AuthValidationsLanguageConstants.ageMustBeGreaterThanSix.tr,
      ),
      FormBuilderValidators.max(
        100,
        errorText:
            AuthValidationsLanguageConstants.ageMustBeLessThanOneHundred.tr,
      ),
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
