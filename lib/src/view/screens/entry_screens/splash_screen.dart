import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import '../../../controllers/splash_controller.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.find();

  static const double imageSize = 350.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildImage(),
                  SizedBox(
                    height: 64.0,
                    child: _buildAcademyNameText(),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: _buildLoader(
                      context,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? const CupertinoActivityIndicator(
            color: Colors.black,
            radius: 20.0,
          )
        : const CircularProgressIndicator(
            color: Colors.black,
          );
  }

  Widget _buildImage() {
    return const CustomProjectLogo(
      imagePath: AppImages.holyQuranLogo,
      width: 350.0,
      height: 350.0,
    );
  }

  Widget _buildAcademyNameText() {
    return Container(
      height: 24.0,
      alignment: Alignment.center,
      child: CustomGoogleTextWidget(
        fontSize: 24.0,
        color: Colors.black,
        textAlign: TextAlign.center,
        text: SplashScreenLanguageConstants.academyName.tr,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
