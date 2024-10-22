import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/login_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = LoginController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appService = Get.find<AppService>();

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
                    final isArabic = appService.isRtl.value;

                    final TextDirection textDirection =
                        isArabic ? TextDirection.rtl : TextDirection.ltr;

                    final TextDirection textFormDirection =
                        isArabic ? TextDirection.ltr : TextDirection.rtl;
                    final TextDirection hintTextDirection = textFormDirection;

                    final String fontFamily =
                        isArabic ? AppFonts.arabicFont : AppFonts.englishFont;

                    return Directionality(
                      textDirection: textDirection,
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
                            _buildProjectLogo(),
                            Column(
                              children: [
                                _buildEmailField(
                                    textFormDirection, hintTextDirection),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                _buildPasswordField(
                                    textFormDirection, hintTextDirection),
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
                                    child:
                                        _buildLoginButton(context, fontFamily)),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child:
                                        _buildDontHaveAccountText(fontFamily)),
                              ],
                            )
                          ],
                        ),
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
    return FittedBox(
      child: Image.asset(
        AppImages.holyQuranLogo,
        width: 250,
        height: 250,
      ),
    );
  }

  Widget _buildEmailField(
      TextDirection textFormDirection, TextDirection hintTextDirection) {
    return CustomAuthTextFormField(
      textFormDirection: textFormDirection,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textFormFieldValidator: loginController.validateEmail,
      controller: loginController.userIdentifierController,
      textFormLabelText: LoginScreenLanguageConstants.formFieldsInputsEmail.tr,
      textFormHintText: LoginScreenLanguageConstants.hintTextAuthEmail,
      iconName: Icons.email,
      colorIcon: AppColors.primaryColor,
      hintTextDirection: hintTextDirection,
    );
  }

  Widget _buildPasswordField(
      TextDirection textFormDirection, TextDirection hintTextDirection) {
    return CustomAuthTextFormField(
      textFormDirection: textFormDirection,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textFormFieldValidator: loginController.validatePassword,
      controller: loginController.passwordController,
      obscureText: true,
      textFormLabelText:
          LoginScreenLanguageConstants.formFieldsInputsPassword.tr.tr,
      textFormHintText: LoginScreenLanguageConstants.hintTextAuthPassword,
      iconName: Icons.remove_red_eye,
      colorIcon: AppColors.primaryColor,
      hintTextDirection: hintTextDirection,
    );
  }

  Widget _buildForgetPasswordText() {
    return CustomGoogleTextWidget(
      text: LoginScreenLanguageConstants.formFieldsInputsForgetPassword.tr,
      color: AppColors.primaryColor,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildLoginButton(BuildContext context, String fontFamily) {
    return CustomAuthTextButton(
      onPressed: <Future>() async {
        if (!context.mounted) return;
        String loginResult = await loginController.signIn(context);
        if (loginResult == "Login successful!") {
          if (!context.mounted) return;
          await CustomAwesomeDialog.showAwesomeDialog(
              context, DialogType.success, "Success", "succes login");
          loginController.navigateToHomeSceen();
        } else {
          if (!context.mounted) return;

          await CustomAwesomeDialog.showAwesomeDialog(
              context, DialogType.error, "failed", loginResult);
        }
      },
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primaryColor,
      buttonText: LoginScreenLanguageConstants.buttonTextLogin.tr,
      buttonTextColor: Colors.white,
      fontFamily: fontFamily,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      loadingWidget: loginController.isLoading.value
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : null,
    );
  }

  Widget _buildDontHaveAccountText(String fontFamily) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomGoogleTextWidget(
          text: LoginScreenLanguageConstants.dontHaveAnAccount.tr,
          fontFamily: fontFamily,
          fontSize: 16.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          width: 12.0,
        ),
        CustomGoogleTextWidget(
          text: LoginScreenLanguageConstants.newUser.tr,
          fontFamily: fontFamily,
          fontSize: 16.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          onTap: () {
            loginController.navigateToRegisterSceen();
          },
        ),
      ],
    );
  }
}
