import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/register_service.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterService>(() => RegisterService());
    Get.lazyPut<RegisterController>(
        () => RegisterController(Get.find<RegisterService>()));
  }
}
