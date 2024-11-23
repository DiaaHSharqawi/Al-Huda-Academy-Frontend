import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/family_link_controllers/family_link_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class DoesYourChildHaveAccountAddParticipantFamilyLinkScreen
    extends GetView<FamilyLinkController> {
  const DoesYourChildHaveAccountAddParticipantFamilyLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildDoseYourChildHaveAccountAddParticipantFamilyLinkHeader(),
                  const SizedBox(height: 16.0),
                  _buildDoseYourChildHaveAccountAddParticipantFamilyLinkImage(),
                  const SizedBox(height: 16.0),
                  _buildDoseYourChildHaveAccountAddParticipantFamilyLinkYesButton(),
                  const SizedBox(height: 32.0),
                  _buildDoseYourChildHaveAccountAddParticipantFamilyLinkNoButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoseYourChildHaveAccountAddParticipantFamilyLinkHeader() {
    return const SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: CustomGoogleTextWidget(
          text: 'هل لديك طفل لديه حساب على منصتنا؟',
          fontSize: 22.0,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDoseYourChildHaveAccountAddParticipantFamilyLinkImage() {
    return Image.asset(
      'assets/images/muslim_girl.png',
      width: double.infinity,
      height: 400.0,
    );
  }

  Widget _buildDoseYourChildHaveAccountAddParticipantFamilyLinkYesButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor.withOpacity(0.9),
        buttonText: "نعم",
        buttonTextColor: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        onPressed: () {
          controller.navigateToEnterYourChildEmailScreen();
        },
      ),
    );
  }

  Widget _buildDoseYourChildHaveAccountAddParticipantFamilyLinkNoButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor.withOpacity(0.9),
        buttonText: "لا",
        buttonTextColor: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        onPressed: () {},
      ),
    );
  }
}
