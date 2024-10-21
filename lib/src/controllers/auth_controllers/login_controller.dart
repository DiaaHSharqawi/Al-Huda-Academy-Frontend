import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/login_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class LoginController {
  final TextEditingController userIdentifierController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var user = Rxn<UserModel>();

  final LoginService _loginService = LoginService();

  String? validateEmail(String? email) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: LoginScreenLanguageConstants.userIdentifierRequired.tr,
      ),
      FormBuilderValidators.email(
          errorText: LoginScreenLanguageConstants.enterAValidEmail.tr),
    ])(email);
  }

  String? validatePassword(String? password) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
          errorText: LoginScreenLanguageConstants.userPasswordRequired.tr),
      FormBuilderValidators.minLength(6,
          errorText: LoginScreenLanguageConstants.enterAValidPassword.tr)
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

  Future<void> signIn() async {
    if (GetUtils.isEmail(userIdentifierController.text) &&
        passwordController.text.isNotEmpty) {
      isLoading(true);

      try {
        final loggedInUser = await _loginService.login(
            userIdentifierController.text, passwordController.text);
        if (loggedInUser != null) {
          user.value = loggedInUser;
          Get.snackbar("Success", "Login successful!");
        } else {
          Get.snackbar("Error", "Invalid credentials");
        }
      } catch (e) {
        Get.snackbar("Error", e.toString());
        debugPrint(e.toString());
      } finally {
        isLoading(false);
      }
    } else {
      Get.snackbar("Validation Error", "Please enter valid email and password");
    }
  }
}
