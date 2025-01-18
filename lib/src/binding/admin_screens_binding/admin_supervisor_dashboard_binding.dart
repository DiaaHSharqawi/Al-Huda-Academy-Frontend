import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_supervisor_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_supervisor_dashboard_service.dart';

class AdminSupervisorDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSupervisorDashboardService>(
        () => AdminSupervisorDashboardService());

    Get.lazyPut<AdminSupervisorDashboardController>(
      () => AdminSupervisorDashboardController(
        Get.find<AdminSupervisorDashboardService>(),
      ),
    );
  }
}
