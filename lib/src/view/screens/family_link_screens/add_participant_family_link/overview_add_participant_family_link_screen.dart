import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/family_link_controllers/family_link_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class OverviewAddParticipantFamilyLinkScreen
    extends GetView<FamilyLinkController> {
  const OverviewAddParticipantFamilyLinkScreen({super.key});

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
                  _buildOverviewAddParticipantFamilyLinkHeader(),
                  const SizedBox(height: 16.0),
                  _buildOverviewAddParticipantFamilyLinkDescription(),
                  const SizedBox(height: 16.0),
                  _buildOverviewAddParticipantFamilyLinkImage(),
                  _buildOverviewAddParticipantFamilyLinkButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewAddParticipantFamilyLinkHeader() {
    return const SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: CustomGoogleTextWidget(
          text: 'ربط حسابك بحساب ابن/ابنة جديد',
          fontSize: 24.0,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOverviewAddParticipantFamilyLinkImage() {
    return Image.asset(
      'assets/images/islamic_family1.png',
      width: double.infinity,
      height: 400.0,
    );
  }

  Widget _buildOverviewAddParticipantFamilyLinkDescription() {
    return const SizedBox(
      width: double.infinity,
      child: CustomGoogleTextWidget(
        text:
            'يمكنك إضافة أطفالك لمتابعة تقدمهم في حفظ القرآن الكريم. بمجرد إضافة الطفل، يمكنك متابعة تطوره بشكل دوري في رحلته مع الحفظ والمراجعة، مما يسهل عليك تقديم الدعم والتوجيه اللازم.',
        fontSize: 18.0,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildOverviewAddParticipantFamilyLinkButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: AppColors.primaryBackgroundColor,
        backgroundColor: AppColors.primaryColor.withOpacity(0.9),
        buttonText: "استمر",
        buttonTextColor: AppColors.primaryBackgroundColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        onPressed: () {
          controller.navigateToDoesYourChildHaveAccountScreen();
          //controller.getChildrenByParentEmail();
        },
      ),
    );
  }
}
