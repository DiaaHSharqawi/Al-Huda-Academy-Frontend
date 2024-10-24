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
}
