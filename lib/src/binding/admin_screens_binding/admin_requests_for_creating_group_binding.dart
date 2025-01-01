import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_requests_for_creating_group_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_requests_for_creating_group_service.dart';

class AdminRequestsForCreatingGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRequestsForCreatingGroupService>(
        () => AdminRequestsForCreatingGroupService());

    Get.lazyPut<AdminRequestsForCreatingGroupController>(
      () => AdminRequestsForCreatingGroupController(
        Get.find<AdminRequestsForCreatingGroupService>(),
      ),
    );
  }
}
