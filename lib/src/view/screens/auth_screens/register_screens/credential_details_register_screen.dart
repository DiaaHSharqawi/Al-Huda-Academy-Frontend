import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class CredentialDetailsRegisterScreen extends GetView<RegisterController> {
  const CredentialDetailsRegisterScreen({super.key});
  final double sizeBoxColumnSpace = 20.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCrendentialDetailsImage(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 5,
                  ),
                  _buildEnterYourCredentialsText(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  _buildEmailField(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  _buildPasswordField(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  _buildContinueButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return CustomAppBar(
      showBackArrow: true,
      arrowColor: Colors.black,
      appBarChilds: Column(
        children: [
          Container(
            width: 0,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      preferredSize: const Size.fromHeight(50.0),
      child: const SizedBox(),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () {
          return CustomButton(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            buttonText: 'استمر',
            buttonTextColor: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              Object result = await controller.validateCredentials();
              debugPrint("Result: $result");
              debugPrint("Result type: ${result.runtimeType}");

              if (result is Map && result['statusCode'] == 404) {
                // should be navigate to the next screen
                debugPrint("Navigate to the next screen");
                controller.navigateToQualificationsScreen();
              } else {
                if (!context.mounted) return;
                await CustomAwesomeDialog.showAwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: 'خطأ',
                  description: (result as Map<String, dynamic>)['message'],
                  btnOkOnPress: () {},
                  btnCancelOnPress: null,
                );
              }
            },
            loadingWidget: controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : null,
            isEnabled: !controller.isLoading.value,
          );
        },
      ),
    );
  }

  Widget _buildCrendentialDetailsImage() {
    return Image.asset(
      'assets/images/email_with_password.png',
      width: double.infinity,
      height: 150.0,
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            CustomGoogleTextWidget(
              text: 'البريد الالكتروني',
              fontFamily: AppFonts.arabicFont,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 10.0),
            CustomGoogleTextWidget(
              text: '*',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Obx(() {
          return CustomAuthTextFormField(
            textFormHintText: 'example@email.com',
            controller: controller.emailController,
            textFormFieldValidator: AuthValidations.validateEmail,
            autovalidateMode: controller.isSubmitting.value
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
          );
        }),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            CustomGoogleTextWidget(
              text: ' كلمة السر',
              fontFamily: AppFonts.arabicFont,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 10.0),
            CustomGoogleTextWidget(
              text: '*',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ],
        ),
        SizedBox(height: sizeBoxColumnSpace),
        Obx(
          () {
            return CustomAuthTextFormField(
              textFormHintText: '**********',
              iconName: controller.isObscureText.value
                  ? Icons.visibility_off_rounded
                  : Icons.remove_red_eye,
              colorIcon: AppColors.primaryColor,
              controller: controller.passwordController,
              textFormFieldValidator: AuthValidations.validatePassword,
              autovalidateMode: controller.isSubmitting.value
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction,
              obscureText: controller.isObscureText.value,
              onTap: () {
                debugPrint('onTap');
                controller.isObscureText.value =
                    !controller.isObscureText.value;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildEnterYourCredentialsText() {
    return const CustomGoogleTextWidget(
      text: 'يرجى إدخال البريد الالكتروني وكلمة السر',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }
}
