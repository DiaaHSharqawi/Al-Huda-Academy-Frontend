import 'dart:async';
import 'dart:typed_data';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/register_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/Validations.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response/register_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/profile_image.dart';

import 'package:moltqa_al_quran_frontend/src/data/model/enums/role.dart'
    as role_enums;
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/quran_memorizing_amount/quran_memorizing_amount_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/roles/role_response_model.dart';

import 'package:moltqa_al_quran_frontend/src/data/model/gender/gender_response_model.dart';
import '../../data/model/enums/gender.dart' as gender_enum;

class RegisterController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading(true);

      await getGenderList();
      await getRoleList();
      await getQuranMemorizingAmountList();
      await getJuzaList();
    } catch (e) {
      debugPrint("Error initializing lists: $e");
    } finally {
      isLoading(false);
    }
  }

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

  Rx<gender_enum.Gender?> selectedGender =
      Rx<gender_enum.Gender?>(gender_enum.Gender.notSelected);

  Rx<role_enums.Role?> selectedRole =
      Rx<role_enums.Role?>(role_enums.Role.notSelected);

  var selectedRoleId = "".obs;
  var selectedGenderId = "".obs;

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

  final List<Gender> genders = [];

  final List<Role> roles = [];

  final List<Juza> juzas = [];
  var selectedJuzzas = [].obs;

  var selectedStartedJuza = "".obs;
  var selectedEndJuza = "".obs;

  var selectedMemorizingOption = "".obs;

  final List<QuranMemorizingAmount> quranMemorizingAmounts = [];

  var selectedQuranMemorizingAmount = "".obs;
  var selectedQuranMemorizingAmountId = "".obs;

  Future<void> getJuzaList() async {
    var juzas = await _registerService.getJuzaList();
    debugPrint("juzas");
    debugPrint(juzas.toString());
    if (juzas.isNotEmpty) {
      this.juzas.addAll(juzas);
    }
  }

  Future<void> getGenderList() async {
    var gendersResponse = await _registerService.getGenderList();
    debugPrint("gendgendersResponseers");
    debugPrint(gendersResponse.toString());
    if (gendersResponse.isNotEmpty) {
      genders.addAll(gendersResponse);
    }
  }

  Future<void> getRoleList() async {
    var rolesResponse = await _registerService.getRoleList();

    debugPrint("rolesResponse");
    debugPrint(rolesResponse.toString());

    if (rolesResponse.isNotEmpty) {
      roles.addAll(rolesResponse);
    }
  }

  Future<void> getQuranMemorizingAmountList() async {
    var quranMemorizingAmountResponse =
        await _registerService.getQuranMemorizingAmountList();

    debugPrint("quranMemorizingAmountResponse");
    debugPrint(quranMemorizingAmountResponse.toString());

    if (quranMemorizingAmountResponse.isNotEmpty) {
      quranMemorizingAmounts.addAll(quranMemorizingAmountResponse);
    }
  }

  void setGender(gender_enum.Gender? gender) {
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

  Map<String, Object?> validatePersonalDetails() {
    hasInteracted(true);

    isSubmitting(true);
    isLoading(true);

    debugPrint("Validating personal details");
    debugPrint(": ${dateTimeController.selectedDate.toString()}");

    final errors = AuthValidations.validateAll({
      'fullName': fullNameController.text,
      'city': cityController.text,
      'country': countryController.text,
      'phone': phoneController.text,
      'birthDate': dateTimeController.selectedDate.toString(),
    });

    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");

      isLoading(false);

      return {
        'status': false,
        'message': errors.values.join(', ').toString(),
      };
    }
    if (dateTimeController.selectedDate == null) {
      debugPrint("Please select your birth date");
      isLoading(false);
      return <String, Object>{
        'status': false,
        'message': 'الرجاء اختيار تاريخ ميلاد',
      };
    }

    isSubmitting(false);
    isLoading(false);
    return {
      'status': true,
      'message': 'البيانات صحيحة',
      'errors': null,
    };
  }

  Map<String, Object> validateQualifications() {
    isSubmitting(true);
    isLoading(true);

    debugPrint("Validating qualifications");
    debugPrint("Surahs: ${surahsController.text}");
    debugPrint("Parts: ${partsController.text}");
    debugPrint("Details: ${anyDetailsController.text}");
    debugPrint(
        "Selected Quran memorizing amount: $selectedQuranMemorizingAmountId");

    if (selectedMemorizingOption.value == "") {
      isLoading(false);
      return {
        'status': false,
        'message': 'يرجى اختيار الاجزاء التي تحفظها',
      };
    }

    if (selectedMemorizingOption.value == "parts" && selectedJuzzas.isEmpty) {
      isLoading(false);
      return {
        'status': false,
        'message': 'يرجى تحديد الاجزاء المحددة التي تحفظها',
      };
    }
    final role = selectedRole.value;
    final roleValidationMessages = {
      role_enums.Role.participant: 'الرجاء الموافقة على الشروط للمشارك',
      role_enums.Role.supervisor: 'الرجاء الموافقة على الشروط للمشرف',
    };

    if (role == role_enums.Role.participant && !confirmations[0]) {
      isLoading(false);
      return {
        'status': false,
        'message': roleValidationMessages[role_enums.Role.participant] ??
            'Default message',
      };
    }

    if (role == role_enums.Role.supervisor &&
        confirmations.any((confirmation) => !confirmation)) {
      isLoading(false);
      return {
        'status': false,
        'message': roleValidationMessages[role_enums.Role.supervisor] ??
            'Default message',
      };
    }

    if (role == role_enums.Role.supervisor && certificateImages.isEmpty) {
      isLoading(false);
      return {
        'status': false,
        'message': 'الرجاء تحميل صور الشهادة او الشهادات',
      };
    }

    final errors = Validations.validateAll({
      anyDetailsController.text != "" ? 'details' : anyDetailsController.text:
          null,
      selectedRole.value == role_enums.Role.participant
          ? 'selectedQuranMemorizingAmountId'
          : selectedQuranMemorizingAmountId.value: null,
    });
    debugPrint("Errors: $errors");
    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");
      isLoading(false);
      return {
        'status': false,
        'message': errors.values.join(', ').toString(),
      };
    }

    isSubmitting(false);
    isLoading(false);

    return {
      'status': true,
      'message': 'البيانات صحيحة',
      'errors': {},
    };
  }

  Future<Map<String, Object>> validateCredentials() async {
    debugPrint("Validating credentials");
    isSubmitting(true);
    isLoading(true);

    final errors = AuthValidations.validateAll({
      'email': emailController.text,
      'password': passwordController.text,
    });

    debugPrint("Errors: $errors");

    if (errors != null) {
      debugPrint("Errors: ${errors.values.join(', ').toString()}");
      isLoading(false);
      return {
        'status': false,
        'statusCode': 422,
        'message': errors.values.join(', ').toString(),
      };
    }
    try {
      final userExist =
          await _registerService.isUserExist(emailController.text);
      debugPrint("Value: $userExist");
      if ((userExist as Map<String, dynamic>)['success'] == true) {
        debugPrint("User already exists");

        isLoading(false);

        return {
          'statusCode': userExist['statusCode'],
          'status': false,
          'message': 'البريد الإلكتروني موجود بالفعل',
        };
      }

      isSubmitting(false);
      isLoading(false);
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
      isLoading(false);
    }
  }

  Future<Object> registerParticipant() async {
    isLoading(true);

    final Map<String, Object> credentialsValidation =
        await validateCredentials();
    if (!(credentialsValidation['status'] as bool)) {
      isLoading(false);

      return RegisterResponse(
        statusCode: credentialsValidation['statusCode'] as int,
        success: false,
        message: credentialsValidation['message'] as String,
        data: null,
      );
    }

    final personalDetailsValidation = validatePersonalDetails();
    if (!(personalDetailsValidation['status'] as bool)) {
      isLoading(false);

      return {
        'statusCode': 422,
        'success': false,
        'message': personalDetailsValidation['message'] as String,
        'data': null,
      };
    }

    final qualificationsValidation = validateQualifications();
    if (!(qualificationsValidation['status'] as bool)) {
      isLoading(false);

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

    Object response = await _registerService.registerParticipant({
      'fullName': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'city': cityController.text,
      'country': countryController.text,
      'gender_id': selectedGenderId.value,
      'dateOfBirth':
          dateTimeController.selectedDate?.toIso8601String().split('T').first,
      'details': anyDetailsController.text,
      'certificateImages': certificateImages,
      'profileImage': profileImage.value,
      'quranMemorizingAmountsId': selectedQuranMemorizingAmountId.value,
      'selectedMemorizingOption': selectedMemorizingOption.value,
      "juza_ids": selectedMemorizingOption.value == "parts"
          ? selectedJuzzas.map((juza) => int.parse(juza.id.toString())).toList()
          : null,
    });

    debugPrint("Response: $response");
    debugPrint("Response: ${response.runtimeType}");
    debugPrint(response.toString());

    isLoading(false);

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

    isLoading(true);

    Object response = await _registerService.registerSupervisor({
      'fullName': fullNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'city': cityController.text,
      'country': countryController.text,
      'gender_id': selectedGenderId.value,
      'dateOfBirth':
          dateTimeController.selectedDate?.toIso8601String().split('T').first,
      'details': anyDetailsController.text,
      'certificatesImages': certificateImages,
      'profileImage': profileImage.value,
      'selectedMemorizingOption': selectedMemorizingOption.value,
      "juza_ids": selectedMemorizingOption.value == "parts"
          ? selectedJuzzas.map((juza) => int.parse(juza.id.toString())).toList()
          : null,
    });
    debugPrint("Response: $response");
    debugPrint("Response: ${response.runtimeType}");
    debugPrint(response.toString());

    isLoading(false);
    return response;
  }

  void addCertificateImage(Uint8List image) {
    certificateImages.add(image);
  }

  void removeCertificateImage(Uint8List image) {
    certificateImages.remove(image);
  }

  void navigateToLoginScreen() {
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
