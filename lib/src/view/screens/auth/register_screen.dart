import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              key: _formKey,
              child: Obx(() {
                final isArabic = appService.isRtl.value;
                final TextDirection textDirection =
                    isArabic ? TextDirection.rtl : TextDirection.ltr;
                final TextDirection hintTextDirection =
                    isArabic ? TextDirection.ltr : TextDirection.rtl;

                return Column(
                  children: [
                    _buildProfileImagePicker(),
                    _buildTextInputField(
                      "الاسم الكامل",
                      "ادخل اسمك كاملاً",
                      Icons.perm_identity,
                      registerController.fullNameController,
                      AuthValidations.validateFullName,
                      textDirection,
                      hintTextDirection,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildTextInputField(
                      "البريد الالكتروني",
                      "name@example.com",
                      Icons.email,
                      registerController.emailController,
                      AuthValidations.validateEmail,
                      textDirection,
                      hintTextDirection,
                    ),
                    const SizedBox(height: 30.0),
                    _buildTextInputField(
                      "رقم الهاتف",
                      "059 999-9999",
                      Icons.phone_android_outlined,
                      registerController.phoneController,
                      AuthValidations.validatePhoneNumber,
                      textDirection,
                      hintTextDirection,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildResidenceFields(textDirection, hintTextDirection),
                    const SizedBox(
                      height: 42.0,
                    ),
                    _buildGenderSelection(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildAgeField(textDirection, hintTextDirection),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildTextInputField(
                      "كلمة السر",
                      "*******",
                      Icons.lock_outline,
                      registerController.passwordController,
                      AuthValidations.validatePassword,
                      textDirection,
                      hintTextDirection,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildSaveDataButton(context),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveDataButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomAuthTextButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        buttonText: "حفظ البيانات",
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
                "Success",
                message,
              );
              registerController.navigateToLoginScreen();
            } else {
              if (!context.mounted) return;
              await CustomAwesomeDialog.showAwesomeDialog(
                context,
                DialogType.error,
                "Error",
                message,
              );
            }
          } catch (err) {
            if (!context.mounted) return;
            debugPrint(err.toString());
            CustomAwesomeDialog.showAwesomeDialog(
              context,
              DialogType.error,
              "Error",
              err.toString(),
            );
          }
          setState(() {
            _isSubmitting = false;
          });
        },
      ),
    );
  }

  Widget _buildAgeField(
      TextDirection textDirection, TextDirection hintTextDirection) {
    return _buildTextInputField(
      "العمر",
      "ادخل عمرك",
      Icons.calendar_today,
      registerController.ageController,
      AuthValidations.validateAge,
      textDirection,
      hintTextDirection,
    );
  }

  Widget _buildCreateNewAccountText() {
    return const CustomGoogleTextWidget(
      text: "انشاء حساب جديد",
      fontFamily: AppFonts.arabicFont,
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

  Widget _buildResidenceFields(
      TextDirection textFormDirection, TextDirection hintTextDirection) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: CustomGoogleTextWidget(
            text: "مكان الاقامة",
            fontFamily: AppFonts.arabicFont,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          children: [
            Expanded(
              child: CustomAuthTextFormField(
                textFormHintText: "ادخل الدولة",
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
            ),
            const SizedBox(width: 24.0),
            Expanded(
              child: CustomAuthTextFormField(
                textFormHintText: "ادخل المدينة",
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    bool hasError = registerController.selectedGender.value == null;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: hasError ? Colors.red : Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 16.0,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const CustomGoogleTextWidget(
                  text: "ادخل الجنس",
                  fontFamily: AppFonts.arabicFont,
                  fontSize: 16,
                ),
                Obx(
                  () => ChoiceChip(
                    label: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.male, color: Colors.blue),
                        SizedBox(width: 8.0),
                        Text("ذكر"),
                      ],
                    ),
                    selected:
                        registerController.selectedGender.value == Gender.male,
                    onSelected: (isSelected) {
                      if (isSelected) {
                        registerController.selectedGender.value = Gender.male;
                      }
                    },
                    selectedColor: Colors.blue.withOpacity(0.2),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                Obx(
                  () => ChoiceChip(
                    label: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.female, color: Colors.pink),
                        SizedBox(width: 8.0),
                        Text("انثى"),
                      ],
                    ),
                    selected: registerController.selectedGender.value ==
                        Gender.female,
                    onSelected: (isSelected) {
                      if (isSelected) {
                        registerController.selectedGender.value = Gender.female;
                      }
                    },
                    selectedColor: Colors.pink.withOpacity(0.2),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
          if (hasError)
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "الرجاء اختيار الجنس",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
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
