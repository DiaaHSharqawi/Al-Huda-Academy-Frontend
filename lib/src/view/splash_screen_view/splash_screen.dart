import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/splash_view_model.dart';

import '../../constants/images_strings.dart';
import '../../constants/arabic_constants.dart';
import '../../constants/colors_constants.dart';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashViewModel viewModel = Get.put(SplashViewModel(10));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(bismillahAlRahmanAlRahimImage),
            const SizedBox(
              height: 15.0,
            ),
            Image.asset(splashScreenImage),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              alHudaAcademyArabicName,
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
              pageIsLoadingArabic,
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
