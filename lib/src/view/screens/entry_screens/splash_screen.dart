import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/splash_controller.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_colors.dart';

import 'package:google_fonts/google_fonts.dart';

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
              Text(
                "splash_screen.academy_name".tr,
                style: GoogleFonts.getFont(
                  'Cairo',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50.0,
              ),
              _buildLoader(context),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "splash_screen.page_is_loading".tr,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              )
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
