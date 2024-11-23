import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response/register_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(() {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: AppColors.primaryBackgroundColor,
          title: _buildCreateNewAccountText(),
        ),
        backgroundColor: AppColors.primaryBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
                child: Column(
              children: [
                _buildProfileImagePicker(),
                _buildTextInputField(
                  RegisterScreenLanguageConstants.fullName.tr,
                  RegisterScreenLanguageConstants.enterAFullName.tr,
                  Icons.perm_identity,
                  controller.fullNameController,
                  AuthValidations.validateFullName,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _buildTextInputField(
                  RegisterScreenLanguageConstants.email.tr,
                  RegisterScreenLanguageConstants.hintEmail,
                  Icons.email,
                  controller.emailController,
                  AuthValidations.validateEmail,
                ),
                const SizedBox(height: 30.0),
                _buildTextInputField(
                  RegisterScreenLanguageConstants.phoneNumber.tr,
                  RegisterScreenLanguageConstants.phoneNumberHint,
                  Icons.phone_android_outlined,
                  controller.phoneController,
                  AuthValidations.validatePhoneNumber,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _buildResidenceFields(),
                const SizedBox(
                  height: 42.0,
                ),
                _buildGenderSelection(),
                const SizedBox(
                  height: 30.0,
                ),
                _buildAgeField(),
                const SizedBox(
                  height: 30.0,
                ),
                _buildPasswordField(
                  RegisterScreenLanguageConstants.password.tr,
                  RegisterScreenLanguageConstants.passwordHint,
                  Icons.lock_outline,
                  controller.passwordController,
                  AuthValidations.validatePassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _buildSaveDataButton(context),
              ],
            )),
          ),
        ),
      );
    }));
  }

  Widget _buildSaveDataButton(BuildContext context) {
    controller.hasInteracted.value = true;
    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        return CustomAuthTextButton(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          buttonText: RegisterScreenLanguageConstants.saveData.tr,
          buttonTextColor: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          onPressed: () async {
            controller.isSubmitting.value = true;
            controller.isEnabled.value = false;

            try {
              RegisterResponse registerResponse =
                  await controller.registerUser();

              debugPrint("==============================================");
              debugPrint(
                  "RegisterResponse status code: ${registerResponse.statusCode}");
              debugPrint(
                  "RegisterResponse message: ${registerResponse.message}");
              debugPrint("RegisterResponse user: $registerResponse");
              debugPrint(
                  "RegisterResponse accessToken: ${registerResponse.data?.accessToken}");
              debugPrint("==============================================");
              if (!context.mounted) return;
              await _handleRegisterResponse(context, registerResponse);
            } catch (error) {
              debugPrint(error.toString());
              if (context.mounted) {
                await _showDialog(
                  context,
                  DialogType.error,
                  AuthValidationsLanguageConstants.error.tr,
                  error.toString(),
                );
              }
            } finally {
              controller.isSubmitting.value = false;
              controller.isEnabled.value = true;
            }
          },
          loadingWidget: controller.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : null,
          isEnabled: controller.isEnabled.value,
        );
      }),
    );
  }

  Future<void> _handleRegisterResponse(
    BuildContext context,
    RegisterResponse registerResponse,
  ) async {
    if (!context.mounted) return;

    DialogType dialogType = DialogType.error;
    String message = registerResponse.message ?? 'Unknown error';

    if (registerResponse.statusCode == 201) {
      dialogType = DialogType.success;
      message = registerResponse.message ?? 'Success Register!';
      await _showDialog(
        context,
        dialogType,
        AuthValidationsLanguageConstants.success.tr,
        message,
      );
      controller.navigateToLoginScreen();
    } else {
      await _showDialog(
        context,
        dialogType,
        AuthValidationsLanguageConstants.error.tr,
        message,
      );
    }
  }

  Future<void> _showDialog(
    BuildContext context,
    DialogType dialogType,
    String title,
    String message,
  ) async {
    if (context.mounted) {
      await CustomAwesomeDialog.showAwesomeDialog(
        context,
        dialogType,
        title,
        message,
      );
    }
  }

  Widget _buildAgeField() {
    return _buildTextInputField(
      RegisterScreenLanguageConstants.age.tr,
      RegisterScreenLanguageConstants.enterTheAge.tr,
      Icons.calendar_today,
      controller.ageController,
      AuthValidations.validateAge,
    );
  }

  Widget _buildCreateNewAccountText() {
    return CustomGoogleTextWidget(
      text: RegisterScreenLanguageConstants.createANewAccount.tr,
      fontSize: 20,
    );
  }

  Widget _buildTextInputField(String label, String hint, IconData icon,
      TextEditingController controller, String? Function(String?) validator,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomGoogleTextWidget(
          text: label,
          fontFamily: AppFonts.arabicFont,
          fontSize: 16.0,
        ),
        const SizedBox(height: 12.0),
        CustomAuthTextFormField(
          textFormHintText: hint,
          iconName: icon,
          colorIcon: AppColors.primaryColor,
          controller: controller,
          textFormFieldValidator: validator,
          autovalidateMode: this.controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, String hint, IconData icon,
      TextEditingController controller, String? Function(String?) validator,
      {bool obscureText = false}) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomGoogleTextWidget(
            text: label,
            fontFamily: AppFonts.arabicFont,
            fontSize: 16.0,
          ),
          const SizedBox(height: 12.0),
          CustomAuthTextFormField(
            textFormHintText: hint,
            iconName: this.controller.isObscureText.value
                ? Icons.visibility_off_rounded
                : Icons.remove_red_eye,
            colorIcon: AppColors.primaryColor,
            controller: controller,
            textFormFieldValidator: validator,
            autovalidateMode: this.controller.isSubmitting.value
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
            obscureText: this.controller.isObscureText.value,
            onTap: () {
              this.controller.isObscureText.value =
                  !this.controller.isObscureText.value;
            },
          ),
        ],
      );
    });
  }

  Widget _buildResidenceFields() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomGoogleTextWidget(
            text: RegisterScreenLanguageConstants.residence.tr,
            fontFamily: AppFonts.arabicFont,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomAuthTextFormField(
          textFormHintText: RegisterScreenLanguageConstants.enterACountry.tr,
          iconName: Icons.public,
          colorIcon: AppColors.primaryColor,
          controller: controller.countryController,
          textFormFieldValidator: AuthValidations.validateCountry,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          obscureText: false,
        ),
        const SizedBox(height: 24.0),
        CustomAuthTextFormField(
          textFormHintText: RegisterScreenLanguageConstants.enterACity.tr,
          iconName: Icons.home,
          colorIcon: AppColors.primaryColor,
          controller: controller.cityController,
          textFormFieldValidator: AuthValidations.validateCity,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          obscureText: false,
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: controller.hasInteracted.value
              ? (controller.selectedGender.value == Gender.notSelected)
                  ? Colors.red
                  : Colors.grey
              : Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomGoogleTextWidget(
                text: RegisterScreenLanguageConstants.enterTheGender.tr,
                fontSize: 16.0,
              ),
              Obx(() {
                return ChoiceChip(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.male, color: Colors.blue),
                      const SizedBox(width: 8.0),
                      Text(RegisterScreenLanguageConstants.genderMale.tr),
                    ],
                  ),
                  selected: controller.selectedGender.value == Gender.male,
                  onSelected: (isSelected) {
                    controller.hasInteracted.value = true;
                    if (isSelected) {
                      controller.selectedGender.value = Gender.male;
                    }
                  },
                  selectedColor: Colors.blue.withOpacity(0.2),
                  backgroundColor: Colors.grey[200],
                );
              }),
              Obx(() {
                return ChoiceChip(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.female, color: Colors.pink),
                      const SizedBox(width: 4.0),
                      Text(RegisterScreenLanguageConstants.genderFemale.tr),
                    ],
                  ),
                  selected: controller.selectedGender.value == Gender.female,
                  onSelected: (isSelected) {
                    controller.hasInteracted.value = true;
                    if (isSelected) {
                      controller.selectedGender.value = Gender.female;
                    }
                  },
                  selectedColor: Colors.pink.withOpacity(0.2),
                  backgroundColor: Colors.grey[200],
                );
              }),
            ],
          ),
          if (controller.hasInteracted.value &&
              controller.selectedGender.value == Gender.notSelected)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomGoogleTextWidget(
                  text:
                      RegisterScreenLanguageConstants.pleaseChooseTheGender.tr,
                  fontSize: 14.0,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 64.0,
          backgroundImage: controller.profileImage != null
              ? MemoryImage(controller.profileImage!)
              : const AssetImage(AppImages.userAvatarImage),
        ),
        Positioned(
          bottom: -10.0,
          right: 0.0,
          child: IconButton(
            onPressed: _selectImage,
            icon: const Icon(Icons.add_a_photo, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  Future<void> _selectImage() async {
    Uint8List? img = await CustomImagePicker.pickImage(ImageSource.gallery);
    if (img != null) {
      controller.updateProfileImage(img);
    }
  }
}
