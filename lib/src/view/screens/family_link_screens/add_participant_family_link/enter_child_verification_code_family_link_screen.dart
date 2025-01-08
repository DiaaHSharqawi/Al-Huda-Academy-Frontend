import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/family_link_controllers/family_link_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/verify_child_verification_code_family_link_response.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_otp_verification_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class EnterChildVerificationCodeFamilyLinkScreen
    extends GetView<FamilyLinkController> {
  const EnterChildVerificationCodeFamilyLinkScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: _buildAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildEnterChildVerificationCodeHeader(),
                  const SizedBox(height: 48.0),
                  _buildEnterChildVerificationCodeImage(),
                  const SizedBox(height: 64.0),
                  _buildEnterChildVerificationCodeDescription(),
                  const SizedBox(height: 32.0),
                  _buildEnterChildVerificationCodeField(),
                  const SizedBox(height: 48.0),
                  _buildEnterChildVerificationCodeButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnterChildVerificationCodeField() {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: CustomGoogleTextWidget(
            text: 'رمز التحقق',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 16.0),
        OTPVerificationField(
          controller: controller.verificationCodeController,
          onComplete: (code) {
            controller.verificationCodeController.text = code;
          },
        )
      ],
    );
  }

  Widget _buildEnterChildVerificationCodeHeader() {
    return const CustomGoogleTextWidget(
      text: 'ربط الحسابات - ادخل رمز التحقق',
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildEnterChildVerificationCodeImage() {
    return Image.asset(
      'assets/images/verification_code.png',
      width: double.infinity,
      height: 220.0,
    );
  }

  Widget _buildEnterChildVerificationCodeDescription() {
    return const SizedBox(
      width: double.infinity,
      child: CustomGoogleTextWidget(
        text:
            'يرجى إدخال رمز التحقق الذي تم إرساله إلى بريد طفلك لاكمال عملية ربط الحساب . ',
        fontSize: 22.0,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildEnterChildVerificationCodeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        buttonText: "تحقق من الرمز",
        buttonTextColor: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        onPressed: () async {
          VerifyChildVerificationCodeFamilyLinkResponse? responseResult =
              await controller.verifyChildVerificationCodeFamilyLink();

          debugPrint('+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-');
          if (responseResult?.statusCode == 200) {
            controller.navigateToChildAccountLinkedSuccessfullyScreen();
          } else {
            if (!context.mounted) return;
            CustomAwesomeDialog.showAwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: 'خطأ',
              description: responseResult?.message ?? 'حدث خطأ ما',
              btnOkOnPress: () {},
              btnCancelOnPress: null,
            );
          }
        },
        isEnabled: controller.isEnabled.value,
        loadingWidget: controller.isLoading.value
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return const CustomAppBar(
      showBackArrow: true,
      arrowColor: Colors.black,
      preferredSize: Size.fromHeight(50),
      appBarChilds: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
      appBarBackgroundImage: null,
      backgroundColor: Colors.white,
      child: SizedBox.expand(),
    );
  }
}
