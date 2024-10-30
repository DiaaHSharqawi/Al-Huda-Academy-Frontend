import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_controllers/reset_password_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/auth/reset_password_service.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordService>(
      () => ResetPasswordService(),
      fenix: true,
    );

    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(
        Get.find<ResetPasswordService>(),
      ),
      fenix: true,
    );
  }
}
