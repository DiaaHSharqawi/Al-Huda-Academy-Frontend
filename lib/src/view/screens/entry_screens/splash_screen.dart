import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/entry_screens_controllers/splash_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';

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
                  SizedBox(
                    width: 400,
                    height: 400,
                    child: _buildImage(),
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
            color: AppColors.primaryColor,
            radius: 20.0,
          )
        : const CircularProgressIndicator(
            color: AppColors.primaryColor,
          );
  }

  Widget _buildImage() {
    return CustomProjectLogo(
      imagePath: AppImages.holyQuranLogo,
      width: 350.0,
      height: 350.0,
      text: SharedLanguageConstants.academyName.tr,
    );
  }
}
