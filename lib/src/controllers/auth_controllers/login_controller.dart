import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class LoginController {
  final TextEditingController userIdentifierController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validateEmail(String? email) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: "login_screen.user_Identifier_required".tr,
      ),
      FormBuilderValidators.email(
          errorText: "login_screen.enter_a_valid_email".tr),
    ])(email);
  }

  String? validatePassword(String? password) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
          errorText: "login_screen.user_password_required".tr),
      FormBuilderValidators.minLength(6,
          errorText: "login_screen.enter_a_valid_password".tr)
    ])(password);
  }

  bool login() {
    debugPrint(userIdentifierController.text);
    debugPrint(passwordController.text);
    final emailError = validateEmail(userIdentifierController.text);
    final passwordError = validatePassword(passwordController.text);

    if (emailError != null || passwordError != null) {
      debugPrint('Validation failed');
      return false;
    }

    debugPrint('Login successful with email: ${userIdentifierController.text}');
    return true;
  }
}
