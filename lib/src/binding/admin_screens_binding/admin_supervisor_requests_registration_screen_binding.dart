import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_supervisor_requests_registration_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_supervisor_requests_registration_service.dart';

class AdminSupervisorRequestsRegistrationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSupervisorRequestsRegistrationService>(
      () => AdminSupervisorRequestsRegistrationService(),
    );
    Get.lazyPut<AdminSupervisorRequestsRegistrationController>(
      () => AdminSupervisorRequestsRegistrationController(
        Get.find<AdminSupervisorRequestsRegistrationService>(),
      ),
    );
  }
}
