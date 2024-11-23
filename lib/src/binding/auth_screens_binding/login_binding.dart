import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
