import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_group_request_creation_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_group_request_creation_service.dart';

class AdminRequestedGroupDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminGroupRequestCreationService>(
      () => AdminGroupRequestCreationService(),
    );
    Get.lazyPut<AdminGroupRequestCreationController>(
      () => AdminGroupRequestCreationController(
        Get.find<AdminGroupRequestCreationService>(),
      ),
    );
  }
}
