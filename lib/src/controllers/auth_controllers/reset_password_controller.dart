import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/reset_password_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/forget_password_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/reset_password_response.dart';

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
  Future<ForgetPasswordResponse?> sendPasswordResetCode() async {
    final err = AuthValidations.validateAll({
      'email': emailController.text,
    });

    ForgetPasswordResponse? forgetPasswordResponse;
    if (err != null) {
      forgetPasswordResponse = ForgetPasswordResponse(
        statusCode: 422,
        success: false,
        message: 'Please make sure to fill all fields correctly!',
      );
      return forgetPasswordResponse;
    }

    try {
      isLoading(true);

      String email = emailController.text;
      forgetPasswordResponse =
          await _forgetPasswordService.forgetPassword(email);

      debugPrint(forgetPasswordResponse.toString());

      return forgetPasswordResponse;
    } catch (error) {
      debugPrint(error.toString());
      forgetPasswordResponse = ForgetPasswordResponse(
        statusCode: 500,
        success: false,
        message:
            "An error occurred while requesting the password reset. Please try again.",
      );
      return forgetPasswordResponse;
    } finally {
      isLoading(false);
    }
  }

  Future<ResetPasswordResponse> resetPassword() async {
    debugPrint(
        "${emailController.text},${passowrdController.text},${verificationCodeController.text}");
    final err = AuthValidations.validateAll({
      'email': emailController.text,
      'password': passowrdController.text,
      'verificationCode': verificationCodeController.text,
    });
    debugPrint(err.toString());
    ResetPasswordResponse resetPasswordResponse;

    if (err != null) {
      resetPasswordResponse = ResetPasswordResponse(
        statusCode: 422,
        success: false,
        message: 'Please make sure to fill all fields correctly!',
      );
    }

    try {
      isSubmitting(true);
      isLoading(true);

      final response = await _forgetPasswordService.resetPassword(
          emailController.text,
          passowrdController.text,
          verificationCodeController.text);
      debugPrint(response.statusCode.toString());
      resetPasswordResponse = ResetPasswordResponse(
        statusCode: response.statusCode,
        success: response.success,
        message: response.message,
      );
      return resetPasswordResponse;
    } catch (error) {
      debugPrint(error.toString());
      resetPasswordResponse = ResetPasswordResponse(
        statusCode: 500,
        success: false,
        message:
            "An error occurred while requesting the password reset. Please try again.",
      );
      return resetPasswordResponse;
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
