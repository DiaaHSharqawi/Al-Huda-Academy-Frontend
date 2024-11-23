import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/family_link_controllers/family_link_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class ChildAccountLinkedSuccessfullyScreen
    extends GetView<FamilyLinkController> {
  const ChildAccountLinkedSuccessfullyScreen({super.key});
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
                  _buildChildAccountLinkedSuccessfullyImage(),
                  const SizedBox(height: 20.0),
                  _buildChildAccountLinkedSuccessfullyText(),
                  const SizedBox(height: 64.0),
                  _buildBackToHomwPageButton(),
                ],
              ),
            ),
          ),
        ),
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

  Widget _buildChildAccountLinkedSuccessfullyText() {
    return const Row(
      children: [
        CustomGoogleTextWidget(
          text: 'تم ربط حساب طفلك بنجاح',
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(width: 8.0),
        Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 48.0,
        ),
      ],
    );
  }

  Widget _buildChildAccountLinkedSuccessfullyImage() {
    return Image.asset(
      'assets/images/daughter.png',
      width: double.infinity,
      height: 450.0,
    );
  }

  Widget _buildBackToHomwPageButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        buttonText: "العودة إلى الصفحة الرئيسية",
        buttonTextColor: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        onPressed: () {
          controller.navigateToFamilyLinksDashboardScreen();
        },
      ),
    );
  }
}
