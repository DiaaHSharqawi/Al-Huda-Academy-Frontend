import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
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
  Uint8List? _img;

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
                    SizedBox(
                      width: double.infinity,
                      child: CustomAuthTextButton(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        buttonText: "حفظ البيانات",
                        buttonTextColor: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        onPressed: _submitForm,
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textFormDirection: textFormDirection,
          obscureText: obscureText,
        ),
      ],
    );
  }

  Widget _buildResidenceFields(
      TextDirection textFormDirection, TextDirection hintTextDirection) {
    return Row(
      children: [
        Expanded(
          child: _buildTextInputField(
              "الدولة",
              "ادخل الدولة",
              Icons.home,
              registerController.countryController,
              AuthValidations.validateCountry,
              textFormDirection,
              hintTextDirection),
        ),
        const SizedBox(width: 24.0),
        Expanded(
          child: _buildTextInputField(
              "المدينة",
              "ادخل المدينة",
              Icons.home,
              registerController.cityController,
              AuthValidations.validateCity,
              textFormDirection,
              hintTextDirection),
        ),
      ],
    );
  }

  // ignore: unused_element
  Widget _buildProfileImagePicker() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 64.0,
          backgroundImage: _img != null
              ? MemoryImage(_img!)
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
    setState(() {
      _img = img;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
    }
  }
}
