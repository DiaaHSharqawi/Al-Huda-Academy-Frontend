import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/family_link_controllers/family_link_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/send_child_verification_code_family_link_response.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class EnterYourChildEmailFamilyLinkScreen
    extends GetView<FamilyLinkController> {
  const EnterYourChildEmailFamilyLinkScreen({super.key});

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
                  _buildEmailImage(),
                  const SizedBox(height: 64.0),
                  _buildEnterYourChildEmailHeaderText(),
                  const SizedBox(height: 32.0),
                  _buildEnterYourChildEmailDescription(),
                  const SizedBox(height: 32.0),
                  _buildEmailFormField(),
                  const SizedBox(height: 32.0),
                  _buildEnterYourChildEmailNextButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailImage() {
    return Image.asset(
      'assets/images/email.png',
      width: double.infinity,
      height: 220.0,
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

  Widget _buildEnterYourChildEmailHeaderText() {
    return const CustomGoogleTextWidget(
      text: 'ربط الحسابات - ادخل بريد طفلك',
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildEnterYourChildEmailDescription() {
    return const SizedBox(
      width: double.infinity,
      child: CustomGoogleTextWidget(
        text:
            'يرجى إدخال البريد الإلكتروني الخاص بطفلك لتفعيل حسابه. سيتم إرسال كود خاص إلى البريد الإلكتروني المدخل لإتمام عملية ربط الحسابات.',
        fontSize: 18.0,
        color: Colors.grey,
        textAlign: TextAlign.start,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailFormField() {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: CustomGoogleTextWidget(
            text: 'البريد الإلكتروني',
            fontSize: 18.0,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        CustomAuthTextFormField(
          textFormHintText: "eg example@email.com",
          //  iconName: Icons.email,
          colorIcon: Colors.black,
          controller: controller.childEmailController,
          textFormFieldValidator: AuthValidations.validateEmail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }

  Widget _buildEnterYourChildEmailNextButton(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          width: double.infinity,
          child: CustomButton(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            buttonText: "التالي",
            buttonTextColor: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              // todo : return and edit the correct msg translation later

              SendChildVerificationCodeFamilyLinkResponse? response =
                  await controller.sendChildVerificationCodeFamilyLink();

              if (!context.mounted) return;

              int? statusCode = response?.statusCode;
              String? responseMessage = response?.message;

              if (statusCode == 200) {
                await CustomAwesomeDialog.showAwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'تم إرسال الكود بنجاح',
                  description:
                      'تم إرسال كود التحقق إلى البريد الإلكتروني المدخل بنجاح. يرجى التحقق من البريد الإلكتروني الخاص بطفلك وإدخال الكود لإتمام عملية ربط الحسابات.',
                  btnOkOnPress: () {
                    controller.navigateToEnterYourChildVerificationCodeScreen();
                  },
                  btnCancelOnPress: null,
                );
              } else if (statusCode == 409) {
                await CustomAwesomeDialog.showAwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: 'خطأ',
                  description:
                      responseMessage ?? '  حدث خطأ ما تم ارسال الكود مسبقا',
                  btnOkOnPress: () {
                    controller.navigateToEnterYourChildVerificationCodeScreen();
                  },
                  btnCancelOnPress: null,
                );
              } else {
                CustomAwesomeDialog.showAwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: 'حدث خطأ',
                  description: responseMessage ?? 'حدث خطأ ما',
                  btnOkOnPress: () {},
                  btnCancelOnPress: null,
                );
              }
            },
            loadingWidget: controller.isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : null,
            isEnabled: controller.isEnabled.value,
          ),
        );
      },
    );
  }
}
