import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_service.dart';

class AdminController extends GetxController {
  // ignore: unused_field
  final AdminService _adminService;
  AdminController(this._adminService);

  void navigateToAdminGroupDashboardScreen() {
    Get.toNamed(AppRoutes.adminGroupDashboard);
  }
}
