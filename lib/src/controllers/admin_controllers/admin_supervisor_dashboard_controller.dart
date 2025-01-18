import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_supervisor_dashboard_service.dart';

class AdminSupervisorDashboardController extends GetxController {
  final AdminSupervisorDashboardService _adminSupervisorDashboardService;
  AdminSupervisorDashboardController(
    this._adminSupervisorDashboardService,
  );

  void navigateToAdminSupervisorRequestsRegistrationScreen() {
    Get.toNamed(AppRoutes.adminSupervisorRequestsRegistration);
  }
}
