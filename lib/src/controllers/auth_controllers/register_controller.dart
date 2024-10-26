import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
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
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Rx<Gender?> selectedGender = Rx<Gender?>(Gender.notSelected);

  final RegisterService _registerService;

  RegisterController(this._registerService);

  void setGender(Gender? gender) {
    selectedGender.value = gender;
  }

  void updateProfileImage(Uint8List? img) {
    profileImage = img;
    update();
  }

  Future<String> submitForm() async {
    final err = AuthValidations.validateAll({
      'fullName': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'age': ageController.text,
      'phone': phoneController.text,
      'city': cityController.text,
      'country': countryController.text,
      'gender': selectedGender.value?.name,
    });
    if (err != null) {
      return 'Please make sure to fill all fields!';
    }
    if (profileImage == null) {
      return 'Please make sure to upload your profile image.';
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
      final RegisterResponse registerResponse =
          await _registerService.registerUser(registerData);
      if (registerResponse.success) {
        debugPrint(registerResponse.data.toString());
        return registerResponse.message;
      } else {
        debugPrint(registerResponse.message);
        return registerResponse.message;
      }
    } catch (e) {
      debugPrint(e.toString());

      Get.snackbar('Error', e.toString());
      return e.toString();
    }
  }

  void navigateToLoginScreen() {
    Get.toNamed(AppRoutes.login);
  }
}
