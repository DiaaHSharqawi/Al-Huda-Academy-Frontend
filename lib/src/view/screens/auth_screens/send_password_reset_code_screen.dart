import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/reset_password_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/forget_password_response.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';

class SendPasswordResetCodeScreen extends GetView<ResetPasswordController> {
  const SendPasswordResetCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: AppColors.primaryBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAcademyLogo(),
                  const SizedBox(
                    height: 48.0,
                  ),
                  Column(
                    children: [
                      _buildForgetPasswordText(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _buildPasswordResetInstructionsText(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      _buildEmailForm(context),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAcademyLogo() {
    return CustomProjectLogo(
      imagePath: AppImages.holyQuranLogo,
      width: 300.0,
      height: 250.0,
      text: SharedLanguageConstants.academyName.tr,
    );
  }

  Widget _buildForgetPasswordText() {
    return SizedBox(
      width: double.infinity,
      child: CustomGoogleTextWidget(
        text: SendPasswordResetCodeScreenLanguageConstants.forgetPassword.tr,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPasswordResetInstructionsText() {
    return Container(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: double.infinity,
        child: CustomGoogleTextWidget(
          text: SendPasswordResetCodeScreenLanguageConstants
              .forgetPasswordInstructions.tr,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _buildEmailForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          _buildEmailText(),
          const SizedBox(
            height: 8.0,
          ),
          _buildEmailField(),
          const SizedBox(
            height: 16.0,
          ),
          _buildSendCodeButton(context),
        ],
      ),
    );
  }

  Widget _buildEmailText() {
    return SizedBox(
      width: double.infinity,
      child: CustomGoogleTextWidget(
        text: SendPasswordResetCodeScreenLanguageConstants.email.tr,
        fontSize: 18.0,
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomAuthTextFormField(
      textFormHintText:
          SendPasswordResetCodeScreenLanguageConstants.hintEmailText,
      iconName: Icons.email,
      colorIcon: AppColors.primaryColor,
      obscureText: false,
      controller: controller.emailController,
      textFormFieldValidator: AuthValidations.validateEmail,
      autovalidateMode: controller.isSubmitting.value
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildSendCodeButton(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: CustomAuthTextButton(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          buttonText: SendPasswordResetCodeScreenLanguageConstants.sendCode.tr,
          buttonTextColor: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          onPressed: () async {
            // controller.navigateToResetPasswordScreen();

            controller.isSubmitting.value = true;
            controller.isEnabled.value = false;

            ForgetPasswordResponse? forgetPasswordResponse;
            try {
              forgetPasswordResponse = await controller.sendPasswordResetCode();
              if (!context.mounted) return;
              await _handleResponse(forgetPasswordResponse, context);
            } catch (error) {
              debugPrint(error.toString());
              if (!context.mounted) return;
              await _showDialog(context, DialogType.error, error.toString());
            }

            controller.isSubmitting.value = false;
            controller.isEnabled.value = true;
          },
          loadingWidget: controller.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : null,
          isEnabled: controller.isEnabled.value,
        ),
      );
    });
  }

  Future<void> _handleResponse(ForgetPasswordResponse? forgetPasswordResponse,
      BuildContext context) async {
    if (!context.mounted) return;
    debugPrint(forgetPasswordResponse.toString());
    if (forgetPasswordResponse!.statusCode == 200) {
      await _showDialog(
        context,
        DialogType.success,
        forgetPasswordResponse.message!,
      );
      controller.navigateToResetPasswordScreen();
    } else if (forgetPasswordResponse.statusCode == 409) {
      await _showDialog(
        context,
        DialogType.error,
        forgetPasswordResponse.message!,
      );
      controller.navigateToResetPasswordScreen();
    } else if (forgetPasswordResponse.statusCode == 422) {
      await _showDialog(
        context,
        DialogType.error,
        SendPasswordResetCodeScreenLanguageConstants
            .pleaseMakeSureToFillAllFields.tr,
      );
    } else {
      await _showDialog(
          context, DialogType.error, forgetPasswordResponse.message!);
    }
  }

  Future<void> _showDialog(
      BuildContext context, DialogType type, String message) async {
    await CustomAwesomeDialog.showAwesomeDialog(
      context: context,
      dialogType: type,
      title: type == DialogType.success
          ? AuthValidationsLanguageConstants.success.tr
          : AuthValidationsLanguageConstants.error.tr,
      description: message,
      btnOkOnPress: () {},
      btnCancelOnPress: null,
    );
  }
}
