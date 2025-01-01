import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_group_dashboard_service.dart';

class AdminGroupDashboardController extends GetxController {
  final AdminGroupDashboardService _adminGroupDashboardService;

  AdminGroupDashboardController(this._adminGroupDashboardService);

  void navigateToRequestsForCreatingGroupScreen() {
    Get.toNamed(AppRoutes.adminRequestsForCreatingGroup);
  }
}
