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
import 'package:moltqa_al_quran_frontend/src/data/model/auth/reset_password_response.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_otp_verification_field.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.0,
                    child: _buildAcademyLogo(),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  _buildEnterVerificationCodeText(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _buildOTPVerificationField(),
                  const SizedBox(
                    height: 52.0,
                  ),
                  const Divider(
                    height: 5.0,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 52.0,
                  ),
                  _buildNewPasswordForm(context),
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
      width: 250.0,
      height: 250.0,
      text: SharedLanguageConstants.academyName.tr,
      fontSize: 15.0,
    );
  }

  Widget _buildEnterVerificationCodeText() {
    return CustomGoogleTextWidget(
      text: ResetPasswordScreenLanguageConstants.enterVerificationCode.tr,
      fontSize: 18.0,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildOTPVerificationField() {
    return OTPVerificationField(
        controller: controller.verificationCodeController,
        borderColor: AppColors.primaryColor,
        focusedBorderColor: AppColors.primaryColor,
        submittedBackgroundColor: Colors.grey[200]!,
        textStyle: const TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        fieldWidth: 60,
        fieldHeight: 60,
        length: 4,
        onComplete: (String pin) {
          controller.verificationCode.value = pin;
        });
  }

  Widget _buildNewPasswordForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          _buildNewPasswordText(),
          const SizedBox(
            height: 8.0,
          ),
          _buildPasswordField(),
          const SizedBox(
            height: 16.0,
          ),
          _buildVerifyCodeButton(context),
        ],
      ),
    );
  }

  Widget _buildNewPasswordText() {
    return SizedBox(
      width: double.infinity,
      child: CustomGoogleTextWidget(
        text: ResetPasswordScreenLanguageConstants.passowrd.tr,
        fontSize: 18.0,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () {
        return CustomAuthTextFormField(
          textFormHintText:
              ResetPasswordScreenLanguageConstants.passwordHintText,
          iconName: controller.isObscureText.value
              ? Icons.visibility_off_rounded
              : Icons.remove_red_eye,
          colorIcon: AppColors.primaryColor,
          obscureText: controller.isObscureText.value,
          controller: controller.passowrdController,
          textFormFieldValidator: AuthValidations.validatePassword,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          onTap: () {
            controller.isObscureText.value = !controller.isObscureText.value;
          },
        );
      },
    );
  }

  Widget _buildVerifyCodeButton(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          width: double.infinity,
          child: CustomAuthTextButton(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            buttonText: ResetPasswordScreenLanguageConstants.verifyCode.tr,
            buttonTextColor: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              controller.isSubmitting.value = true;
              controller.isEnabled.value = false;

              ResetPasswordResponse? resetPasswordResponse;
              try {
                resetPasswordResponse = await controller.resetPassword();
                if (!context.mounted) return;
                await _handleResponse(resetPasswordResponse, context);
              } catch (error) {
                debugPrint(error.toString());
                if (!context.mounted) return;
                _showDialog(context, DialogType.error, error.toString());
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
      },
    );
  }

  Future<void> _handleResponse(ResetPasswordResponse? resetPasswordResponse,
      BuildContext context) async {
    if (!context.mounted) return;
    debugPrint(resetPasswordResponse.toString());
    switch (resetPasswordResponse!.statusCode) {
      case (200):
        {
          _showDialog(
            context,
            DialogType.success,
            resetPasswordResponse.message!,
          );
          controller.navigateToLoginScreen();
          break;
        }
      case 422:
        _showDialog(
          context,
          DialogType.error,
          SendPasswordResetCodeScreenLanguageConstants
              .pleaseMakeSureToFillAllFields.tr,
        );
        break;
      default:
        _showDialog(
          context,
          DialogType.error,
          resetPasswordResponse.message!,
        );
        break;
    }
  }

  void _showDialog(
      BuildContext context, DialogType type, String message) async {
    return CustomAwesomeDialog.showAwesomeDialog(
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
