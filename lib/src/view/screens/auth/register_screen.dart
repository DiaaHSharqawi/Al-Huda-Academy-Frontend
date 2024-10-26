import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.find();
  final AppService appService = Get.find<AppService>();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  bool hasInteracted = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(() {
      final isArabic = appService.isRtl.value;
      debugPrint(isArabic.toString());
      final TextDirection textDirection =
          isArabic ? TextDirection.rtl : TextDirection.ltr;

      final TextDirection textFormDirection =
          isArabic ? TextDirection.ltr : TextDirection.rtl;

      debugPrint(textDirection.toString());
      final TextDirection hintTextDirection = textFormDirection;

      final String fontFamily =
          isArabic ? AppFonts.arabicFont : AppFonts.englishFont;
      return Directionality(
        textDirection: textDirection,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: AppColors.primaryBackgroundColor,
            title: _buildCreateNewAccountText(fontFamily),
          ),
          backgroundColor: AppColors.primaryBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildProfileImagePicker(),
                      _buildTextInputField(
                        RegisterScreenLanguageConstants.fullName.tr,
                        RegisterScreenLanguageConstants.enterAFullName.tr,
                        Icons.perm_identity,
                        registerController.fullNameController,
                        AuthValidations.validateFullName,
                        textFormDirection,
                        hintTextDirection,
                        fontFamily,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildTextInputField(
                        RegisterScreenLanguageConstants.email.tr,
                        RegisterScreenLanguageConstants.hintEmail,
                        Icons.email,
                        registerController.emailController,
                        AuthValidations.validateEmail,
                        textFormDirection,
                        hintTextDirection,
                        fontFamily,
                      ),
                      const SizedBox(height: 30.0),
                      _buildTextInputField(
                          RegisterScreenLanguageConstants.phoneNumber.tr,
                          RegisterScreenLanguageConstants.phoneNumberHint,
                          Icons.phone_android_outlined,
                          registerController.phoneController,
                          AuthValidations.validatePhoneNumber,
                          textFormDirection,
                          hintTextDirection,
                          fontFamily),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildResidenceFields(
                        textFormDirection,
                        hintTextDirection,
                        fontFamily,
                      ),
                      const SizedBox(
                        height: 42.0,
                      ),
                      _buildGenderSelection(fontFamily),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildAgeField(
                        textFormDirection,
                        hintTextDirection,
                        fontFamily,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildTextInputField(
                          RegisterScreenLanguageConstants.password.tr,
                          RegisterScreenLanguageConstants.passwordHint,
                          Icons.lock_outline,
                          registerController.passwordController,
                          AuthValidations.validatePassword,
                          textFormDirection,
                          hintTextDirection,
                          obscureText: true,
                          fontFamily),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildSaveDataButton(context, fontFamily),
                    ],
                  )),
            ),
          ),
        ),
      );
    }));
  }

  Widget _buildSaveDataButton(BuildContext context, String fontFamily) {
    hasInteracted = true;
    return SizedBox(
      width: double.infinity,
      child: CustomAuthTextButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        buttonText: RegisterScreenLanguageConstants.saveData.tr,
        buttonTextColor: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        onPressed: () async {
          setState(() {
            _isSubmitting = true;
          });
          try {
            String message = await registerController.submitForm();
            if (message == 'User registered successfully') {
              if (!context.mounted) return;
              await CustomAwesomeDialog.showAwesomeDialog(
                context,
                DialogType.success,
                AuthValidationsLanguageConstants.success.tr,
                message,
                'Almarai',
              );
              registerController.navigateToLoginScreen();
            } else if (message == "Please make sure to fill all fields!") {
              if (!context.mounted) return;
              await CustomAwesomeDialog.showAwesomeDialog(
                context,
                DialogType.error,
                AuthValidationsLanguageConstants.error.tr,
                RegisterScreenLanguageConstants
                    .pleaseMakeSureToFillAllFields.tr,
                fontFamily,
              );
            } else if (message ==
                "Please make sure to upload your profile image.") {
              if (!context.mounted) return;
              await CustomAwesomeDialog.showAwesomeDialog(
                context,
                DialogType.error,
                AuthValidationsLanguageConstants.error.tr,
                RegisterScreenLanguageConstants
                    .pleaseMakeSureToUploadYourProfileImage.tr,
                fontFamily,
              );
            } else {
              if (!context.mounted) return;
              await CustomAwesomeDialog.showAwesomeDialog(
                context,
                DialogType.error,
                AuthValidationsLanguageConstants.error.tr,
                message,
                fontFamily,
              );
            }
          } catch (err) {
            if (!context.mounted) return;
            debugPrint(err.toString());
            CustomAwesomeDialog.showAwesomeDialog(
              context,
              DialogType.error,
              AuthValidationsLanguageConstants.error.tr,
              err.toString(),
              fontFamily,
            );
          }
          setState(() {
            _isSubmitting = false;
          });
        },
      ),
    );
  }

  Widget _buildAgeField(TextDirection textDirection,
      TextDirection hintTextDirection, String fontFamily) {
    return _buildTextInputField(
        RegisterScreenLanguageConstants.age.tr,
        RegisterScreenLanguageConstants.enterTheAge.tr,
        Icons.calendar_today,
        registerController.ageController,
        AuthValidations.validateAge,
        hintTextDirection,
        textDirection,
        fontFamily);
  }

  Widget _buildCreateNewAccountText(String fontFamily) {
    return CustomGoogleTextWidget(
      text: RegisterScreenLanguageConstants.createANewAccount.tr,
      fontFamily: fontFamily,
      fontSize: 20,
    );
  }

  Widget _buildTextInputField(
      String label,
      String hint,
      IconData icon,
      TextEditingController controller,
      String? Function(String?) validator,
      TextDirection textFormDirection,
      TextDirection hintTextDirection,
      String fontFamily,
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
          fontFamily: fontFamily,
          iconName: icon,
          colorIcon: AppColors.primaryColor,
          hintTextDirection: hintTextDirection,
          controller: controller,
          textFormFieldValidator: validator,
          autovalidateMode: _isSubmitting
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          textFormDirection: textFormDirection,
          obscureText: obscureText,
        ),
      ],
    );
  }

  Widget _buildResidenceFields(TextDirection textFormDirection,
      TextDirection hintTextDirection, String fontFamily) {
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
          fontFamily: fontFamily,
          textFormHintText: RegisterScreenLanguageConstants.enterACountry.tr,
          iconName: Icons.public,
          colorIcon: AppColors.primaryColor,
          hintTextDirection: hintTextDirection,
          controller: registerController.countryController,
          textFormFieldValidator: AuthValidations.validateCountry,
          autovalidateMode: _isSubmitting
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          textFormDirection: textFormDirection,
          obscureText: false,
        ),
        const SizedBox(height: 24.0),
        CustomAuthTextFormField(
          textFormHintText: RegisterScreenLanguageConstants.enterACity.tr,
          iconName: Icons.home,
          colorIcon: AppColors.primaryColor,
          hintTextDirection: hintTextDirection,
          controller: registerController.cityController,
          textFormFieldValidator: AuthValidations.validateCity,
          autovalidateMode: _isSubmitting
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          textFormDirection: textFormDirection,
          obscureText: false,
          fontFamily: fontFamily,
        ),
      ],
    );
  }

  Widget _buildGenderSelection(String fontFamily) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: hasInteracted
              ? (registerController.selectedGender.value == Gender.notSelected)
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
                fontFamily: fontFamily,
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
                  selected:
                      registerController.selectedGender.value == Gender.male,
                  onSelected: (isSelected) {
                    hasInteracted = true;
                    if (isSelected) {
                      registerController.selectedGender.value = Gender.male;
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
                  selected:
                      registerController.selectedGender.value == Gender.female,
                  onSelected: (isSelected) {
                    hasInteracted = true;
                    if (isSelected) {
                      registerController.selectedGender.value = Gender.female;
                    }
                  },
                  selectedColor: Colors.pink.withOpacity(0.2),
                  backgroundColor: Colors.grey[200],
                );
              }),
            ],
          ),
          // Show error message if gender is not selected and user has interacted
          if (hasInteracted &&
              registerController.selectedGender.value == Gender.notSelected)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomGoogleTextWidget(
                  text:
                      RegisterScreenLanguageConstants.pleaseChooseTheGender.tr,
                  fontSize: 14.0,
                  color: Colors.red,
                  fontFamily: fontFamily,
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
          backgroundImage: registerController.profileImage != null
              ? MemoryImage(registerController.profileImage!)
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
      registerController.updateProfileImage(img);
    }
  }
}
