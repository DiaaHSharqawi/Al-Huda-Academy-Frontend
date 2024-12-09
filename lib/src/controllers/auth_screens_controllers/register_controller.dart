import 'dart:async';
import 'dart:typed_data';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/register_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/Validations.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response/register_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/gender.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/profile_image.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/role.dart';

class RegisterController extends GetxController {
  // Uint8List? profileImage;
  var confirmations = RxList<bool>([
    false,
    false,
  ]);
  var profileImage = Rx<Uint8List?>(null);

  var certificateImages = <Uint8List>[].obs;

  final BoardDateTimeTextController dateTimeController =
      BoardDateTimeTextController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final TextEditingController surahsController = TextEditingController();
  final TextEditingController partsController = TextEditingController();
  final TextEditingController anyDetailsController = TextEditingController();

  Rx<Gender?> selectedGender = Rx<Gender?>(Gender.notSelected);
  Rx<Role?> selectedRole = Rx<Role?>(Role.notSelected);
  Rx<ProfileImage?> selectedProfileImage =
      Rx<ProfileImage?>(ProfileImage.notSelected);

  final RegisterService _registerService;

  RegisterController(this._registerService);

  var isLoading = false.obs;

  var isSubmitting = false.obs;
  var hasInteracted = false.obs;
  var isEnabled = true.obs;

  var isObscureText = true.obs;

  var isProfileImageSelected = false.obs;

  void setGender(Gender? gender) {
    selectedGender.value = gender;
  }

  void updateProfileImage(Uint8List? img) {
    profileImage.value = img;
    update();
  }

  void updateCertificateImage(Uint8List? img) {
    certificateImages.add(img!);
    update();
  }

  Future<RegisterResponse> registerUser() async {
    final error = AuthValidations.validateAll({
      'fullName': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      //'age': ageController.text,
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
        data: null,
      );
      return registerResponse;
    }
    if (profileImage.value == null) {
      registerResponse = RegisterResponse(
        statusCode: 400,
        success: false,
        message: RegisterScreenLanguageConstants
            .pleaseMakeSureToUploadYourProfileImage.tr,
        data: null,
      );

      return registerResponse;
    }

    final genderString = selectedGender.value?.name ?? '';

    /*final registerData = RegisterModel(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
      city: cityController.text,
      country: countryController.text,
      gender: genderString,
      age: ageController.text,
      profileImage: profileImage.value,
    );*/

    try {
      isLoading(true);
      //final RegisterResponse registerResponse =
      //     await _registerService.registerUser(registerData);
      //debugPrint("---> Register response: ${registerResponse.toString()}");
      return RegisterResponse(
          statusCode: 200, success: true, message: "message", data: null);
    } catch (e) {
      debugPrint(e.toString());
      return RegisterResponse(
        statusCode: 500,
        success: false,
        message: "An error occurred while registering. Please try again.",
        data: null,
      );
    } finally {
      isLoading(false);
    }
  }

  Map<String, Object?> validatePersonalDetails() {
    hasInteracted(true);
    debugPrint("Validating personal details");
    debugPrint(": ${dateTimeController.selectedDate.toString()}");

    if (dateTimeController.selectedDate == null) {
      debugPrint("Please select your birth date");
      return <String, Object>{
        'status': false,
        'message': 'الرجاء اختيار تاريخ ميلاد',
      };
    }

    final errors = AuthValidations.validateAll({
      'fullName': fullNameController.text,
      'city': cityController.text,
      'country': countryController.text,
      'phone': phoneController.text,
      'birthDate': dateTimeController.selectedDate.toString(),
    });

    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");
      return {
        'status': false,
        'message': 'الرجاء التأكد من صحة البيانات',
      };
    }

    return {
      'status': true,
      'message': 'البيانات صحيحة',
      'errors': null,
    };
  }

  Map<String, Object> validateQualifications() {
    isSubmitting(true);
    debugPrint("Validating qualifications");
    debugPrint("Surahs: ${surahsController.text}");
    debugPrint("Parts: ${partsController.text}");

    final role = selectedRole.value;
    final roleValidationMessages = {
      Role.participant: 'الرجاء الموافقة على الشروط للمشارك',
      Role.supervisor: 'الرجاء الموافقة على الشروط للمشرف',
    };

    if (role == Role.participant && !confirmations[0]) {
      return {
        'status': false,
        'message':
            roleValidationMessages[Role.participant] ?? 'Default message',
      };
    }

    if (role == Role.supervisor &&
        confirmations.any((confirmation) => !confirmation)) {
      return {
        'status': false,
        'message': roleValidationMessages[Role.supervisor] ?? 'Default message',
      };
    }

    if (role == Role.supervisor && certificateImages.isEmpty) {
      return {
        'status': false,
        'message': 'الرجاء تحميل صور الشهادة او الشهادات',
      };
    }

    final errors = Validations.validateAll({
      'suurahsMemorized': surahsController.text,
      'partsMemorized': partsController.text,
      'details': anyDetailsController.text,
    });
    debugPrint("Errors: $errors");
    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");
      return {
        'status': false,
        'message': 'الرجاء التأكد من صحة البيانات',
      };
    }
    return {
      'status': true,
      'message': 'البيانات صحيحة',
      'errors': {},
    };
  }

  Future<Map<String, Object>> validateCredentials() async {
    debugPrint("Validating credentials");
    isSubmitting(true);

    final errors = AuthValidations.validateAll({
      'email': emailController.text,
      'password': passwordController.text,
    });

    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");
      return {
        'status': false,
        'statusCode': 422,
        'message': 'الرجاء التأكد من صحة البيانات',
      };
    }
    try {
      final userExist =
          await _registerService.isUserExist(emailController.text);
      debugPrint("Value: $userExist");
      if ((userExist as Map<String, dynamic>)['success'] == true) {
        debugPrint("User already exists");
        return {
          'statusCode': userExist['statusCode'],
          'status': false,
          'message': 'البريد الإلكتروني موجود بالفعل',
        };
      }

      return {
        'status': true,
        'statusCode': 404,
        'message': 'البيانات صحيحة',
      };
    } catch (e) {
      debugPrint("Error checking user existence: $e");
      return {
        'status': false,
        'message': 'حدث خطأ أثناء التحقق من وجود المستخدم. حاول مرة اخرى.',
      };
    } finally {
      isSubmitting(false);
    }
  }

  Future<Object> registerParticipant() async {
    final Map<String, Object> credentialsValidation =
        await validateCredentials();
    if (!(credentialsValidation['status'] as bool)) {
      return RegisterResponse(
        statusCode: credentialsValidation['statusCode'] as int,
        success: false,
        message: credentialsValidation['message'] as String,
        data: null,
      );
    }

    final personalDetailsValidation = validatePersonalDetails();
    if (!(personalDetailsValidation['status'] as bool)) {
      return {
        'statusCode': 422,
        'success': false,
        'message': personalDetailsValidation['message'] as String,
        'data': null,
      };
    }

    final qualificationsValidation = validateQualifications();
    if (!(qualificationsValidation['status'] as bool)) {
      return {
        'statusCode': 422,
        'success': false,
        'message': qualificationsValidation['message'] as String,
        'data': null,
      };
    }
    debugPrint("Registering participant");
    debugPrint(
      dateTimeController.selectedDate?.toIso8601String().split('T').first,
    );

    Object response = _registerService.registerParticipant({
      'fullName': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'city': cityController.text,
      'country': countryController.text,
      'gender': selectedGender.value!.name,
      'dateOfBirth':
          dateTimeController.selectedDate?.toIso8601String().split('T').first,
      'numberOfMemorizedSurahs': surahsController.text,
      'numberOfMemorizedParts': partsController.text,
      'details': anyDetailsController.text,
      'role': selectedRole.value!.name,
      'certificateImages': certificateImages,
      'profileImage': profileImage.value,
    });
    debugPrint("Response: $response");
    debugPrint("Response: ${response.runtimeType}");
    debugPrint(response.toString());
    return response;
  }

  Future<Object> registerSupervisor() async {
    final Map<String, Object> credentialsValidation =
        await validateCredentials();

    if (!(credentialsValidation['status'] as bool)) {
      return RegisterResponse(
        statusCode: credentialsValidation['statusCode'] as int,
        success: false,
        message: credentialsValidation['message'] as String,
        data: null,
      );
    }

    final personalDetailsValidation = validatePersonalDetails();

    if (!(personalDetailsValidation['status'] as bool)) {
      return {
        'statusCode': 422,
        'success': false,
        'message': personalDetailsValidation['message'] as String,
        'data': null,
      };
    }

    final qualificationsValidation = validateQualifications();

    if (!(qualificationsValidation['status'] as bool)) {
      return {
        'statusCode': 422,
        'success': false,
        'message': qualificationsValidation['message'] as String,
        'data': null,
      };
    }

    debugPrint("Registering supervisor");
    debugPrint(certificateImages.length.toString());

    Object response = _registerService.registerSupervisor({
      'fullName': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'city': cityController.text,
      'country': countryController.text,
      'gender': selectedGender.value!.name,
      'dateOfBirth':
          dateTimeController.selectedDate?.toIso8601String().split('T').first,
      'numberOfMemorizedSurahs': surahsController.text,
      'numberOfMemorizedParts': partsController.text,
      'details': anyDetailsController.text,
      'role': selectedRole.value!.name,
      'certificatesImages': certificateImages,
      'profileImage': profileImage.value,
    });
    debugPrint("Response: $response");
    debugPrint("Response: ${response.runtimeType}");
    debugPrint(response.toString());
    return response;
  }

  void addCertificateImage(Uint8List image) {
    certificateImages.add(image);
  }

  void removeCertificateImage(Uint8List image) {
    certificateImages.remove(image);
  }

  void navigateToLoginScreen() {
    // TODO : 1. Make it later Navigate to Home screen,
    Get.offAllNamed(AppRoutes.login);
  }

  void navigateToPersonalDetailsScreen() {
    Get.toNamed(AppRoutes.personalDetailsRegister);
  }

  void navigateToQualificationsScreen() {
    debugPrint("Navigating to qualifications screen");
    Get.toNamed(AppRoutes.qualificationsRegister);
  }

  void navigateToCredentialScreen() {
    Get.toNamed(AppRoutes.credentialDetailsRegister);
  }

  void navigateToGenderSelectionScreen() {
    Get.toNamed(AppRoutes.genderSelectionRegister);
  }

  void navigateToSelectProfileImageScreen() {
    Get.toNamed(AppRoutes.selectProfileImageRegister);
  }
}
