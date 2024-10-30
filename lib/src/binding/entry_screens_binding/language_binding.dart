import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/language_controller/language_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}
