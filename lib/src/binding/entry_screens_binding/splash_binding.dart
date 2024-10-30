import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  final _splachScreenDuartion = 5;
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
        () => SplashController(_splachScreenDuartion));
  }
}
