import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/login_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AppService appService = Get.find<AppService>();
  final LoginController loginController = Get.find();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: Obx(
                  () {
                    return Form(
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
                              _buildEmailField(),
                              const SizedBox(
                                height: 12.0,
                              ),
                              _buildPasswordField(),
                              const SizedBox(
                                height: 16.0,
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
                    );
                  },
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
      autovalidateMode: _isSubmitting
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      textFormFieldValidator: AuthValidations.validateEmail,
      controller: loginController.userIdentifierController,
      textFormLabelText: LoginScreenLanguageConstants.formFieldsInputsEmail.tr,
      textFormHintText: LoginScreenLanguageConstants.hintTextAuthEmail,
      iconName: Icons.email,
      colorIcon: AppColors.primaryColor,
    );
  }

  Widget _buildPasswordField() {
    return CustomAuthTextFormField(
      autovalidateMode: _isSubmitting
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      textFormFieldValidator: AuthValidations.validatePassword,
      controller: loginController.passwordController,
      obscureText: true,
      textFormLabelText:
          LoginScreenLanguageConstants.formFieldsInputsPassword.tr.tr,
      textFormHintText: LoginScreenLanguageConstants.hintTextAuthPassword,
      iconName: Icons.remove_red_eye,
      colorIcon: AppColors.primaryColor,
    );
  }

  Widget _buildForgetPasswordText() {
    return Container(
      alignment: Alignment.centerRight,
      child: CustomGoogleTextWidget(
        text: LoginScreenLanguageConstants.formFieldsInputsForgetPassword.tr,
        color: AppColors.primaryColor,
        fontSize: 18.0,
        textDecoration: TextDecoration.underline,
        onTap: loginController.navigateToForgetPasswordScreen,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CustomAuthTextButton(
      onPressed: <Future>() async {
        setState(() {
          _isSubmitting = false;
        });
        if (!context.mounted) return;
        String loginResult = await loginController.signIn(context);
        debugPrint(loginResult);

        if (loginResult == "Login successful!") {
          if (!context.mounted) return;
          await CustomAwesomeDialog.showAwesomeDialog(
            context,
            DialogType.success,
            LoginScreenLanguageConstants.successLoginMessage.tr,
            loginResult,
          );
          loginController.navigateToHomeScreen();
        } else if (loginResult ==
            "Validation failed, Please enter a valid username and email.") {
          if (!context.mounted) return;
          await CustomAwesomeDialog.showAwesomeDialog(
            context,
            DialogType.error,
            LoginScreenLanguageConstants.loginFailedMessage.tr,
            LoginScreenLanguageConstants.invalidInputs.tr,
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
        setState(() {
          _isSubmitting = false;
        });
      },
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primaryColor,
      buttonText: LoginScreenLanguageConstants.buttonTextLogin.tr,
      buttonTextColor: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      loadingWidget: loginController.isLoading.value
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : null,
    );
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
            loginController.navigateToRegisterScreen();
          },
        ),
      ],
    );
  }
}
