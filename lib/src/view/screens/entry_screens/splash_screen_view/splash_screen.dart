import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/splash_controller.dart';

import '../../../../core/constants/app_images.dart';
import './../../../../core/constants/arabic_constants.dart';
import '../../../../core/constants/app_colors.dart';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController splashController = Get.put(SplashController(10));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Center(
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
              ArabicConstants.alHudaAcademyArabicName,
              style: GoogleFonts.getFont('Almarai',
                  fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50.0,
            ),
            if (defaultTargetPlatform == TargetPlatform.iOS)
              const CupertinoActivityIndicator(
                color: Colors.black,
                radius: 20.0,
              )
            else
              const CircularProgressIndicator(
                color: Colors.black,
              ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              ArabicConstants.pageIsLoadingArabic,
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
