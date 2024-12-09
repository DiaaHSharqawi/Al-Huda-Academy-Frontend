import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/athkar_controllers/athkar_categories_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/athkar/athkar_categories_service.dart';

class AthkarCategoriesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AthkarCategoriesService>(() => AthkarCategoriesService());
    Get.put<AthkarCategoriesController>(
        AthkarCategoriesController(Get.find<AthkarCategoriesService>()));
  }
}
