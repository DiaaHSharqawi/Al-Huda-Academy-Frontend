import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import '../../../controllers/splash_controller.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.put(SplashController(10));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.bismillahAlRahmanAlRahimImage),
              const SizedBox(
                height: 15.0,
              ),
              Image.asset(AppImages.splashScreenImage),
              const SizedBox(
                height: 15.0,
              ),
              CustomGoogleTextWidget(
                text: SplashScreenLanguageConstants.academyName.tr,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 50.0,
              ),
              _buildLoader(context),
              const SizedBox(
                height: 30.0,
              ),
              CustomGoogleTextWidget(
                text: SplashScreenLanguageConstants.pageIsLoading.tr,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? const CupertinoActivityIndicator(color: Colors.black, radius: 20.0)
        : const CircularProgressIndicator(color: Colors.black);
  }
}
