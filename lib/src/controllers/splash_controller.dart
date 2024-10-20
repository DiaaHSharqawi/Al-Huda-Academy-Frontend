import 'package:get/get.dart';

class SplashController extends GetxController {
  late int splashScreenDuration;

  SplashController(this.splashScreenDuration);
  @override
  void onInit() {
    super.onInit();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(
      Duration(seconds: splashScreenDuration),
    );
    _navigateToLanguageSelection();
  }

  void _navigateToLanguageSelection() {
    Get.offNamed('/language');
  }
}
