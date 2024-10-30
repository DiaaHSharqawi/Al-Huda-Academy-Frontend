import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/reset_password_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_otp_verification_field.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint("email : ${controller.emailController.text}");
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
    return const CustomGoogleTextWidget(
      text: "ادخل رمز التحقق",
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

              String? responseMessage;
              try {
                responseMessage = await controller.resetPassword();
                if (!context.mounted) return;
                await _handleResponse(responseMessage, context);
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
      },
    );
  }

  Future<void> _handleResponse(
      String? responseMessage, BuildContext context) async {
    if (!context.mounted) return;
    debugPrint(responseMessage);
    switch (responseMessage) {
      case "Password has been reset successfully":
        {
          await _showDialog(
            context,
            DialogType.success,
            ResetPasswordScreenLanguageConstants.passwordResetSuccessfully.tr,
          );
          controller.navigateToLoginScreen();
          break;
        }
      case "Invalid or expired code":
        await _showDialog(
          context,
          DialogType.error,
          ResetPasswordScreenLanguageConstants.invalidOrExpiredCode.tr,
        );
        break;
      case "Invalid credentials. Please check your email, then try again.":
        await _showDialog(
          context,
          DialogType.error,
          SendPasswordResetCodeScreenLanguageConstants.invalidCredentials.tr,
        );
        break;

      case "Please make sure to fill all fields correctly!":
        await _showDialog(
          context,
          DialogType.error,
          SendPasswordResetCodeScreenLanguageConstants
              .pleaseMakeSureToFillAllFields.tr,
        );
        break;
      default:
        await _showDialog(context, DialogType.error, responseMessage!);
        break;
    }
  }

  Future<void> _showDialog(
      BuildContext context, DialogType type, String message) async {
    await CustomAwesomeDialog.showAwesomeDialog(
      context,
      type,
      type == DialogType.success
          ? AuthValidationsLanguageConstants.success.tr
          : AuthValidationsLanguageConstants.error.tr,
      message,
    );
  }
}
