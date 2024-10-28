import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/send_password_reset_code_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/send_password_reset_code_service.dart';

class SendPasswordResetCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendPasswordResetCodeService>(
        () => SendPasswordResetCodeService());
    Get.lazyPut<SendPasswordResetCodeController>(() =>
        SendPasswordResetCodeController(
            Get.find<SendPasswordResetCodeService>()));
  }
}
