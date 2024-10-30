import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/login_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildGreetingText(),
                      const SizedBox(
                        height: 24.0,
                      ),
                      _buildWelcomeBackText(),
                      Container(
                        alignment: Alignment.topCenter,
                        child: _buildProjectLogo(),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Column(
                        children: [
                          Obx(
                            () {
                              return Column(
                                children: [
                                  _buildEmailField(),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  _buildPasswordField(),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: _buildForgetPasswordText(),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: _buildLoginButton(context),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: _buildDontHaveAccountText(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingText() {
    return CustomGoogleTextWidget(
      text: LoginScreenLanguageConstants.greeting.tr,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildWelcomeBackText() {
    return CustomGoogleTextWidget(
      text: LoginScreenLanguageConstants.welcomeBack.tr,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildProjectLogo() {
    return SizedBox(
      width: 240,
      height: 240,
      child: CustomProjectLogo(
        imagePath: AppImages.holyQuranLogo,
        width: 250.0,
        height: 250.0,
        text: SharedLanguageConstants.academyName.tr,
        fontSize: 18.0,
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomAuthTextFormField(
      autovalidateMode: controller.isSubmitting.value
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      textFormFieldValidator: AuthValidations.validateEmail,
      controller: controller.userIdentifierController,
      textFormLabelText: LoginScreenLanguageConstants.formFieldsInputsEmail.tr,
      textFormHintText: LoginScreenLanguageConstants.hintTextAuthEmail,
      iconName: Icons.email,
      colorIcon: AppColors.primaryColor,
    );
  }

  Widget _buildPasswordField() {
    return Obx(() {
      return CustomAuthTextFormField(
        autovalidateMode: controller.isSubmitting.value
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        textFormFieldValidator: AuthValidations.validatePassword,
        controller: controller.passwordController,
        obscureText: controller.isObscureText.value,
        textFormLabelText:
            LoginScreenLanguageConstants.formFieldsInputsPassword.tr.tr,
        textFormHintText: LoginScreenLanguageConstants.hintTextAuthPassword,
        iconName: controller.isObscureText.value
            ? Icons.visibility_off_rounded
            : Icons.remove_red_eye,
        colorIcon: AppColors.primaryColor,
        onTap: () {
          controller.isObscureText.value = !controller.isObscureText.value;
        },
      );
    });
  }

  Widget _buildForgetPasswordText() {
    return Container(
      alignment: Alignment.centerRight,
      child: CustomGoogleTextWidget(
        text: LoginScreenLanguageConstants.formFieldsInputsForgetPassword.tr,
        color: AppColors.primaryColor,
        fontSize: 18.0,
        textDecoration: TextDecoration.underline,
        onTap: controller.navigateToForgetPasswordScreen,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Obx(() {
      return CustomAuthTextButton(
        onPressed: <Future>() async {
          controller.isSubmitting.value = true;
          controller.isEnabled.value = false;
          debugPrint("===> ${controller.isSubmitting.value}");
          if (!context.mounted) return;
          String loginResult = await controller.signIn(context);
          debugPrint(loginResult);

          if (loginResult == "Login successful!") {
            if (!context.mounted) return;
            await CustomAwesomeDialog.showAwesomeDialog(
              context,
              DialogType.success,
              AuthValidationsLanguageConstants.success.tr,
              LoginScreenLanguageConstants.successLoginMessage.tr,
            );
            controller.navigateToHomeScreen();
          } else if (loginResult ==
              "Validation failed, Please enter a valid username and email.") {
            if (!context.mounted) return;
            await CustomAwesomeDialog.showAwesomeDialog(
              context,
              DialogType.error,
              LoginScreenLanguageConstants.loginFailedMessage.tr,
              LoginScreenLanguageConstants.invalidInputs.tr,
            );
          } else if (loginResult ==
              "Invalid credentials. Please check your email and password, then try again.") {
            if (!context.mounted) return;
            await CustomAwesomeDialog.showAwesomeDialog(
              context,
              DialogType.error,
              AuthValidationsLanguageConstants.error.tr,
              LoginScreenLanguageConstants.invalidCredentials.tr,
            );
          } else {
            if (!context.mounted) return;

            await CustomAwesomeDialog.showAwesomeDialog(
              context,
              DialogType.error,
              LoginScreenLanguageConstants.loginFailedMessage.tr,
              loginResult,
            );
          }

          controller.isSubmitting.value = false;
          controller.isEnabled.value = true;
        },
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        buttonText: LoginScreenLanguageConstants.buttonTextLogin.tr,
        buttonTextColor: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        loadingWidget: controller.isLoading.value
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : null,
        isEnabled: controller.isEnabled.value,
      );
    });
  }

  Widget _buildDontHaveAccountText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomGoogleTextWidget(
          text: LoginScreenLanguageConstants.dontHaveAnAccount.tr,
          fontSize: 16.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          width: 12.0,
        ),
        CustomGoogleTextWidget(
          textDecoration: TextDecoration.underline,
          text: LoginScreenLanguageConstants.newUser.tr,
          fontSize: 16.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          onTap: () {
            controller.navigateToRegisterScreen();
          },
        ),
      ],
    );
  }
}
