import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(4));
  }
}
