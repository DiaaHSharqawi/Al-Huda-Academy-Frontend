import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_supervisor_request_registration_details_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_supervisor_request_registration_details_service.dart';

class AdminSupervisorRequestRegistrationDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSupervisorRequestRegistrationDetailsService>(
        () => AdminSupervisorRequestRegistrationDetailsService());

    Get.lazyPut<AdminSupervisorRequestRegistrationDetailsController>(
      () => AdminSupervisorRequestRegistrationDetailsController(
        Get.find<AdminSupervisorRequestRegistrationDetailsService>(),
      ),
    );
  }
}
