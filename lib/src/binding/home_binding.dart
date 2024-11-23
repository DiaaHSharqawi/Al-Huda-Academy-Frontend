import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
