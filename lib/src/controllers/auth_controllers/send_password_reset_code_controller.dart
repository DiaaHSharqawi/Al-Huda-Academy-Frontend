import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/send_password_reset_code_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';

class SendPasswordResetCodeController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final SendPasswordResetCodeService _forgetPasswordService;
  var isLoading = false.obs;
  SendPasswordResetCodeController(this._forgetPasswordService);

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

  void navigateToResetPasswordScreen() {
    Get.toNamed(AppRoutes.resetPassword);
  }
}
