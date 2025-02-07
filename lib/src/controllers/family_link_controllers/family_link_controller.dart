import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/family_link/family_link_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/get_childs_by_parent_id_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/send_child_verification_code_family_link_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/verify_child_verification_code_family_link_response.dart';

class FamilyLinkController extends GetxController {
  var appService = Get.find<AppService>();

  var isLoading = false.obs;
  var isEnabled = true.obs;

  final FamilyLinkService _familyLinkService;
  FamilyLinkController(this._familyLinkService);

  TextEditingController childEmailController = TextEditingController();

  TextEditingController verificationCodeController = TextEditingController();

  var familyLinks = <Object>[].obs;
  void navigateToDoesYourChildHaveAccountScreen() {
    Get.toNamed('/family-link/does-your-child-have-account');
  }

  void navigateToEnterYourChildEmailScreen() {
    Get.toNamed('/family-link/enter-your-child-email');
  }

  void navigateToEnterYourChildVerificationCodeScreen() {
    Get.toNamed(AppRoutes.enterYourChildVerificationCodeFamilyLink);
  }

  void navigateToFamilyLinksDashboardScreen() {
    Get.toNamed(AppRoutes.familyLink);
  }

  void navigateToChildAccountLinkedSuccessfullyScreen() {
    Get.toNamed(AppRoutes.childAccountLinkedSuccessfullyScreen);
  }

  void navigateToHomeScreen() {
    Get.toNamed(AppRoutes.home);
  }

  Future<SendChildVerificationCodeFamilyLinkResponse?>
      sendChildVerificationCodeFamilyLink() async {
    final SendChildVerificationCodeFamilyLinkResponse? response;

    debugPrint(childEmailController.text.runtimeType.toString());

    final error = AuthValidations.validateAll({
      'email': childEmailController.text,
    });

    if (error != null) {
      response = SendChildVerificationCodeFamilyLinkResponse(
        statusCode: 422,
        success: false,
        message: 'الرجاء إدخال بريد إلكتروني صحيح',
      );
      return response;
    } else {
      String childEmail = childEmailController.text;
      try {
        isLoading(true);
        isEnabled(false);

        final senderUserEmail =
            (await appService.getDecodedToken())?['UserInfo']['email'] ??
                'No_User_Email';

        response = await _familyLinkService.sendChildVerificationCodeFamilyLink(
          senderUserEmail,
          childEmail,
        );
        return response;
      } catch (e) {
        debugPrint('Error sending child verification code: $e');
        return SendChildVerificationCodeFamilyLinkResponse(
          statusCode: 500,
          success: false,
          message: 'حدث خطأ ما، الرجاء المحاولة مرة أخرى',
        );
      } finally {
        isLoading(false);
        isEnabled(true);
      }
    }
  }

  Future<VerifyChildVerificationCodeFamilyLinkResponse?>
      verifyChildVerificationCodeFamilyLink() async {
    debugPrint('verifyChildVerificationCodeFamilyLink');
    debugPrint(
        'email: ${childEmailController.text}, verificationCode: ${verificationCodeController.text}');

    final error = AuthValidations.validateAll({
      'email': childEmailController.text,
      'verificationCode': verificationCodeController.text,
    });

    if (error != null) {
      return VerifyChildVerificationCodeFamilyLinkResponse(
        statusCode: 422,
        success: false,
        message: 'الرجاء إدخال رمز تحقق صحيح',
      );
    }

    try {
      isLoading(true);
      isEnabled(false);

      final senderUserEmail = (await appService.getDecodedToken())?['UserInfo']
              ['email'] ??
          'No_User_Email';
      debugPrint('senderUserEmail: $senderUserEmail');

      final response =
          await _familyLinkService.verifyChildVerificationCodeFamilyLink(
        senderUserEmail,
        childEmailController.text,
        verificationCodeController.text,
      );
      return response;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint('Error verifying child verification code: $error');
      return VerifyChildVerificationCodeFamilyLinkResponse(
        statusCode: 500,
        success: false,
        message: 'حدث خطأ ما، الرجاء المحاولة مرة أخرى',
      );
    } finally {
      isLoading(false);
      isEnabled(true);
    }
  }

  Future<GetChildsByUserIdResponse?> getChildrenByParentEmail() async {
    try {
      final parentEmail = (await appService.getDecodedToken())?['UserInfo']
              ['email'] ??
          'No_User_Email';
      debugPrint('parentEmail: $parentEmail');

      debugPrint('getChildrenByParentEmail');
      final error = AuthValidations.validateAll({
        'email': parentEmail.toString(),
      });
      if (error != null) {
        return GetChildsByUserIdResponse(
          statusCode: 422,
          success: false,
          message: 'حدث خطأ ما',
          familyLink: null,
        );
      }

      isLoading(true);

      final GetChildsByUserIdResponse response = await _familyLinkService
          .getChildrenByParentEmail(parentEmail.toString());
      debugPrint('Response: $response.toString()');

      return response;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint('Error getting children by parent id: $error');
      return GetChildsByUserIdResponse(
        statusCode: 500,
        success: false,
        message: 'حدث خطأ ما',
        familyLink: null,
      );
    } finally {
      isLoading(false);
    }
  }
}
