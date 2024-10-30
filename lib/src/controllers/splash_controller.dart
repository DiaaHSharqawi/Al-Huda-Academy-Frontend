import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';

class SplashController extends GetxController {
  late int splashScreenDuration;

  SplashController(this.splashScreenDuration);
  @override
  void onInit() {
    super.onInit();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    try {
      await Future.delayed(
        Duration(seconds: splashScreenDuration),
      );
      _navigateToLanguageSelection();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _navigateToLanguageSelection() {
    Get.offNamed(AppRoutes.language);
  }
}
