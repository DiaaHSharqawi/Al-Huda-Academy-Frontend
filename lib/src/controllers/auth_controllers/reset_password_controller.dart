import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/reset_password_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passowrdController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();

  final ResetPasswordService _forgetPasswordService;

  var isLoading = false.obs;
  var isSubmitting = false.obs;
  var isEnabled = true.obs;

  var isObscureText = true.obs;

  var verificationCode = "".obs;

  ResetPasswordController(this._forgetPasswordService);

  String? message;
  Future<String> sendPasswordResetCode() async {
    final err = AuthValidations.validateAll({
      'email': emailController.text,
    });

    if (err != null) {
      return 'Please make sure to fill all fields correctly!';
    }
    try {
      isLoading(true);
      final response =
          await _forgetPasswordService.forgetPassword(emailController.text);
      debugPrint(response.toString());

      if (response != null && response.success) {
        debugPrint(response.message);
        return response.message!;
      } else {
        debugPrint(response!.message);
        return response.message!;
      }
    } catch (error) {
      debugPrint(error.toString());
      return error.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> resetPassword() async {
    debugPrint(
        "${emailController.text},${passowrdController.text},${verificationCodeController.text}");
    final err = AuthValidations.validateAll({
      'email': emailController.text,
      'password': passowrdController.text,
      'verificationCode': verificationCodeController.text,
    });
    if (err != null) {
      return 'Please make sure to fill all fields correctly!';
    }
    try {
      isSubmitting(true);
      isLoading(true);

      final response = await _forgetPasswordService.resetPassword(
          emailController.text,
          passowrdController.text,
          verificationCodeController.text);
      debugPrint(response.toJson().toString());
      return response.message;
    } catch (error) {
      debugPrint(error.toString());
      return error.toString();
    } finally {
      isSubmitting(false);
      isLoading(false);
    }
  }

  void navigateToResetPasswordScreen() {
    passowrdController.clear();
    verificationCodeController.clear();
    Get.toNamed(AppRoutes.resetPassword);
  }

  void navigateToLoginScreen() {
    Get.offAllNamed(AppRoutes.login);
  }
}
