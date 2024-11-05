import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/register_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/register_model.dart';

class RegisterController extends GetxController {
  Uint8List? profileImage;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Rx<Gender?> selectedGender = Rx<Gender?>(Gender.notSelected);

  final RegisterService _registerService;

  RegisterController(this._registerService);

  var isLoading = false.obs;

  var isSubmitting = false.obs;
  var hasInteracted = false.obs;
  var isEnabled = true.obs;

  var isObscureText = true.obs;

  void setGender(Gender? gender) {
    selectedGender.value = gender;
  }

  void updateProfileImage(Uint8List? img) {
    profileImage = img;
    update();
  }

  Future<RegisterResponse> registerUser() async {
    final error = AuthValidations.validateAll({
      'fullName': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'age': ageController.text,
      'phone': phoneController.text,
      'city': cityController.text,
      'country': countryController.text,
      'gender': selectedGender.value?.name,
    });
    RegisterResponse? registerResponse;
    if (error != null) {
      registerResponse = RegisterResponse(
        statusCode: 422,
        success: false,
        message:
            RegisterScreenLanguageConstants.pleaseMakeSureToFillAllFields.tr,
        user: null,
        accessToken: null,
        refreshToken: null,
      );
      return registerResponse;
    }
    if (profileImage == null) {
      registerResponse = RegisterResponse(
        statusCode: 400,
        success: false,
        message: RegisterScreenLanguageConstants
            .pleaseMakeSureToUploadYourProfileImage.tr,
        user: null,
        accessToken: null,
        refreshToken: null,
      );

      return registerResponse;
    }

    final genderString = selectedGender.value?.name ?? '';

    final registerData = RegisterModel(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
      city: cityController.text,
      country: countryController.text,
      gender: genderString,
      age: ageController.text,
      profileImage: profileImage,
    );

    try {
      isLoading(true);
      final RegisterResponse registerResponse =
          await _registerService.registerUser(registerData);

      return registerResponse;
    } catch (e) {
      debugPrint(e.toString());
      return RegisterResponse(
        statusCode: 500,
        success: false,
        message: "An error occurred while registering. Please try again.",
        user: null,
        accessToken: null,
        refreshToken: null,
      );
    } finally {
      isLoading(false);
    }
  }

  void navigateToLoginScreen() {
    // TODO : 1. Make it later Navigate to Home screen,
    Get.offAllNamed(AppRoutes.login);
  }
}
