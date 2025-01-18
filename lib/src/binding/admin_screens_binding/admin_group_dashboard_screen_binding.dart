import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_group_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_group_dashboard_service.dart';

class AdminGroupDashboardScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminGroupDashboardService>(() => AdminGroupDashboardService());

    Get.lazyPut<AdminGroupDashboardController>(
      () => AdminGroupDashboardController(
        Get.find<AdminGroupDashboardService>(),
      ),
    );
  }
}
