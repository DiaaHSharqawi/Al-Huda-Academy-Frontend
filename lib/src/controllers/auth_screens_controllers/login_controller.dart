import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/login_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/login_response/login_response.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginController extends GetxController {
  final TextEditingController userIdentifierController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var isSubmitting = false.obs;

  var isEnabled = true.obs;

  var isObscureText = true.obs;

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

  Future<LoginResponse> signIn(BuildContext context) async {
    LoginResponse? loginResponse;
    final emailError = validateEmail(userIdentifierController.text);
    final passwordError = validatePassword(passwordController.text);

    bool isValidationFailed = (emailError != null || passwordError != null);

    if (isValidationFailed) {
      loginResponse = LoginResponse(
        statusCode: 422,
        success: false,
        message: LoginScreenLanguageConstants.invalidInputs.tr,
      );
      return loginResponse;
    }
    try {
      isLoading(true);

      loginResponse = await _loginService.login(
        userIdentifierController.text,
        passwordController.text,
      );
      debugPrint("Login response: $loginResponse");
      return loginResponse!;
    } catch (e) {
      debugPrint(e.toString());
      loginResponse = LoginResponse(
        statusCode: 500,
        success: false,
        message: "An error occurred while logging in, Please try again.",
      );
      return loginResponse;
    } finally {
      isLoading(false);
    }
  }

  void navigateToHomeScreen() async {
    var appService = Get.find<AppService>();
    debugPrint("the login role was : ");
    var roleName = appService.user.value?.getRole.getRoleName;
    debugPrint("the login role was : ==> $roleName");
    debugPrint(appService.user.toJson().toString());

    try {
      await OneSignal.User.addTags(
        {"user": appService.user.value!.getId},
      );
    } catch (e) {
      debugPrint("Error adding OneSignal tags: $e");
    }

    if (roleName == 'supervisor') {
      Get.toNamed(AppRoutes.supervisorHomeScreen);
    } else if (roleName == 'participant') {
      Get.toNamed(AppRoutes.participantHomeScreen);
    } else if (roleName == 'admin') {
      Get.toNamed(AppRoutes.adminHomeScreen);
    }

    // Get.toNamed(AppRoutes.home);
  }

  void navigateToRegisterScreen() {
    Get.toNamed(AppRoutes.register);
  }

  void navigateToForgetPasswordScreen() {
    Get.toNamed(AppRoutes.sendPasswordResetCode);
  }

  void navigateToRoleSelectionScreen() {
    Get.toNamed(AppRoutes.roleSelectionRegister);
  }
}
