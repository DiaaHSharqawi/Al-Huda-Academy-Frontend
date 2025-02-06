import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/notification_controllers/notification_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/notification/notification_service.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationService>(() => NotificationService());

    Get.lazyPut<NotificationController>(
      () => NotificationController(
        Get.find<NotificationService>(),
      ),
    );
  }
}
