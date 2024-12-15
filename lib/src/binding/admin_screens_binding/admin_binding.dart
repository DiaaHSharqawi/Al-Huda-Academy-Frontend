import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_service.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminService>(
      () => AdminService(),
    );
    Get.lazyPut<AdminController>(
      () => AdminController(
        Get.find<AdminService>(),
      ),
    );
  }
}
