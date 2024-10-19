import 'package:get/get.dart';

class SplashViewModel extends GetxController {
  late int splashScreenDuration;
  SplashViewModel(this.splashScreenDuration);
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
