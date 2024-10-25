import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/login_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/login_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class LoginController extends GetxController {
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

  Future<String> signIn(BuildContext context) async {
    final emailError = validateEmail(userIdentifierController.text);
    final passwordError = validatePassword(passwordController.text);

    bool isValidationFailed = (emailError != null || passwordError != null);

    if (isValidationFailed) {
      return " Validation failed, Please enter a valid username and email.";
    }
    try {
      isLoading(true);

      final LoginResponse? loginResponse = await _loginService.login(
          userIdentifierController.text, passwordController.text);

      if (loginResponse!.success) {
        return "Login successful!";
      } else {
        return loginResponse.message!;
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  void navigateToHomeSceen() {
    Get.toNamed(AppRoutes.home);
  }

  void navigateToRegisterSceen() {
    Get.toNamed(AppRoutes.register);
  }

  @override
  void onClose() {
    userIdentifierController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
